// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncidentImpl _$$IncidentImplFromJson(Map<String, dynamic> json) =>
    _$IncidentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      severity: $enumDecode(_$SeverityEnumMap, json['severity']),
      sourceIp: json['sourceIp'] as String,
      targetSystem: json['targetSystem'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
      status: json['status'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      affectedUser: json['affectedUser'] as String?,
      eventCount: (json['eventCount'] as num).toInt(),
    );

Map<String, dynamic> _$$IncidentImplToJson(_$IncidentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'severity': _$SeverityEnumMap[instance.severity]!,
      'sourceIp': instance.sourceIp,
      'targetSystem': instance.targetSystem,
      'timestamp': instance.timestamp.toIso8601String(),
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
      'status': instance.status,
      'tags': instance.tags,
      'affectedUser': instance.affectedUser,
      'eventCount': instance.eventCount,
    };

const _$SeverityEnumMap = {
  Severity.critical: 'critical',
  Severity.high: 'high',
  Severity.medium: 'medium',
  Severity.low: 'low',
  Severity.info: 'info',
};

_$TimelineEventImpl _$$TimelineEventImplFromJson(Map<String, dynamic> json) =>
    _$TimelineEventImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      eventType: json['eventType'] as String,
      description: json['description'] as String,
      metadata: json['metadata'] as String?,
    );

Map<String, dynamic> _$$TimelineEventImplToJson(_$TimelineEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'eventType': instance.eventType,
      'description': instance.description,
      'metadata': instance.metadata,
    };

_$IncidentDetailImpl _$$IncidentDetailImplFromJson(Map<String, dynamic> json) =>
    _$IncidentDetailImpl(
      incident: Incident.fromJson(json['incident'] as Map<String, dynamic>),
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) => TimelineEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      analysisData: json['analysisData'] as Map<String, dynamic>?,
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$IncidentDetailImplToJson(
        _$IncidentDetailImpl instance) =>
    <String, dynamic>{
      'incident': instance.incident,
      'timeline': instance.timeline,
      'analysisData': instance.analysisData,
      'recommendations': instance.recommendations,
    };
