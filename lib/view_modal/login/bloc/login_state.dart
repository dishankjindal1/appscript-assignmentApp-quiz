part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LogoutSuccess extends LoginState {}

class LFailure extends LoginState {}

class LLoading extends LoginState {}

class LComplete extends LoginState {}
