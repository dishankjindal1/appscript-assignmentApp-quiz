part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  LoginInitial() {
    FirebaseAuth.instance.signOut();
  }
}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {}

class LoginLoading extends LoginState {}

class LogoutSuccess extends LoginState {}
