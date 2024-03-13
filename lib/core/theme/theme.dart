import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border({Color color = AppPallete.borderColor}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final darkThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(395, 55),
              shadowColor: AppPallete.transparentColor,
              backgroundColor: AppPallete.transparentColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero))),
      appBarTheme:
          const AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(27),
        enabledBorder: _border(),
        focusedErrorBorder: _border(color: AppPallete.errorColor),
        errorBorder: _border(color: AppPallete.errorColor),
        focusedBorder: _border(color: AppPallete.gradient2),
      ));
}
