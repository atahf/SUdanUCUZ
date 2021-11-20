import 'package:flutter/material.dart';
import 'package:project/design/ColorPalet.dart';
import 'package:google_fonts/google_fonts.dart';

final appBarText = GoogleFonts.raleway(
  fontWeight: FontWeight.w500,
  fontSize: 20,
);

final generalText = GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: ColorPalet.main
);

final mainBstyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(ColorPalet.main),
    backgroundColor: MaterialStateProperty.all(ColorPalet.buttonBack)
);

final semiTitlestyle = GoogleFonts.raleway(
  fontWeight: FontWeight.w700,
  fontSize: 24,
  color: ColorPalet.titleC,
);