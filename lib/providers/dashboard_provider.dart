import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/security_metric.dart';
import '../services/api_service.dart';
import 'auth_provider.dart';

class DashboardState {
  final DashboardMetrics? metrics;
  final bool isLoading;
  final String? error;
  final DateTime? lastUpdated;

  DashboardState({
    this.metrics,
    this.isLoading = false,
    this.error,
    this.lastUpdated,
  });

  DashboardState copyWith({
    DashboardMetrics? metrics,
    bool? isLoading,
    String? error,
    DateTime? lastUpdated,
  }) {
    return DashboardState(
      metrics: metrics ?? this.metrics,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return DashboardNotifier(ref, apiService);
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  final Ref ref;
  final ApiService apiService;

  DashboardNotifier(this.ref, this.apiService) : super(DashboardState()) {
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await apiService.get<Map<String, dynamic>>('/dashboard/stats');
      final data = response['data'] as Map<String, dynamic>;

      final incidents = data['incidents'] as Map<String, dynamic>? ?? {};
      final network = data['network'] as Map<String, dynamic>? ?? {};
      final predictions = data['predictions'] as Map<String, dynamic>? ?? {};
      final web = data['web'] as Map<String, dynamic>? ?? {};
      final mobile = data['mobile'] as Map<String, dynamic>? ?? {};

      final securityEvents = (web['security_events'] as num?)?.toInt() ?? 0;
      final systemHealth = (100.0 - (securityEvents * 2.5)).clamp(0.0, 100.0);
      final now = DateTime.now();

      final metrics = [
        SecurityMetric(
          id: '1',
          name: 'Open Incidents',
          value: (incidents['open'] as num?)?.toInt() ?? 0,
          threshold: 20,
          unit: 'count',
          timestamp: now,
          trend: 'stable',
          category: 'threats',
        ),
        SecurityMetric(
          id: '2',
          name: 'Critical Incidents',
          value: (incidents['critical'] as num?)?.toInt() ?? 0,
          threshold: 5,
          unit: 'count',
          timestamp: now,
          trend: 'up',
          category: 'threats',
        ),
        SecurityMetric(
          id: '3',
          name: 'Network Flows (24h)',
          value: (network['recent_flows_24h'] as num?)?.toInt() ?? 0,
          threshold: 500,
          unit: 'flows',
          timestamp: now,
          trend: 'stable',
          category: 'performance',
        ),
        SecurityMetric(
          id: '4',
          name: 'Web Security Events',
          value: securityEvents,
          threshold: 10,
          unit: 'count',
          timestamp: now,
          trend: securityEvents > 10 ? 'up' : 'stable',
          category: 'threats',
        ),
        SecurityMetric(
          id: '5',
          name: 'AI Predictions (24h)',
          value: (predictions['recent_24h'] as num?)?.toInt() ?? 0,
          threshold: 100,
          unit: 'count',
          timestamp: now,
          trend: 'stable',
          category: 'performance',
        ),
        SecurityMetric(
          id: '6',
          name: 'Mobile Events',
          value: (mobile['total_events'] as num?)?.toInt() ?? 0,
          threshold: 200,
          unit: 'count',
          timestamp: now,
          trend: 'stable',
          category: 'performance',
        ),
      ];

      state = state.copyWith(
        metrics: DashboardMetrics(
          activeAlerts: (incidents['critical'] as num?)?.toInt() ?? 0,
          openIncidents: (incidents['open'] as num?)?.toInt() ?? 0,
          threatsBlocked: (predictions['total'] as num?)?.toInt() ?? 0,
          systemHealth: systemHealth,
          metrics: metrics,
          lastUpdated: now,
        ),
        isLoading: false,
        lastUpdated: now,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'فشل تحميل بيانات لوحة القيادة: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Future<void> refreshDashboard() async {
    await _loadDashboardData();
  }
}
