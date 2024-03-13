import 'package:blog_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/auth/presentation/pages/signin_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Blog App',
          theme: AppTheme.darkThemeMode,
          home: child,
        );
      },
      child: const SignInPage(),
    );
  }
}



