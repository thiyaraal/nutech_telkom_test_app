import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';

class MyTextStyles {
  MyTextStyles._();
  static TextStyle titleTextSuperLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: ColorStyle.neutral600,
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  // Title Text Styles
  static TextStyle titleTextLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: ColorStyle.neutral600,
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
  static TextStyle titleTextMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorStyle.neutral600,
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  static TextStyle titleTextRegular = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: ColorStyle.neutral600,
      fontFamily: GoogleFonts.roboto().fontFamily);

  static TextStyle titleTextSmall = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: ColorStyle.neutral600,
      fontFamily: GoogleFonts.roboto().fontFamily);

  // Text Button Style
  static TextStyle textButton = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: ColorStyle.neutral100,
      fontFamily: GoogleFonts.roboto().fontFamily);

  // Hint Text Style
  static TextStyle hintText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w100,
      color: ColorStyle.neutral500,
      fontFamily: GoogleFonts.roboto().fontFamily);
  // Subtitle Text Style
  static TextStyle subTitleText = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: ColorStyle.neutral600,
      fontFamily: GoogleFonts.roboto().fontFamily);

  // Regular Text Styles
  static TextStyle regularText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: ColorStyle.neutral500,
      fontFamily: GoogleFonts.roboto().fontFamily);

  // Medium Text Style
  static TextStyle mediumText = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: ColorStyle.neutral900,
      fontFamily: GoogleFonts.roboto().fontFamily);

  static TextStyle boldRegulerText = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: ColorStyle.brand500,
      fontFamily: GoogleFonts.roboto().fontFamily);
}
