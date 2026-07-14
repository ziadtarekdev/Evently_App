import 'package:event_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData getLightTheme()=> ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: LightThemeColors.background,
      primaryColor: LightThemeColors.mainColor,
      appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.transparent,
          backgroundColor: LightThemeColors.background,
          foregroundColor: LightThemeColors.mainText,
        ),
      textTheme:TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),// 20.0 PX
          titleMedium:TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),//16 px
          bodyLarge:TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500
          ),// 18
          titleSmall:TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600
          ),// 14

  )
  );
  static ThemeData getDarkTheme()=>ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DarkThemeColors.background,
      primaryColor: DarkThemeColors.mainColor,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: DarkThemeColors.background,
        foregroundColor: DarkThemeColors.mainText,
      ),
      textTheme:TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),// 20.0 PX
        titleMedium:TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
        ),//16 px
        bodyLarge:TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500
        ),// 18
        titleSmall:TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600
        ),// 14

      )
  );
}