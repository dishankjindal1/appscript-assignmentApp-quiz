part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryDataRequested extends HistoryEvent {
  final List<HistoryDataModal> list;
  const HistoryDataRequested(this.list);
}

class HistoryClearRequested extends HistoryEvent {}
