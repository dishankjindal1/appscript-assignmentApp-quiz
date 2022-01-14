part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistoryDataRequested extends HistoryEvent {
  const HistoryDataRequested();
}

class HistoryClearRequested extends HistoryEvent {}
