import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

late BuildContext buildContext;

void setBuildContext(BuildContext context) {
  buildContext = context;
}

TextTheme textTheme = GoogleFonts.rubikTextTheme(
  Theme.of(buildContext).textTheme,
);

TextStyle h1 = TextStyle(
  fontSize: 96,
  fontWeight: FontWeight.w700,
);

TextStyle h2 = TextStyle(
  fontSize: 60,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.normal,
);

TextStyle h3 = TextStyle(
  fontSize: 48,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
);

TextStyle h4 = TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
);

TextStyle h5 = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
);

TextStyle h6 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

TextStyle subtitle1 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

TextStyle subtitle2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

TextStyle body1 = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

TextStyle body2 = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

TextStyle button = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

TextStyle caption = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

TextStyle overline = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);
