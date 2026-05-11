import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/security_metric.dart';
import '../services/api_service.dart';

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

final apiServiceProvider = Provider((ref) {
  return ApiService();
});

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
      // Mock data - replace with actual API call
      // final response = await apiService.get<Map<String, dynamic>>('/dashboard/metrics');

      final mockMetrics = DashboardMetrics(
        activeAlerts: 12,
        openIncidents: 5,
        threatsBlocked: 342,
        systemHealth: 89.5,
        metrics: [
          SecurityMetric(
            id: '1',
            name: 'CPU Usage',
            value: 45,
            threshold: 80,
            unit: '%',
            timestamp: DateTime.now(),
            trend: 'stable',
            category: 'performance',
          ),
          SecurityMetric(
            id: '2',
            name: 'Memory Usage',
            value: 62,
            threshold: 85,
            unit: '%',
            timestamp: DateTime.now(),
            trend: 'up',
            category: 'performance',
          ),
          SecurityMetric(
            id: '3',
            name: 'Network Traffic',
            value: 340,
            threshold: 500,
            unit: 'Mbps',
            timestamp: DateTime.now(),
            trend: 'stable',
            category: 'performance',
          ),
          SecurityMetric(
            id: '4',
            name: 'Threats Detected',
            value: 45,
            threshold: 10,
            unit: 'count',
            timestamp: DateTime.now(),
            trend: 'down',
            category: 'threats',
          ),
          SecurityMetric(
            id: '5',
            name: 'Failed Logins',
            value: 23,
            threshold: 5,
            unit: 'count',
            timestamp: DateTime.now(),
            trend: 'up',
            category: 'threats',
          ),
          SecurityMetric(
            id: '6',
            name: 'Compliance Score',
            value: 94,
            threshold: 90,
            unit: '%',
            timestamp: DateTime.now(),
            trend: 'stable',
            category: 'compliance',
          ),
        ],
        lastUpdated: DateTime.now(),
      );

      state = state.copyWith(
        metrics: mockMetrics,
        isLoading: false,
        lastUpdated: DateTime.now(),
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
