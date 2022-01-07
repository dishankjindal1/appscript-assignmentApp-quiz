import 'package:flutter/material.dart';
import 'package:quiz/view/login/login.view.dart';

class ViewMaterialApp extends MaterialApp {
  ViewMaterialApp({Key? key})
      : super(
          key: key,
          title: 'AppScript AssignmentApp Quiz',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': LoginView.page(),
            '/quiz': LoginView.page(),
          },
          // theme: ViewMaterialApp.lightThemeData,
        );

  static ThemeData lightThemeData = ThemeData.light();
}
