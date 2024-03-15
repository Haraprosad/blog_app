import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static _border({Color color = AppPallete.borderColor}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );
  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(395.w, 55.h),
              shadowColor: AppPallete.transparentColor,
              backgroundColor: AppPallete.transparentColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero))),
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      chipTheme: const ChipThemeData(
          color: MaterialStatePropertyAll(
            AppPallete.backgroundColor,
          ),
          side: BorderSide.none),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(27.w),
        enabledBorder: _border(),
        focusedErrorBorder: _border(color: AppPallete.errorColor),
        errorBorder: _border(color: AppPallete.errorColor),
        focusedBorder: _border(color: AppPallete.gradient2),
      ));
}
