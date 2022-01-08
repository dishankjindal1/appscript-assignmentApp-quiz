import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(FirebaseAuth.instance.currentUser == null
            ? LoginInitial()
            : LoginSuccess()) {
    on<LoginRequestedEvent>(_loginRequested);
    on<LogoutRequestedEvent>(_logoutRequested);
  }
  _loginRequested(LoginRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(LoginSuccess());
  }

  _logoutRequested(LogoutRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LLoading());

    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));

    emit(LogoutSuccess());
  }
}
