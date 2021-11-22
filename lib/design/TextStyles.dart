import 'package:flutter/material.dart';
import 'package:project/design/ColorPalet.dart';
import 'package:google_fonts/google_fonts.dart';

final appBarText = GoogleFonts.raleway(
  fontWeight: FontWeight.w600,
  fontSize: 24,
);

final generalTextStyle = GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorPalet.generalText,
    letterSpacing: 1
);

final mainBstyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(ColorPalet.generalText),
    backgroundColor: MaterialStateProperty.all(ColorPalet.buttonBack)
);

final semiTitlestyle = GoogleFonts.raleway(
  fontWeight: FontWeight.w700,
  fontSize: 24,
  color: ColorPalet.titleC,
);