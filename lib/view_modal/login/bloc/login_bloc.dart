import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(FirebaseAuth.instance.currentUser == null
            ? LoginInitial()
            : LoginSuccess(
                FirebaseAuth.instance.currentUser?.displayName ?? 'Error')) {
    on<LoginRequestedEvent>(_loginRequested);
    on<LogoutRequestedEvent>(_logoutRequested);
    on<LoginScoreRequestedEvent>(_loginScoreRequested);
  }
  _loginRequested(LoginRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LLoading());
    var userName =
        FirebaseAuth.instance.currentUser?.displayName ?? 'Error in username';
    await Future.delayed(const Duration(seconds: 1));
    emit(LoginSuccess(userName));
  }

  _logoutRequested(LogoutRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LLoading());

    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));

    emit(LogoutSuccess());
  }

  _loginScoreRequested(
      LoginScoreRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LLoading());
    var finalScore = event.score;
    emit(LoginSuccessScore(finalScore));
  }
}
