import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequestedEvent>(_loginRequested);
    on<LogoutRequestedEvent>(_logoutRequested);
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _loginRequested(LoginRequestedEvent event, Emitter<LoginState> emit) {
    emit(LoginLoading());

    try {
      if (_firebaseAuth.currentUser != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginInitial());
    }
  }

  _logoutRequested(LogoutRequestedEvent event, Emitter<LoginState> emit) {
    emit(LoginLoading());

    try {
      if (_firebaseAuth.currentUser == null) {
        emit(LogoutSuccess());
      } else {
        emit(LoginFailure());
      }
    } catch (e) {
      emit(LoginInitial());
    }
  }
}
