import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(const ProgressInitial(0)) {
    on<ProgressIcrement>((event, emit) {
      if (event.progress == 100) {
        emit(ProgressFinished());
      } else {
        emit(ProgressInitial(event.progress));
      }
    });
  }
}
