// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlertImpl _$$AlertImplFromJson(Map<String, dynamic> json) => _$AlertImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      severity: $enumDecode(_$SeverityEnumMap, json['severity']),
      alertType: json['alertType'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      sourceIp: json['sourceIp'] as String,
      affectedSystem: json['affectedSystem'] as String?,
      isRead: json['isRead'] as bool,
      actionUrl: json['actionUrl'] as String?,
    );

Map<String, dynamic> _$$AlertImplToJson(_$AlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'severity': _$SeverityEnumMap[instance.severity]!,
      'alertType': instance.alertType,
      'timestamp': instance.timestamp.toIso8601String(),
      'sourceIp': instance.sourceIp,
      'affectedSystem': instance.affectedSystem,
      'isRead': instance.isRead,
      'actionUrl': instance.actionUrl,
    };

const _$SeverityEnumMap = {
  Severity.critical: 'critical',
  Severity.high: 'high',
  Severity.medium: 'medium',
  Severity.low: 'low',
  Severity.info: 'info',
};
