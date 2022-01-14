import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz/modal/repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final CentralRepository _centralRepository;

  HistoryBloc(this._centralRepository) : super(HistoryClear()) {
    on<HistoryDataRequested>((event, emit) async {
      emit(HistoryClear());
      var historyList = <HistoryDataModal>[];
      await _centralRepository
          .getHistoryList()
          .then((value) => historyList = value)
          .whenComplete(() => emit(HistoryData(historyList)));
      // if (historyList.isEmpty) {
      // }
    });

    on<HistoryClearRequested>((event, emit) {
      emit(HistoryClear());
    });
  }
}
