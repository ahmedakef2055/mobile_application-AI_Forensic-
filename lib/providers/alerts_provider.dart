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
      // Mock data - replace with actual API call
      // final response = await apiService.get<List<dynamic>>('/alerts');

      final mockAlerts = [
        Alert(
          id: '1',
          title: 'Critical Security Alert',
          message: 'Unauthorized access attempt detected on Database Server',
          severity: Severity.critical,
          alertType: 'intrusion',
          timestamp: DateTime.now().subtract(Duration(minutes: 5)),
          sourceIp: '192.168.1.100',
          affectedSystem: 'Database Server',
          isRead: false,
          actionUrl: '/incidents/1',
        ),
        Alert(
          id: '2',
          title: 'High Priority Alert',
          message: 'Suspicious file upload detected in web directory',
          severity: Severity.high,
          alertType: 'malware',
          timestamp: DateTime.now().subtract(Duration(hours: 1)),
          sourceIp: '10.0.0.50',
          affectedSystem: 'Web Server',
          isRead: false,
          actionUrl: '/incidents/2',
        ),
        Alert(
          id: '3',
          title: 'Medium Priority Alert',
          message: 'Unusual network traffic pattern detected',
          severity: Severity.medium,
          alertType: 'network_anomaly',
          timestamp: DateTime.now().subtract(Duration(hours: 3)),
          sourceIp: '203.0.113.10',
          affectedSystem: 'Network Gateway',
          isRead: true,
          actionUrl: '/alerts/3',
        ),
        Alert(
          id: '4',
          title: 'Policy Violation Alert',
          message: 'User accessed restricted data folder',
          severity: Severity.low,
          alertType: 'policy_violation',
          timestamp: DateTime.now().subtract(Duration(hours: 6)),
          sourceIp: '192.168.1.55',
          affectedSystem: 'File Server',
          isRead: true,
          actionUrl: null,
        ),
      ];

      final unreadCount = mockAlerts.where((a) => !a.isRead).length;

      state = state.copyWith(
        alerts: mockAlerts,
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

  Future<void> markAsRead(String alertId) async {
    final updatedAlerts = state.alerts.map((alert) {
      if (alert.id == alertId) {
        return alert.copyWith(isRead: true);
      }
      return alert;
    }).toList();

    final unreadCount = updatedAlerts.where((a) => !a.isRead).length;

    state = state.copyWith(
      alerts: updatedAlerts,
      unreadCount: unreadCount,
    );

    // Send to API
    // await apiService.put('/alerts/$alertId/read');
  }

  Future<void> markAllAsRead() async {
    final updatedAlerts =
        state.alerts.map((alert) => alert.copyWith(isRead: true)).toList();

    state = state.copyWith(
      alerts: updatedAlerts,
      unreadCount: 0,
    );

    // Send to API
    // await apiService.put('/alerts/mark-all-read');
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
