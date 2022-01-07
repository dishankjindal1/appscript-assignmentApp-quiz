import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz/modal/repository.dart';
import 'package:quiz/view/view.dart';

class MainBlocProvider extends StatelessWidget {
  const MainBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CentralRepository(),
      child: ViewMaterialApp(),
    );
  }
}
