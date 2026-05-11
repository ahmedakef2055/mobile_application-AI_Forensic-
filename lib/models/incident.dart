import 'package:freezed_annotation/freezed_annotation.dart';
import 'severity.dart';

part 'incident.freezed.dart';
part 'incident.g.dart';

@freezed
class Incident with _$Incident {
  const factory Incident({
    required String id,
    required String title,
    required String description,
    required Severity severity,
    required String sourceIp,
    required String? targetSystem,
    required DateTime timestamp,
    required DateTime? resolvedAt,
    required String status, // open, investigating, resolved
    required List<String> tags,
    required String? affectedUser,
    required int eventCount,
  }) = _Incident;

  factory Incident.fromJson(Map<String, dynamic> json) =>
      _$IncidentFromJson(json);
}

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent({
    required String id,
    required DateTime timestamp,
    required String eventType,
    required String description,
    required String? metadata,
  }) = _TimelineEvent;

  factory TimelineEvent.fromJson(Map<String, dynamic> json) =>
      _$TimelineEventFromJson(json);
}

@freezed
class IncidentDetail with _$IncidentDetail {
  const factory IncidentDetail({
    required Incident incident,
    required List<TimelineEvent> timeline,
    required Map<String, dynamic>? analysisData,
    required List<String> recommendations,
  }) = _IncidentDetail;

  factory IncidentDetail.fromJson(Map<String, dynamic> json) =>
      _$IncidentDetailFromJson(json);
}
