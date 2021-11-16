import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  static const Color scaffold = Color(0xFFEFF4F6);
  static const Color primary = Color(0xFF287A8E);
  static const Color accent = Color(0xFFF4B100);
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF666666);
  static const Color appTitleTextColor = Color(0xFFFFFFFF);
  static const Color appTitleIconColor = Color(0xFFFFFFFF);
  static const Color primaryButtonTextColor = Color(0xFFFFFFFF);
}

getThemeDataTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.scaffold,
    primaryColor: AppColor.primary,
    textTheme: GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColor.accent),
  );
}
