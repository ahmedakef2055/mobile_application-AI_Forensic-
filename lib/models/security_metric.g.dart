// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecurityMetricImpl _$$SecurityMetricImplFromJson(Map<String, dynamic> json) =>
    _$SecurityMetricImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      threshold: (json['threshold'] as num?)?.toInt(),
      unit: json['unit'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      trend: json['trend'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$$SecurityMetricImplToJson(
        _$SecurityMetricImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'threshold': instance.threshold,
      'unit': instance.unit,
      'timestamp': instance.timestamp.toIso8601String(),
      'trend': instance.trend,
      'category': instance.category,
    };

_$DashboardMetricsImpl _$$DashboardMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$DashboardMetricsImpl(
      activeAlerts: (json['activeAlerts'] as num).toInt(),
      openIncidents: (json['openIncidents'] as num).toInt(),
      threatsBlocked: (json['threatsBlocked'] as num).toInt(),
      systemHealth: (json['systemHealth'] as num).toDouble(),
      metrics: (json['metrics'] as List<dynamic>)
          .map((e) => SecurityMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$DashboardMetricsImplToJson(
        _$DashboardMetricsImpl instance) =>
    <String, dynamic>{
      'activeAlerts': instance.activeAlerts,
      'openIncidents': instance.openIncidents,
      'threatsBlocked': instance.threatsBlocked,
      'systemHealth': instance.systemHealth,
      'metrics': instance.metrics,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
