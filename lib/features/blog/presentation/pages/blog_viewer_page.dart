import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Viewer'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Text(
                  "By ${blog.posterName}",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  "${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(content: blog.content)} min",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: AppPallete.greyColor,
                  ),
                ),
                blog.imageUrl != "" ? SizedBox(height: 20.h) : const SizedBox(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: blog.imageUrl != ""
                      ? Image.network(blog.imageUrl)
                      : const SizedBox(),
                ),
                SizedBox(height: 20.h),
                Text(
                  blog.content,
                  style: TextStyle(fontSize: 16.sp, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
