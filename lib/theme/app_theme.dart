import 'package:flutter/material.dart';
import 'package:zzzmart/res/colors.dart';

class AppTheme {
  AppTheme._();

  static Color _iconColor = MyColors.white;

  static const Color _lightPrimaryColor = MyColors.darkBlue;
  static const Color _lightPrimaryVariantColor = MyColors.lightBlue;
  static const Color _lightOnPrimaryColor = MyColors.white;
  static const Color _lightSecondaryColor = MyColors.yellow;
  static const Color _lightGreyColor = MyColors.lightGrey;
  static const Color _lightBrightColor = MyColors.darkGrey;
  static const Color _lightTextColor = MyColors.black;
  static const Color _lightTextVariantColor = MyColors.lightBlack;

  static final TextStyle _lightScreenHeadingTextStyle =
      TextStyle(fontSize: 32.0, color: _lightPrimaryVariantColor);
  static final TextStyle _lightSubHeadingTextStyle =
      TextStyle(fontSize: 18.0, color: _lightBrightColor);
  static final TextStyle _lightAppBarHeadingTextStyle = TextStyle(
      fontSize: 20.0, color: _lightOnPrimaryColor, fontWeight: FontWeight.w700);
  static final TextStyle _lightScreenTaskNameTextStyle = TextStyle(
      fontSize: 20.0,
      color: _lightTextVariantColor,
      fontWeight: FontWeight.w500);
  static final TextStyle _lightScreenTaskDurationTextStyle =
      TextStyle(fontSize: 16.0, color: _lightTextColor);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightOnPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _lightPrimaryColor,
      iconTheme: IconThemeData(
        color: _lightOnPrimaryColor,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: _lightBrightColor,
      background: _lightPrimaryColor,
      surface: _lightGreyColor,
      onSurface: _lightGreyColor,
//        brightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: _lightPrimaryColor, size: 24),
    textTheme: _lightTextTheme,
    disabledColor: _lightBrightColor,
    dialogBackgroundColor: _lightPrimaryVariantColor,
    accentColor: _lightPrimaryColor,
    cardTheme: CardTheme(elevation: 2, color: _lightOnPrimaryColor),
    backgroundColor: _lightOnPrimaryColor,
    splashFactory: InkRipple.splashFactory,
    dividerColor: Colors.grey.withOpacity(0.3),
    // pageTransitionsTheme: PageTransitionsTheme(builders: {
    //   TargetPlatform.iOS: PageTransitionsBuilder,
    //   TargetPlatform.android: FadeTransitionBuilder(),
    // }),
  );

  static final TextTheme _lightTextTheme = TextTheme(
      headline5: _lightScreenHeadingTextStyle,
      bodyText2: _lightScreenTaskNameTextStyle,
      bodyText1: _lightScreenTaskDurationTextStyle,
      headline1: _lightAppBarHeadingTextStyle,
      headline2: _lightSubHeadingTextStyle,
      caption: _lightScreenTaskDurationTextStyle);
}
