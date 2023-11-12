// ignore_for_file: prefer_conditional_assignment, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';

class ColorManager {
  static final ColorManager _instace = ColorManager._init();
  static ColorManager get instance {
    return _instace;
  }

  ColorManager._init();

  Color get white => const Color(0xffffffff);
  Color get green => const Color(0xFF36DC82);
  Color get black => const Color(0xff000000);
  Color get softGray => const Color(0xFF737272);
  Color get darkGray => const Color(0xFF616161);
  Color get transparent => const Color(0x00000000);
  Color get borderGray => const Color(0xffDEDEDE);
  Color get grayBorder => const Color(0xFFF0F0F0);
  Color get grayBorder2 => const Color(0xFF9B9B9B);
  Color get softBorder => const Color(0xFFEEEEEE);
  Color get grayText => const Color(0xFF6E6E6E);
  Color get selectedGreen => const Color(0xFF49D93D);
  Color get red => const Color(0xFFDF2626);
  Color get spin1 => const Color(0xff3A1078);
  Color get spin2 => const Color(0xffE96479);
  Color get spin3 => const Color(0xff820000);
  Color get spin4 => const Color(0xffE90064);
  Color get spin5 => const Color(0xffF9F54B);
  Color get spin6 => const Color(0xff698269);
  Color get scratch_background => const Color(0xff383838);
  Color get code_background => const Color(0xfff3f3f3);
  Color get primary => const Color(0xffFFFBF5);
  Color get secondary => const Color(0xffF7EFE5);
  Color get third => const Color(0xffC3ACD0);
  Color get fourth => const Color(0xffffab51);
  Color get snackbarGreen => const Color(0xff9DC08B);

  MaterialColor get materialBlack => const MaterialColor(
        0xff000000,
        <int, Color>{
          50: Colors.black,
          100: Colors.black,
          200: Colors.black,
          300: Colors.black,
          400: Colors.black,
          500: Colors.black,
          600: Colors.black,
          700: Colors.black,
          800: Colors.black,
          900: Colors.black,
        },
      );
}
