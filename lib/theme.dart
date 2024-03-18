import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final appColorLightProvider = Provider<AppColor>((ref) => AppColor(
    greenish: greenish,
    purpleish: purpleish,
    redish: redish,
    yellowish: yellowish,
    blackish: blackish,
    greyish: greyish,
    whiteish: whiteish,
    blueish: blueish,
    orangish: orangish));

class AppColor {
  MaterialColor greenish;
  MaterialColor purpleish;
  MaterialColor redish;
  MaterialColor blackish;
  MaterialColor greyish;
  MaterialColor yellowish;
  MaterialColor orangish;
  MaterialColor blueish;

  MaterialColor whiteish;
  AppColor({
    required this.greenish,
    required this.redish,
    required this.blackish,
    required this.greyish,
    required this.yellowish,
    required this.whiteish,
    required this.orangish,
    required this.purpleish,
    required this.blueish,
  });
}

//-------------------------------------------------------
ThemeData lightThemeData = ThemeData(
  fontFamily: GoogleFonts.cairo().fontFamily,
  colorScheme: colorSchemeLight,
  textTheme: textThemeLight,
  primaryColor: greenish,
  scaffoldBackgroundColor: whiteish,
  primaryTextTheme: textThemeLight,
  splashColor: whiteish,
  unselectedWidgetColor: redish,
  canvasColor: purpleish,
  dialogBackgroundColor: whiteish,
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: greenish,
    selectionHandleColor: greenish,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: greenish,
    alignedDropdown: true,
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return greenish;
        }
        return blackish;
      },
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    textStyle: textThemeLight.labelSmall!.copyWith(color: redish),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: greenish,
        hintStyle: textThemeLight.labelSmall!.copyWith(color: redish),
        labelStyle: textThemeLight.labelSmall!.copyWith(color: redish),
        helperStyle: textThemeLight.labelSmall!.copyWith(color: redish)),
  ),
  inputDecorationTheme: InputDecorationTheme(
      hintStyle: textThemeLight.labelSmall!.copyWith(color: redish),
      helperStyle: textThemeLight.labelSmall!.copyWith(color: redish),
      labelStyle: textThemeLight.labelSmall!.copyWith(color: redish)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedLabelStyle: textThemeLight.labelSmall,
    unselectedLabelStyle: textThemeLight.labelSmall,
    elevation: 0,
    backgroundColor: Colors.white,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedItemColor: blackish,
    unselectedItemColor: blackish.shade100,
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: const IconThemeData(color: blackish),
    unselectedIconTheme: IconThemeData(color: blackish.shade100),
  ),
);

TextTheme textThemeLight = const TextTheme(
  //headline 1
  titleLarge: TextStyle(
    color: blackish,
    fontSize: 70,
    fontWeight: FontWeight.bold,
    height: 1.25,
  ),
  //headline 2
  titleMedium: TextStyle(
    color: blackish,
    fontSize: 22,
    fontWeight: FontWeight.w300,
    height: 1.22,
  ),
  //headlin 3
  titleSmall: TextStyle(
    fontWeight: FontWeight.bold,
    // fontSize: 48,
    height: 1.25,
    color: blackish,
  ),
  //Headline 4
  displayLarge: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 36,
    height: 1.5,
    color: blackish,
  ),
  displayMedium: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 28,
    height: 1.5,
    color: blackish,
  ),
  displaySmall: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 1.2,
    color: blackish,
  ),
  //Headline 5
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.14,
    color: blackish,
  ),
  //Headline 6
  bodyLarge: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.14,
    color: blackish,
  ),

  //Paragraph

  labelLarge: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: blackish,
    height: 1.19,
  ),
  labelSmall: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: blackish,
    height: 1.2,
  ),
  bodySmall: TextStyle(
    fontSize: 14,
    height: 1.2,
    fontWeight: FontWeight.w400,
    color: blackish,
  ),
);

//------------------------------------------------------------
//Color Scheme
//light
var colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: redish,
  onPrimary: blackish,
  secondary: orangish,
  onSecondary: whiteish.shade100, //white
  error: redish,
  onError: redish,
  background: greenish,
  onBackground: greenish.shade100,
  onSurface: blackish, surface: blackish,
);

const yellowish = MaterialColor(0xffF8B95C, {});

const redish = MaterialColor(0xffed1c24, {
  100: Color(0xffA01313),
  200: Color(0xffFF3F3F),
  300: Color(0xffFF0000),
});
const whiteish = MaterialColor(0xffFFFFFF, {
  100: Color(0xffffffff),
  200: Color(0xffF3F5F7),
});
const blackish = MaterialColor(0xff000000, {
  100: Color(0xff222222),
});
const greyish = MaterialColor(0xffCDCDCD, {
  100: Color(0xff344054),
  200: Color(0xffDDDDDD),
  300: Color(0xffF2F2F2),
  400: Color(0xff878787),
  500: Color(0xffD9D9D9),
  600: Color(0xffE9E9E9),
  700: Color(0xffD0D5DD),
  800: Color(0xffDDDDDD)
});
const blueish = MaterialColor(0xff1DA1F2, {
  100: Color(0xff0E2087),
  200: Color(0xff98A6F9),
  300: Color(0xfff4f4fd),
  400: Color(0xffE6E0E9),
  900: Color(0xff0E2087),
});

const greenish = MaterialColor(0xff0f8385, {
  100: Color(0xff106060),
  200: Color(0xff279fa0),
  300: Color(0xff50E9C1),
  400: Color(0xff73F270)
});
const orangish = MaterialColor(0xfff26522, {
  100: Color(0xfff5821f),
  200: Color(0xfffbab34),
});

const purpleish = MaterialColor(0xffB5B1F6, {
  100: Color(0xff152270),
  200: Color(0xfff0effd),
});
