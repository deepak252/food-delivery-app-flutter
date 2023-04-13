import 'package:flutter/material.dart';

abstract class Themes{
  static const ffamily1="Poppins";
  static const ffamily2="Lato";
  
  static const colorPrimary=Color(0xFFEA7B0C);
  // static const colorSecondary=Color(0xFFFFA53E);
  static const black100=Color(0xFFF6F6F6);
  static const black200=Color(0xFFA0A0A0);
  static const black300=Color(0xFF757575);
  static const black400=Color(0xFF474747);
  static const black500=Color(0xFF353535);
  static const black600=Color(0xFF202020);

  static const backgroundColor=black100;

  // static MaterialColor materialColorSecondary = const MaterialColor(
  //   0xFF422383,
  //   <int, Color>{
  //     50: Color(0xFF422383),
  //     100: Color(0xFF422383),
  //     200: Color(0xFF422383),
  //     300: Color(0xFF422383),
  //     400: Color(0xFF422383),
  //     500: Color(0xFF422383),
  //     600: Color(0xFF422383),
  //     700: Color(0xFF422383),
  //     800: Color(0xFF422383),
  //     900: Color(0xFF422383),
  //   },
  // );

  // static MaterialColor materialColorPrimary = const MaterialColor(
  //   0xFFFFA53E,
  //   <int, Color>{
  //     50: Color(0xFFFFA53E),
  //     100: Color(0xFFFFA53E),
  //     200: Color(0xFFFFA53E),
  //     300: Color(0xFFFFA53E),
  //     400: Color(0xFFFFA53E),
  //     500: Color(0xFFFFA53E),
  //     600: Color(0xFFFFA53E),
  //     700: Color(0xFFFFA53E),
  //     800: Color(0xFFFFA53E),
  //     900: Color(0xFFFFA53E),
  //   },
  // );


  static const _textTheme = TextTheme(
    bodyText2: TextStyle( //Text widget,
      fontSize : 16
    ),
    subtitle1:  TextStyle(  //TextField text/hint text,
      fontFamily: ffamily2,
    ),
  );
  static final _iconTheme =  IconThemeData(
    color: black600.withOpacity(0.8),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: black600,
        fontWeight: FontWeight.w600,
        fontFamily: ffamily1,
        fontSize: 18
      ),
      iconTheme: IconThemeData(
        color: black600,
        size: 22
      )
    ),
    colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: colorPrimary, //appbar
      secondary: colorPrimary,
    ),
    primaryColor: colorPrimary,
    buttonTheme: const ButtonThemeData(
      buttonColor: colorPrimary,
      disabledColor: Colors.grey,
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontFamily: ffamily2,
        color: black600.withOpacity(0.5)
      ),
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent, 
          width: 1.0
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.transparent, 
          width: 1.0
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: black300, 
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(8)
      ),
      errorStyle: TextStyle(
        color: Colors.red[400],
        fontSize: 13,
      ),
      labelStyle: const TextStyle(
        color: black300, 
      ),
      errorMaxLines: 4,
    ),   
    iconTheme: _iconTheme,
    textTheme: _textTheme,
    fontFamily: ffamily1,
    listTileTheme: ListTileThemeData(
      iconColor: black600.withOpacity(0.9),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: black600,
      labelStyle: TextStyle(
        fontSize: 15,
        fontFamily: ffamily1
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontFamily: ffamily1
      ),
    )
    
  );
}