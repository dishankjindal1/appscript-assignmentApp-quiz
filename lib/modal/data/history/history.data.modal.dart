import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history.data.modal.g.dart';

@JsonSerializable()
class HistoryDataModal extends Equatable {
  final String score;
  final String timestamp;

  const HistoryDataModal({required this.score, required this.timestamp});

  factory HistoryDataModal.fromJson(Map<String, dynamic> json) =>
      _$HistoryDataModalFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDataModalToJson(this);

  @override
  List<Object?> get props => [score, timestamp];
}
