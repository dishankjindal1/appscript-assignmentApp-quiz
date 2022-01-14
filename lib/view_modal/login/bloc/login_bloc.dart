import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/modal/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final CentralRepository _centralRepository;

  LoginBloc(this._centralRepository) : super(LoginInitial()) {
    on<LoginEventRequested>(_loginRequested);
    on<LogoutEventRequested>(_logoutRequested);
    on<LoginScoreRequestedEvent>(_loginScoreRequested);
  }

  _loginRequested(LoginEventRequested event, Emitter<LoginState> emit) async {
    emit(LoadingState());

    await _centralRepository.firebaseUserAuth.then((value) => value);

    emit(LoginSuccess());
  }

  _logoutRequested(LogoutEventRequested event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    await _centralRepository.signout();
    emit(LogoutSuccess());
  }

  _loginScoreRequested(
      LoginScoreRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    var finalScore = event.score;
    emit(LoginSuccessScore(finalScore));
  }
}
