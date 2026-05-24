import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/alert.dart';
import '../models/severity.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

class AlertsState {
  final List<Alert> alerts;
  final bool isLoading;
  final String? error;
  final int unreadCount;

  AlertsState({
    this.alerts = const [],
    this.isLoading = false,
    this.error,
    this.unreadCount = 0,
  });

  AlertsState copyWith({
    List<Alert>? alerts,
    bool? isLoading,
    String? error,
    int? unreadCount,
  }) {
    return AlertsState(
      alerts: alerts ?? this.alerts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}

final alertsProvider =
    StateNotifierProvider<AlertsNotifier, AlertsState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AlertsNotifier(ref, apiService);
});

class AlertsNotifier extends StateNotifier<AlertsState> {
  final Ref ref;
  final ApiService apiService;

  AlertsNotifier(this.ref, this.apiService) : super(AlertsState()) {
    _loadAlerts();
  }

  Future<void> _loadAlerts() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await apiService.get<Map<String, dynamic>>('/alerts');
      final list = response['data'] as List<dynamic>? ?? [];

      final alerts = list.map((item) => _alertFromApi(item as Map<String, dynamic>)).toList();
      final unreadCount = alerts.where((a) => !a.isRead).length;

      state = state.copyWith(
        alerts: alerts,
        unreadCount: unreadCount,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'فشل تحميل التنبيهات: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Alert _alertFromApi(Map<String, dynamic> json) {
    final message = json['message'] as String? ?? '';
    final incidentId = json['incident_id'];
    final createdAt = json['created_at'] as String?;
    return Alert(
      id: json['id']?.toString() ?? '0',
      title: message.length > 60 ? '${message.substring(0, 60)}…' : message,
      message: message,
      severity: Severity.medium,
      alertType: json['channel'] as String? ?? 'web',
      timestamp: createdAt != null ? DateTime.parse(createdAt) : DateTime.now(),
      sourceIp: '',
      affectedSystem: null,
      isRead: json['delivered_at'] != null,
      actionUrl: incidentId != null ? '/incidents/$incidentId' : null,
    );
  }

  Future<void> markAsRead(String alertId) async {
    final updatedAlerts = state.alerts.map((alert) {
      if (alert.id == alertId) return alert.copyWith(isRead: true);
      return alert;
    }).toList();

    state = state.copyWith(
      alerts: updatedAlerts,
      unreadCount: updatedAlerts.where((a) => !a.isRead).length,
    );

    try {
      await apiService.post<Map<String, dynamic>>('/alerts/$alertId/delivered');
    } catch (_) {}
  }

  Future<void> markAllAsRead() async {
    final updatedAlerts =
        state.alerts.map((alert) => alert.copyWith(isRead: true)).toList();
    state = state.copyWith(alerts: updatedAlerts, unreadCount: 0);
  }

  void filterBySeverity(Severity severity) {
    final filtered = state.alerts
        .where((alert) => alert.severity == severity)
        .toList();
    state = state.copyWith(alerts: filtered);
  }

  void filterByType(String type) {
    final filtered = state.alerts
        .where((alert) => alert.alertType == type)
        .toList();
    state = state.copyWith(alerts: filtered);
  }

  Future<void> refreshAlerts() async {
    await _loadAlerts();
  }
}
