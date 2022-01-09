import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/modal/data/data.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryClear()) {
    on<HistoryDataRequested>((event, emit) async {
      emit(HistoryClear());
      var list = event.list;
      emit(HistoryData(list));
    });
    on<HistoryClearRequested>((event, emit) {
      emit(HistoryClear());
    });
  }
}
