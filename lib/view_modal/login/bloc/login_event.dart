part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventRequested extends LoginEvent {
}

class LogoutEventRequested extends LoginEvent {}

class LoginScoreRequestedEvent extends LoginEvent {
  final int score;
  const LoginScoreRequestedEvent(this.score);
}
