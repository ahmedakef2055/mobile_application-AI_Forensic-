import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_metric.freezed.dart';
part 'security_metric.g.dart';

@freezed
class SecurityMetric with _$SecurityMetric {
  const factory SecurityMetric({
    required String id,
    required String name,
    required int value,
    required int? threshold,
    required String unit,
    required DateTime timestamp,
    required String trend, // up, down, stable
    required String category, // threats, performance, compliance
  }) = _SecurityMetric;

  factory SecurityMetric.fromJson(Map<String, dynamic> json) =>
      _$SecurityMetricFromJson(json);
}

@freezed
class DashboardMetrics with _$DashboardMetrics {
  const factory DashboardMetrics({
    required int activeAlerts,
    required int openIncidents,
    required int threatsBlocked,
    required double systemHealth,
    required List<SecurityMetric> metrics,
    required DateTime lastUpdated,
  }) = _DashboardMetrics;

  factory DashboardMetrics.fromJson(Map<String, dynamic> json) =>
      _$DashboardMetricsFromJson(json);
}
