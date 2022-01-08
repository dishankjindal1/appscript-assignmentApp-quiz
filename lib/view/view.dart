import 'package:flutter/material.dart';
import 'package:quiz/view/login/login.view.dart';
import 'package:quiz/view/quiz/quiz.view.dart';

class ViewMaterialApp extends MaterialApp {
  ViewMaterialApp({Key? key})
      : super(
          key: key,
          title: 'AppScript AssignmentApp Quiz',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': LoginView.page(),
            '/quiz': QuizView.page(),
          },
          // theme: ViewMaterialApp.lightThemeData,
        );

  static ThemeData lightThemeData = ThemeData.light();
}
