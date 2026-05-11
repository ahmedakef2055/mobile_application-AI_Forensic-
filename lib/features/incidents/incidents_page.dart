import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../providers/settings_provider.dart';
import 'incident_detail_page.dart';

class IncidentsPage extends ConsumerStatefulWidget {
  const IncidentsPage({super.key});
  static const routePath = '/incidents';

  @override
  ConsumerState<IncidentsPage> createState() => _IncidentsPageState();
}

class _IncidentsPageState extends ConsumerState<IncidentsPage> {
  int selectedTabIndex = 0;

  final incidents = <_IncidentItem>[
    _IncidentItem(
      code: 'INC-01',
      title: 'Brute Force Attack',
      subtitle: 'Tap to view details',
      severity: _Severity.high,
    ),
    _IncidentItem(
      code: 'INC-02',
      title: 'SQL Injection',
      subtitle: 'Tap to view details',
      severity: _Severity.high,
    ),
    _IncidentItem(
      code: 'INC-03',
      title: 'DDoS Attack',
      subtitle: 'Tap to view details',
      severity: _Severity.high,
    ),
    _IncidentItem(
      code: 'INC-04',
      title: 'Malware Detection',
      subtitle: 'Tap to view details',
      severity: _Severity.medium,
    ),
    _IncidentItem(
      code: 'INC-05',
      title: 'Phishing Attempt',
      subtitle: 'Tap to view details',
      severity: _Severity.high,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    final settings = ref.watch(settingsProvider);
    String t(String k) => AppStrings.get(k, settings.locale);

    final tabs = [
      t('incidents.tab.all'),
      t('incidents.tab.open'),
      t('incidents.tab.in_progress'),
      t('incidents.tab.resolved'),
    ];

    return Scaffold(
      appBar: AppBarWidget(
        title: t('incidents.title'),
        subtitle: 'عرض الحوادث الأمنية المكتشفة',
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_p.bgTop, _p.bgBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),

              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _TabsRow(
                  tabs: tabs,
                  selectedIndex: selectedTabIndex,
                  onTap: (i) => setState(() => selectedTabIndex = i),
                ),
              ),

              const SizedBox(height: 12),

              // List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: incidents.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index == incidents.length) {
                      return _FooterInfo(
                        attentionLabel:
                            '${incidents.length} ${t('incidents.footer.attention')}',
                        updatedLabel: t('incidents.footer.updated'),
                      );
                    }
                    final item = incidents[index];
                    return _IncidentCard(
                      item: item,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const IncidentDetailPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- Tabs ---------------- */

class _TabsRow extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _TabsRow({
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isSel = i == selectedIndex;
          return _TabButton(
            label: tabs[i],
            isSelected: isSel,
            onTap: () => onTap(i),
          );
        },
      ),
    );
  }
}

/* ----------- Tab Button ----------- */

class _TabButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<_TabButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8 + (_isPressed ? 2 : 0),
        ),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? AppColors.primary.withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: widget.isSelected ? AppColors.primary : _p.border,
            width: widget.isSelected ? 1.4 : 1,
          ),
          boxShadow: [
            if (_isPressed)
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
                spreadRadius: 1,
              ),
          ],
        ),
        child: Center(
          child: AnimatedScale(
            scale: _isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Text(
              widget.label,
              style: TextStyle(
                color: widget.isSelected ? AppColors.primary : _p.mutedText,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* ----------- Incident Card ----------- */

class _IncidentCard extends StatefulWidget {
  final _IncidentItem item;
  final VoidCallback onTap;

  const _IncidentCard({
    required this.item,
    required this.onTap,
  });

  @override
  State<_IncidentCard> createState() => _IncidentCardState();
}

class _IncidentCardState extends State<_IncidentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 - (_controller.value * 0.05),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(
                color: _p.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isPressed
                      ? widget.item.severity.accent
                      : _p.border,
                  width: _isPressed ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.item.severity.accent
                        .withValues(alpha: _isPressed ? 0.3 : 0.0),
                    blurRadius: 16,
                    offset: Offset(0, _isPressed ? 8 : 0),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left accent line with animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 48 + (_isPressed ? 8 : 0),
                    width: 3 + (_isPressed ? 1 : 0),
                    decoration: BoxDecoration(
                      color: widget.item.severity.accent,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: [
                        if (_isPressed)
                          BoxShadow(
                            color: widget.item.severity.accent
                                .withValues(alpha: 0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${widget.item.code} - ${widget.item.title}',
                                style: TextStyle(
                                  color: _p.text,
                                  fontSize: 13.2,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _SeverityBadge(
                              severity: widget.item.severity,
                              isPressed: _isPressed,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.item.subtitle,
                          style: TextStyle(
                            color: _p.mutedText,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SeverityBadge extends StatelessWidget {
  final _Severity severity;
  final bool isPressed;
  const _SeverityBadge({required this.severity, this.isPressed = false});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6 + (isPressed ? 2 : 0),
      ),
      decoration: BoxDecoration(
        color: severity.badgeBg,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          if (isPressed)
            BoxShadow(
              color: severity.badgeBg.withValues(alpha: 0.4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
        ],
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

/* ---------------- Footer Info ---------------- */

class _FooterInfo extends StatelessWidget {
  final String attentionLabel;
  final String updatedLabel;

  const _FooterInfo({
    required this.attentionLabel,
    required this.updatedLabel,
  });

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.border),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded,
              color: _p.mutedText, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attentionLabel,
                  style: TextStyle(
                    color: _p.text,
                    fontSize: 12.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  updatedLabel,
                  style: TextStyle(
                    color: _p.mutedText,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/* ---------------- Model ---------------- */

class _IncidentItem {
  final String code;
  final String title;
  final String subtitle;
  final _Severity severity;

  const _IncidentItem({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.severity,
  });
}

enum _Severity { high, medium }

extension on _Severity {
  String get label {
    switch (this) {
      case _Severity.high:
        return 'High';
      case _Severity.medium:
        return 'Medium';
    }
  }

  Color get badgeBg {
    switch (this) {
      case _Severity.high:
        return const Color(0x33FF9A3C);
      case _Severity.medium:
        return const Color(0x33FFD54A);
    }
  }

  Color get badgeText {
    switch (this) {
      case _Severity.high:
        return const Color(0xFFFFA04D);
      case _Severity.medium:
        return const Color(0xFFFFD34D);
    }
  }

  Color get accent {
    switch (this) {
      case _Severity.high:
        return const Color(0xFFFFA04D);
      case _Severity.medium:
        return const Color(0xFFFFD34D);
    }
  }
}