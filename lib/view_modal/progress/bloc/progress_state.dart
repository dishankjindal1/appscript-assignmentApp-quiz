part of 'progress_bloc.dart';

abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object> get props => [];
}

class ProgressInitial extends ProgressState {
  final int progress;
  const ProgressInitial(this.progress);
}

class ProgressFinished extends ProgressState {}
