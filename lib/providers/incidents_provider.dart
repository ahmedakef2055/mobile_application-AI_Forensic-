import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/incident.dart';
import '../models/severity.dart';
import '../services/api_service.dart';

class IncidentsState {
  final List<Incident> incidents;
  final bool isLoading;
  final String? error;
  final Incident? selectedIncident;
  final IncidentDetail? selectedDetail;

  IncidentsState({
    this.incidents = const [],
    this.isLoading = false,
    this.error,
    this.selectedIncident,
    this.selectedDetail,
  });

  IncidentsState copyWith({
    List<Incident>? incidents,
    bool? isLoading,
    String? error,
    Incident? selectedIncident,
    IncidentDetail? selectedDetail,
  }) {
    return IncidentsState(
      incidents: incidents ?? this.incidents,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedIncident: selectedIncident ?? this.selectedIncident,
      selectedDetail: selectedDetail ?? this.selectedDetail,
    );
  }
}

final incidentsProvider =
    StateNotifierProvider<IncidentsNotifier, IncidentsState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return IncidentsNotifier(ref, apiService);
});

class IncidentsNotifier extends StateNotifier<IncidentsState> {
  final Ref ref;
  final ApiService apiService;

  IncidentsNotifier(this.ref, this.apiService) : super(IncidentsState()) {
    _loadIncidents();
  }

  Future<void> _loadIncidents() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await apiService.get<Map<String, dynamic>>('/incidents');
      final list = response['data'] as List<dynamic>? ?? [];

      final incidents = list
          .map((item) => _incidentFromApi(item as Map<String, dynamic>))
          .toList();

      state = state.copyWith(incidents: incidents, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: 'فشل تحميل الحوادث: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Incident _incidentFromApi(Map<String, dynamic> json) {
    final createdAt = json['created_at'] as String?;
    final closedAt = json['closed_at'] as String?;
    final severityLevel = json['severity_level'] as String? ?? '';
    return Incident(
      id: (json['incident_id'] ?? json['id'])?.toString() ?? '0',
      title: json['type'] as String? ?? 'Unknown',
      description: 'Severity score: ${json['severity_score'] ?? 0}',
      severity: _severityFromString(severityLevel),
      sourceIp: '',
      targetSystem: null,
      timestamp: createdAt != null ? DateTime.parse(createdAt) : DateTime.now(),
      resolvedAt: closedAt != null ? DateTime.parse(closedAt) : null,
      status: json['status'] as String? ?? 'open',
      tags: [],
      affectedUser: null,
      eventCount: (json['severity_score'] as num?)?.toInt() ?? 0,
    );
  }

  Severity _severityFromString(String level) {
    switch (level.toLowerCase()) {
      case 'critical': return Severity.critical;
      case 'high': return Severity.high;
      case 'medium': return Severity.medium;
      case 'low': return Severity.low;
      default: return Severity.info;
    }
  }

  Future<void> loadIncidentDetail(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Find the incident
      final incident = state.incidents.firstWhere((i) => i.id == id);

      // Mock timeline data
      final timeline = [
        TimelineEvent(
          id: '1',
          timestamp: incident.timestamp,
          eventType: 'detection',
          description: 'Initial threat detection',
          metadata: 'IDS alert triggered',
        ),
        TimelineEvent(
          id: '2',
          timestamp: incident.timestamp.add(Duration(minutes: 5)),
          eventType: 'analysis',
          description: 'Automated analysis started',
          metadata: 'AI model analyzing patterns',
        ),
        TimelineEvent(
          id: '3',
          timestamp: incident.timestamp.add(Duration(minutes: 15)),
          eventType: 'escalation',
          description: 'Escalated to security team',
          metadata: 'Alert sent to on-call analyst',
        ),
      ];

      final detail = IncidentDetail(
        incident: incident,
        timeline: timeline,
        analysisData: {
          'threat_score': 95,
          'confidence': 98,
          'pattern_match': 'known_attack_vector',
        },
        recommendations: [
          'Block source IP immediately',
          'Review account access logs',
          'Force password reset for affected user',
          'Enable MFA for all admin accounts',
        ],
      );

      state = state.copyWith(
        selectedIncident: incident,
        selectedDetail: detail,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'فشل تحميل تفاصيل الحادثة: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  Future<void> refreshIncidents() async {
    await _loadIncidents();
  }

  void filterByStatus(String status) {
    final filtered = state.incidents
        .where((incident) => incident.status == status)
        .toList();
    state = state.copyWith(incidents: filtered);
  }

  void filterBySeverity(Severity severity) {
    final filtered = state.incidents
        .where((incident) => incident.severity == severity)
        .toList();
    state = state.copyWith(incidents: filtered);
  }
}
