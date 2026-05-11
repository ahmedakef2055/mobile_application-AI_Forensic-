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
      // Mock data - replace with actual API call
      // final response = await apiService.get<List<dynamic>>('/incidents');

      final mockIncidents = [
        Incident(
          id: '1',
          title: 'Unauthorized Access Attempt',
          description: 'Multiple failed login attempts detected from suspicious IP',
          severity: Severity.critical,
          sourceIp: '192.168.1.100',
          targetSystem: 'Database Server',
          timestamp: DateTime.now().subtract(Duration(hours: 2)),
          resolvedAt: null,
          status: 'open',
          tags: ['intrusion', 'authentication'],
          affectedUser: 'admin@company.com',
          eventCount: 15,
        ),
        Incident(
          id: '2',
          title: 'Suspicious File Upload',
          description: 'Executable file detected in user upload directory',
          severity: Severity.high,
          sourceIp: '10.0.0.50',
          targetSystem: 'Web Server',
          timestamp: DateTime.now().subtract(Duration(hours: 5)),
          resolvedAt: DateTime.now().subtract(Duration(hours: 1)),
          status: 'resolved',
          tags: ['malware', 'suspicious-file'],
          affectedUser: 'user@company.com',
          eventCount: 8,
        ),
        Incident(
          id: '3',
          title: 'DDoS Attack Detected',
          description: 'Large volume of traffic detected from multiple sources',
          severity: Severity.critical,
          sourceIp: '203.0.113.0/24',
          targetSystem: 'API Server',
          timestamp: DateTime.now().subtract(Duration(minutes: 30)),
          resolvedAt: null,
          status: 'investigating',
          tags: ['ddos', 'network'],
          affectedUser: null,
          eventCount: 5000,
        ),
        Incident(
          id: '4',
          title: 'Privilege Escalation Attempt',
          description: 'User attempted to access restricted resources',
          severity: Severity.medium,
          sourceIp: '192.168.1.55',
          targetSystem: 'Application Server',
          timestamp: DateTime.now().subtract(Duration(hours: 12)),
          resolvedAt: DateTime.now().subtract(Duration(hours: 10)),
          status: 'resolved',
          tags: ['privilege-escalation', 'access-control'],
          affectedUser: 'user2@company.com',
          eventCount: 3,
        ),
        Incident(
          id: '5',
          title: 'Data Exfiltration Detected',
          description: 'Unusual data transfer volume detected',
          severity: Severity.high,
          sourceIp: '172.16.0.20',
          targetSystem: 'Database Server',
          timestamp: DateTime.now().subtract(Duration(hours: 8)),
          resolvedAt: null,
          status: 'investigating',
          tags: ['data-breach', 'exfiltration'],
          affectedUser: 'admin@company.com',
          eventCount: 42,
        ),
      ];

      state = state.copyWith(
        incidents: mockIncidents,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'فشل تحميل الحوادث: ${e.toString()}',
        isLoading: false,
      );
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
