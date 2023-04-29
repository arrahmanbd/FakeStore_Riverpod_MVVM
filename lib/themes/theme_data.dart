import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';

  final ThemeData lightTheme = ThemeData(
    // useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryDark,
    appBarTheme:  const AppBarTheme(
      color: AppColors.primaryDark,
      iconTheme: IconThemeData(color: AppColors.grey_10),
    ),
    cardColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );

 final ThemeData darkTheme = ThemeData(
  // useMaterial3: true,
    scaffoldBackgroundColor: AppColors.appBackgroundColorDark,
    highlightColor: AppColors.appBackgroundColorDark,
    appBarTheme: const AppBarTheme(
      color: AppColors.appBackgroundColorDark,
      iconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    ),
    primaryColor: AppColors.primaryDark,
    cardColor: Color.fromARGB(255, 45, 62, 70),
    iconTheme: IconThemeData(color: AppColors.grey_60),
    textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
 
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
    }),
  );
