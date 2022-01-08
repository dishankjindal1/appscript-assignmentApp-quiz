part of 'progress_bloc.dart';

abstract class ProgressEvent extends Equatable {
  const ProgressEvent();

  @override
  List<Object> get props => [];
}

class ProgressIcrement extends ProgressEvent {
  final int progress;
  const ProgressIcrement(this.progress);
}
