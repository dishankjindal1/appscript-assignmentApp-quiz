import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/repository.dart';
import 'package:quiz/view/view.dart';

class MainBlocProvider extends StatelessWidget {
  const MainBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CentralRepository(
          serverUrl:
              'https://opentdb.com/api.php?amount=10&category=27&type=multiple&encode=base64'),
      child: ViewMaterialApp(),
    );
  }
}
