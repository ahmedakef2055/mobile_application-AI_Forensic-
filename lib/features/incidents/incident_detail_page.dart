import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/auth_provider.dart';

class IncidentData {
  final String id;
  final String title;
  final String description;
  final String code;
  final String severityLabel;
  final String target;
  final String source;
  final String time;
  final String status;

  const IncidentData({
    required this.id,
    required this.title,
    required this.description,
    required this.code,
    required this.severityLabel,
    this.target = '—',
    this.source = '—',
    this.time = '—',
    this.status = 'open',
  });
}

class IncidentDetailPage extends ConsumerStatefulWidget {
  final IncidentData data;

  const IncidentDetailPage({super.key, required this.data});
  static const routePath = '/incident-detail';

  @override
  ConsumerState<IncidentDetailPage> createState() => _IncidentDetailPageState();
}

class _IncidentDetailPageState extends ConsumerState<IncidentDetailPage> {
  int tabIndex = 0;
  bool _blockingAttacker = false;
  bool _exportingLogs = false;

  IncidentData get data => widget.data;

  Future<void> _openWebReport(BuildContext context) async {
    final uri = Uri.parse('http://localhost:5173/incidents/${data.id}');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open — make sure the web app is running on port 5173'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _blockAttacker() async {
    if (_blockingAttacker) return;
    setState(() => _blockingAttacker = true);
    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.post<Map<String, dynamic>>(
        '/block-list',
        data: {
          'incident_id': data.id,
          'target_type': 'ip',
          'target_value': data.source,
          'mode': 'permanent',
        },
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Attacker blocked successfully'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color(0xFF4ADE80),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Admin privileges required to block attackers'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _blockingAttacker = false);
    }
  }

  Future<void> _exportLogs() async {
    if (_exportingLogs) return;
    setState(() => _exportingLogs = true);
    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.get<Map<String, dynamic>>(
        '/incidents/${data.id}/reports',
      );
      if (mounted) {
        final reports = response['data'] as List? ?? [];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(reports.isEmpty
                ? 'No reports available for this incident'
                : '${reports.length} report(s) found. Opening latest...'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not fetch incident reports'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _exportingLogs = false);
    }
  }

  void _comingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature — coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final sev = _severityFromLabel(data.severityLabel);
    return Scaffold(
      backgroundColor: p.background,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(
              title: 'Incident Detail',
              subtitle: 'Security incident analysis',
              onBack: () => Navigator.pop(context),
              onShare: () {},
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _HeroCard(
                      severity: sev,
                      title: data.title,
                      description: data.description,
                      code: data.code,
                    ),
                    const SizedBox(height: 12),
                    _InfoRow(
                      target: data.target,
                      source: data.source,
                      time: data.time,
                    ),
                    const SizedBox(height: 14),
                    _Tabs(
                      index: tabIndex,
                      onChanged: (i) => setState(() => tabIndex = i),
                    ),
                    const SizedBox(height: 14),
                    if (tabIndex == 0) _TimelineTab(data: data),
                    if (tabIndex == 1) _DetailsTab(data: data),
                    if (tabIndex == 2) _ActionsTab(
                      onFirewall: () => _comingSoon('Firewall rule'),
                      onPasswordReset: () => _comingSoon('Force password reset'),
                      onExportLogs: _exportLogs,
                      isExporting: _exportingLogs,
                    ),
                    const SizedBox(height: 20),
                    _DangerButton(
                      text: _blockingAttacker ? 'Blocking...' : 'Block Attacker',
                      icon: Icons.block_rounded,
                      onPressed: _blockAttacker,
                    ),
                    const SizedBox(height: 10),
                    _SecondaryButton(
                      text: 'View Full Report on Web',
                      icon: Icons.open_in_browser_rounded,
                      onPressed: () => _openWebReport(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ─────────────── Top Bar ─────────────── */

class _TopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final VoidCallback onShare;

  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 6, 8, 6),
      decoration: BoxDecoration(
        color: p.background,
        border: Border(bottom: BorderSide(color: p.border.withValues(alpha: 0.6))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: p.text),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: p.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: p.mutedText,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onShare,
            icon: Icon(Icons.ios_share_rounded, color: p.mutedText, size: 20),
          ),
        ],
      ),
    );
  }
}

/* ─────────────── Hero Card ─────────────── */

class _HeroCard extends StatelessWidget {
  final _Severity severity;
  final String title;
  final String description;
  final String code;

  const _HeroCard({
    required this.severity,
    required this.title,
    required this.description,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: severity.heroGradient,
        ),
        boxShadow: [
          BoxShadow(
            color: severity.accent.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: severity.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: severity.accent.withValues(alpha: 0.3),
                  ),
                ),
                child: Icon(severity.icon, size: 16, color: severity.accent),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: severity.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: severity.accent.withValues(alpha: 0.35),
                  ),
                ),
                child: Text(
                  severity.label.toUpperCase(),
                  style: TextStyle(
                    color: severity.accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              code,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ─────────────── Info Row ─────────────── */

class _InfoRow extends StatelessWidget {
  final String target;
  final String source;
  final String time;

  const _InfoRow({required this.target, required this.source, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _InfoTile(
            icon: Icons.my_location_rounded,
            label: 'Target',
            value: target,
            iconColor: const Color(0xFF6C8EF5),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _InfoTile(
            icon: Icons.person_outline_rounded,
            label: 'Source',
            value: source,
            iconColor: const Color(0xFFFFA04D),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _InfoTile(
            icon: Icons.access_time_rounded,
            label: 'Time',
            value: time,
            iconColor: const Color(0xFF4ADE80),
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(11, 10, 11, 11),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: p.mutedText,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: p.text,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

/* ─────────────── Tabs ─────────────── */

class _Tabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const _Tabs({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.border),
      ),
      child: Row(
        children: [
          _TabItem(label: 'Actions', selected: index == 2, onTap: () => onChanged(2)),
          _TabItem(label: 'Details', selected: index == 1, onTap: () => onChanged(1)),
          _TabItem(label: 'Timeline', selected: index == 0, onTap: () => onChanged(0)),
        ].map((t) => Expanded(child: t)).toList(),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabItem({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 38,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : p.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

/* ─────────────── Timeline Tab ─────────────── */

class _TimelineTab extends StatelessWidget {
  final IncidentData data;
  const _TimelineTab({required this.data});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final events = [
      (time: data.time, text: 'Incident detected: ${data.title}'),
      (time: data.time, text: data.description),
      if (data.status == 'closed')
        (time: data.time, text: 'Incident closed'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.event_note_rounded, size: 15, color: p.mutedText),
            const SizedBox(width: 7),
            Text(
              'Event Timeline',
              style: TextStyle(color: p.text, fontSize: 13.5, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...events.asMap().entries.map((e) => _TimelineItem(
              time: e.value.time,
              text: e.value.text,
              isFirst: e.key == 0,
              isLast: e.key == events.length - 1,
            )),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String time;
  final String text;
  final bool isFirst;
  final bool isLast;

  const _TimelineItem({
    required this.time,
    required this.text,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(width: 2, color: p.border),
                    ),
                  ),
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.trending_up_rounded,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(width: 2, color: p.border),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                decoration: BoxDecoration(
                  color: p.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: p.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: p.text,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ─────────────── Details Tab ─────────────── */

class _DetailsTab extends StatelessWidget {
  final IncidentData data;
  const _DetailsTab({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailBox(
          icon: Icons.summarize_rounded,
          title: 'Incident Summary',
          body: data.description.isNotEmpty ? data.description : 'No summary available.',
        ),
        const SizedBox(height: 10),
        _DetailBox(
          icon: Icons.info_outline_rounded,
          title: 'Status',
          body: 'Status: ${data.status.toUpperCase()}',
        ),
        const SizedBox(height: 10),
        const _DetailBox(
          icon: Icons.lightbulb_outline_rounded,
          title: 'Recommendation',
          body: 'Review access logs, enforce MFA for privileged users, '
              'and ensure rate limiting is enabled across all gateways.',
        ),
      ],
    );
  }
}

class _DetailBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _DetailBox({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.primary),
              const SizedBox(width: 7),
              Text(
                title,
                style: TextStyle(
                  color: p.text,
                  fontSize: 12.8,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              color: p.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

/* ─────────────── Actions Tab ─────────────── */

class _ActionsTab extends StatelessWidget {
  final VoidCallback onFirewall;
  final VoidCallback onPasswordReset;
  final VoidCallback onExportLogs;
  final bool isExporting;

  const _ActionsTab({
    required this.onFirewall,
    required this.onPasswordReset,
    required this.onExportLogs,
    required this.isExporting,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActionRow(
          icon: Icons.shield_outlined,
          iconColor: const Color(0xFFFF6B6B),
          title: 'Add rule to firewall',
          subtitle: 'Block source IP permanently',
          onTap: onFirewall,
        ),
        const SizedBox(height: 10),
        _ActionRow(
          icon: Icons.lock_reset_rounded,
          iconColor: const Color(0xFFFFA04D),
          title: 'Force password reset',
          subtitle: 'Reset affected account credentials',
          onTap: onPasswordReset,
        ),
        const SizedBox(height: 10),
        _ActionRow(
          icon: isExporting ? Icons.hourglass_top_rounded : Icons.download_rounded,
          iconColor: const Color(0xFF4ADE80),
          title: isExporting ? 'Fetching reports...' : 'Export incident logs',
          subtitle: 'Download full timeline report',
          onTap: isExporting ? () {} : onExportLogs,
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: p.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: p.border),
        ),
        child: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 18, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: p.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: p.mutedText,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: p.mutedText, size: 20),
          ],
        ),
      ),
    );
  }
}

/* ─────────────── Buttons ─────────────── */

class _DangerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _DangerButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.block_rounded, size: 18),
        label: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _SecondaryButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return SizedBox(
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 17, color: p.text),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: p.text,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: p.border, width: 1.2),
          backgroundColor: p.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

/* ─────────────── Severity ─────────────── */

_Severity _severityFromLabel(String label) {
  final s = label.toLowerCase();
  if (s.contains('critical')) return _Severity.critical;
  if (s.contains('high')) return _Severity.high;
  if (s.contains('medium')) return _Severity.medium;
  return _Severity.low;
}

enum _Severity { critical, high, medium, low }

extension on _Severity {
  String get label {
    switch (this) {
      case _Severity.critical: return 'Critical';
      case _Severity.high:     return 'High';
      case _Severity.medium:   return 'Medium';
      case _Severity.low:      return 'Low';
    }
  }

  IconData get icon {
    switch (this) {
      case _Severity.critical: return Icons.shield_outlined;
      case _Severity.high:     return Icons.warning_amber_rounded;
      case _Severity.medium:   return Icons.report_gmailerrorred_rounded;
      case _Severity.low:      return Icons.info_outline_rounded;
    }
  }

  Color get accent {
    switch (this) {
      case _Severity.critical: return const Color(0xFFFF6B6B);
      case _Severity.high:     return const Color(0xFFFFA04D);
      case _Severity.medium:   return const Color(0xFFFFD34D);
      case _Severity.low:      return const Color(0xFF4ADE80);
    }
  }

  List<Color> get heroGradient {
    switch (this) {
      case _Severity.critical:
        return const [Color(0xFF3D0C14), Color(0xFF1F0A18)];
      case _Severity.high:
        return const [Color(0xFF3D1F0A), Color(0xFF1F1208)];
      case _Severity.medium:
        return const [Color(0xFF3D310A), Color(0xFF1F1C08)];
      case _Severity.low:
        return const [Color(0xFF0A3D1F), Color(0xFF081F12)];
    }
  }
}
