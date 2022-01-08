part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginRequestedEvent extends LoginEvent {}

class LoginScoreRequestedEvent extends LoginEvent {
  final Map<String, dynamic> data;
  const LoginScoreRequestedEvent(this.data);
}

class LogoutRequestedEvent extends LoginEvent {}
