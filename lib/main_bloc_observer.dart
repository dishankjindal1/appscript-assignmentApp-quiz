import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

class MainBlocObserver extends BlocObserver {
  var logger = Logger();
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.i('Change on ${bloc.runtimeType}\n$change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('Change on ${bloc.runtimeType}\n$error\n$stackTrace');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i('Event on ${bloc.runtimeType}\n$event');
  }
}
