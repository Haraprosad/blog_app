import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog,required GetAllBlogs getAllBlogs}) : _uploadBlog = uploadBlog,
  _getAllBlogs=getAllBlogs, super(BlogInitial()) {
    on<BlogEvent>((event, emit)=> emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onGetAllBlogs);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadBlogParams(
      image: event.image,
      title: event.title,
      content: event.content,
      posterId: event.posterId,
      topics: event.topics,
    ));
    result.fold(
      (failure) => emit(BlogFailure(message: failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlogs(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final result = await _getAllBlogs(NoParams());
    result.fold(
      (failure) => emit(BlogFailure(message: failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs: blogs)),
    );
  }

}
