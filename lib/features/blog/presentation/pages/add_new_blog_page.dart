import 'dart:io';
import 'dart:ui';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];

  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(BlogUpload(
          image: image!,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          topics: selectedTopics,
          posterId: posterId));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: uploadBlog, icon: const Icon(Icons.done_rounded))
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.message);
            }else if(state is BlogUploadSuccess){
              Navigator.pushAndRemoveUntil(context,BlogPage.route(),(route)=>false);
            }
          },
          builder: (context, state) {
            if(state is BlogLoading){
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    GestureDetector(
                      onTap: selectImage,
                      child: image == null
                          ? DottedBorder(
                              color: AppPallete.borderColor,
                              dashPattern: const [10, 4],
                              radius: Radius.circular(10),
                              strokeCap: StrokeCap.round,
                              borderType: BorderType.RRect,
                              child: Container(
                                height: 150.h,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40.w,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    Text(
                                      "Select Your Image",
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 150.h,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Technology',
                          'Business',
                          'Programming',
                          'Entertainment',
                        ]
                            .map((e) => Padding(
                                  padding: EdgeInsets.all(5.0.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedTopics.contains(e)
                                          ? selectedTopics.remove(e)
                                          : selectedTopics.add(e);
                                      setState(() {});
                                    },
                                    child: Chip(
                                      label: Text(e),
                                      color: selectedTopics.contains(e)
                                          ? const MaterialStatePropertyAll(
                                              AppPallete.gradient1)
                                          : null,
                                      side: selectedTopics.contains(e)
                                          ? null
                                          : const BorderSide(
                                              color: AppPallete.borderColor,
                                              width: 1),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlogEditor(
                        controller: titleController, hintText: "Blog Title"),
                    SizedBox(
                      height: 20.h,
                    ),
                    BlogEditor(
                        controller: contentController,
                        hintText: "Blog Content"),
                  ]),
                ),
              ),
            );
          },
        ));
  }
}
