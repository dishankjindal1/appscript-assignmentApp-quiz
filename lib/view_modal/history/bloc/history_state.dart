part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryData extends HistoryState {
  final List<HistoryDataModal> list;
  const HistoryData([this.list = const <HistoryDataModal>[]]);
}

class HistoryClear extends HistoryState {}
