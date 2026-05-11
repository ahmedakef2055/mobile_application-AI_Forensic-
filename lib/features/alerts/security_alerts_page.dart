import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../incidents/incident_detail_page.dart';

class SecurityAlertsPage extends StatefulWidget {
  const SecurityAlertsPage({super.key});
  static const routePath = '/security-alerts';

  @override
  State<SecurityAlertsPage> createState() => _SecurityAlertsPageState();
}

class _SecurityAlertsPageState extends State<SecurityAlertsPage> {
  final filters = const ['All', 'Critical', 'High', 'Medium', 'Low'];
  String selectedFilter = 'All';

  final timeRanges = const ['Last 24 hours', 'Last 7 days', 'Last 30 days'];
  String selectedRange = 'Last 24 hours';

  final alerts = <_AlertItem>[
    _AlertItem(
      title: 'Brute Force Attack Detected',
      source: 'DB-Server-01',
      minutesAgo: 2,
      severity: _Severity.critical,
    ),
    _AlertItem(
      title: 'Suspicious Login Activity',
      source: 'Web-Gateway-03',
      minutesAgo: 5,
      severity: _Severity.high,
    ),
    _AlertItem(
      title: 'Unusual Data Transfer',
      source: 'File-Server-02',
      minutesAgo: 12,
      severity: _Severity.medium,
    ),
    _AlertItem(
      title: 'Failed Authentication Attempt',
      source: 'API-Gateway-01',
      minutesAgo: 18,
      severity: _Severity.low,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = alerts.where((a) {
      if (selectedFilter == 'All') return true;
      return a.severity.label.toLowerCase() == selectedFilter.toLowerCase();
    }).toList();

    final counts = _Counts.from(alerts);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgTop, AppColors.bgBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _TopBar(
                title: 'Security Alerts',
                subtitle: 'Real-time monitoring',
                onBack: () => Navigator.pop(context),
                onSearch: () {},
                onBell: () {},
              ),
              const SizedBox(height: 14),

              // Chips
              SizedBox(
                height: 40,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    final label = filters[i];
                    final selected = label == selectedFilter;
                    final sev = _severityFromLabel(label);
                    return _FilterChip(
                      label: label,
                      selected: selected,
                      severity: sev,
                      onTap: () => setState(() => selectedFilter = label),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: filters.length,
                ),
              ),

              const SizedBox(height: 12),

              // Time range row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _TimeRangeDropdown(
                  value: selectedRange,
                  items: timeRanges,
                  onChanged: (v) => setState(() => selectedRange = v),
                ),
              ),

              const SizedBox(height: 12),

              // List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => _AlertCard(
                    item: filtered[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const IncidentDetailPage(),
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom summary
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: _BottomSummary(counts: counts),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final VoidCallback onSearch;
  final VoidCallback onBell;

  const _TopBar({
    required this.title,
    required this.subtitle,
    required this.onBack,
    required this.onSearch,
    required this.onBell,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: AppColors.text),
          ),
          const SizedBox(width: 4),
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(Icons.shield_outlined,
                color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onSearch,
            icon: const Icon(Icons.search, color: AppColors.text),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: onBell,
                icon: const Icon(Icons.notifications_none_rounded,
                    color: AppColors.text),
              ),
              Positioned(
                right: 12,
                top: 10,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final _Severity? severity;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.severity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? (severity?.chipBg ?? AppColors.card)
        : const Color(0x14000000);
    final border = selected ? Colors.transparent : AppColors.border;
    final textColor = selected ? (severity?.chipText ?? AppColors.text) : AppColors.mutedText;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _TimeRangeDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _TimeRangeDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_alt_outlined,
              size: 18, color: AppColors.mutedText),
          const SizedBox(width: 8),
          const Text(
            'Time Range:',
            style: TextStyle(
              color: AppColors.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: const Color(0xFF0B1220),
                iconEnabledColor: AppColors.mutedText,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 12.8,
                  fontWeight: FontWeight.w700,
                ),
                items: items
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final _AlertItem item;
  final VoidCallback onTap;
  const _AlertCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                _SeverityBadge(severity: item.severity),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.circle, size: 6, color: AppColors.mutedText),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.source,
                    style: const TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 12.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${item.minutesAgo} min ago',
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SeverityBadge extends StatelessWidget {
  final _Severity severity;
  const _SeverityBadge({required this.severity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: severity.badgeBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        severity.label,
        style: TextStyle(
          color: severity.badgeText,
          fontSize: 11.5,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _BottomSummary extends StatelessWidget {
  final _Counts counts;
  const _BottomSummary({required this.counts});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MiniStat(
            count: counts.critical,
            label: 'Critical',
            severity: _Severity.critical,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MiniStat(
            count: counts.high,
            label: 'High',
            severity: _Severity.high,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MiniStat(
            count: counts.medium,
            label: 'Medium',
            severity: _Severity.medium,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _MiniStat(
            count: counts.low,
            label: 'Low',
            severity: _Severity.low,
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  final int count;
  final String label;
  final _Severity severity;

  const _MiniStat({
    required this.count,
    required this.label,
    required this.severity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$count',
              style: TextStyle(
                color: severity.numberColor,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.mutedText,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------- Models & helpers -------------------- */

_Severity? _severityFromLabel(String label) {
  switch (label.toLowerCase()) {
    case 'critical':
      return _Severity.critical;
    case 'high':
      return _Severity.high;
    case 'medium':
      return _Severity.medium;
    case 'low':
      return _Severity.low;
    default:
      return null;
  }
}

class _AlertItem {
  final String title;
  final String source;
  final int minutesAgo;
  final _Severity severity;

  const _AlertItem({
    required this.title,
    required this.source,
    required this.minutesAgo,
    required this.severity,
  });
}

class _Counts {
  final int critical;
  final int high;
  final int medium;
  final int low;

  const _Counts({
    required this.critical,
    required this.high,
    required this.medium,
    required this.low,
  });

  factory _Counts.from(List<_AlertItem> list) {
    int c = 0, h = 0, m = 0, l = 0;
    for (final a in list) {
      switch (a.severity) {
        case _Severity.critical:
          c++;
          break;
        case _Severity.high:
          h++;
          break;
        case _Severity.medium:
          m++;
          break;
        case _Severity.low:
          l++;
          break;
      }
    }
    return _Counts(critical: c, high: h, medium: m, low: l);
  }
}

enum _Severity {
  critical,
  high,
  medium,
  low,
}

extension on _Severity {
  String get label {
    switch (this) {
      case _Severity.critical:
        return 'Critical';
      case _Severity.high:
        return 'High';
      case _Severity.medium:
        return 'Medium';
      case _Severity.low:
        return 'Low';
    }
  }

  // Chips (top)
  Color get chipBg {
    switch (this) {
      case _Severity.critical:
        return const Color(0xFF4B1F1F);
      case _Severity.high:
        return const Color(0xFF4A2F1A);
      case _Severity.medium:
        return const Color(0xFF4A3E16);
      case _Severity.low:
        return const Color(0xFF163D2A);
    }
  }

  Color get chipText {
    switch (this) {
      case _Severity.critical:
        return const Color(0xFFFF6B6B);
      case _Severity.high:
        return const Color(0xFFFFA04D);
      case _Severity.medium:
        return const Color(0xFFFFD34D);
      case _Severity.low:
        return const Color(0xFF4ADE80);
    }
  }

  // Badges (inside cards)
  Color get badgeBg {
    switch (this) {
      case _Severity.critical:
        return const Color(0x33FF4D4D);
      case _Severity.high:
        return const Color(0x33FF9A3C);
      case _Severity.medium:
        return const Color(0x33FFD54A);
      case _Severity.low:
        return const Color(0x334ADE80);
    }
  }

  Color get badgeText {
    switch (this) {
      case _Severity.critical:
        return const Color(0xFFFF6B6B);
      case _Severity.high:
        return const Color(0xFFFFA04D);
      case _Severity.medium:
        return const Color(0xFFFFD34D);
      case _Severity.low:
        return const Color(0xFF4ADE80);
    }
  }

  // Bottom numbers
  Color get numberColor {
    switch (this) {
      case _Severity.critical:
        return const Color(0xFFFF6B6B);
      case _Severity.high:
        return const Color(0xFFFFA04D);
      case _Severity.medium:
        return const Color(0xFFFFD34D);
      case _Severity.low:
        return const Color(0xFF4ADE80);
    }
  }
}