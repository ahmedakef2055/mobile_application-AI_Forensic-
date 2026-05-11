import 'package:freezed_annotation/freezed_annotation.dart';
import 'severity.dart';

part 'alert.freezed.dart';
part 'alert.g.dart';

@freezed
class Alert with _$Alert {
  const factory Alert({
    required String id,
    required String title,
    required String message,
    required Severity severity,
    required String alertType, // intrusion, malware, policy_violation, etc
    required DateTime timestamp,
    required String sourceIp,
    required String? affectedSystem,
    required bool isRead,
    required String? actionUrl,
  }) = _Alert;

  factory Alert.fromJson(Map<String, dynamic> json) => _$AlertFromJson(json);
}
