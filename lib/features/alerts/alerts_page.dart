import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_toast.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../models/severity.dart';
import '../../models/alert.dart';
import '../../providers/alerts_provider.dart';
import '../../providers/settings_provider.dart';

class AlertsPage extends ConsumerStatefulWidget {
  static const routePath = '/alerts';

  const AlertsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends ConsumerState<AlertsPage> {
  Severity? _selectedSeverity;

  @override
  Widget build(BuildContext context) {
    final alertsState = ref.watch(alertsProvider);
    final settings = ref.watch(settingsProvider);
    final p = c(context);
    String t(String k) => AppStrings.get(k, settings.locale);

    final List<Alert> filtered = _selectedSeverity == null
        ? List<Alert>.from(alertsState.alerts)
        : alertsState.alerts
            .where((a) => a.severity == _selectedSeverity)
            .toList();

    return Scaffold(
      backgroundColor: p.background,
      appBar: AppBarWidget(
        title: t('alerts.title'),
        subtitle: t('alerts.subtitle'),
        showSearch: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildFilterBar(p, alertsState.alerts, settings.locale),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState(p)
                  : _buildAlertsList(p, filtered, settings.locale),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar(AppPalette p, List<Alert> allAlerts, AppLocale locale) {
    final filters = <_FilterEntry>[
      _FilterEntry(
        label: AppStrings.get('alerts.filter.all', locale),
        severity: null,
        count: allAlerts.length,
        color: p.primary,
        icon: Icons.all_inbox_rounded,
      ),
      for (final s in Severity.values)
        _FilterEntry(
          label: AppStrings.get(_severityKey(s), locale),
          severity: s,
          count: allAlerts.where((a) => a.severity == s).length,
          color: _severityColor(s),
          icon: _severityIcon(s),
        ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: p.background,
        border: Border(
          bottom: BorderSide(color: p.border, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 14),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: filters.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final f = filters[index];
            return _FilterPill(
              entry: f,
              isSelected: _selectedSeverity == f.severity,
              onTap: () {
                setState(() {
                  _selectedSeverity = f.severity;
                });
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppPalette p) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: p.card,
              shape: BoxShape.circle,
              border: Border.all(color: p.border),
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 44,
              color: p.mutedText,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            ref.tr('alerts.empty'),
            style: TextStyle(
                color: p.text, fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            ref.tr('alerts.empty.sub'),
            style: TextStyle(color: p.mutedText, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsList(AppPalette p, List<Alert> alerts, AppLocale locale) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return _AlertCard(
          alert: alert,
          locale: locale,
          onMarkRead: () {
            ref.read(alertsProvider.notifier).markAsRead(alert.id);
            AppToast.show(
              context,
              message: ref.tr('alerts.marked'),
              kind: AppToastKind.success,
            );
          },
        );
      },
    );
  }

  static String _severityKey(Severity s) {
    switch (s) {
      case Severity.critical:
        return 'sev.critical';
      case Severity.high:
        return 'sev.high';
      case Severity.medium:
        return 'sev.medium';
      case Severity.low:
        return 'sev.low';
      case Severity.info:
        return 'sev.info';
    }
  }

  static Color _severityColor(Severity s) {
    switch (s) {
      case Severity.critical:
        return const Color(0xFFFF3B30);
      case Severity.high:
        return const Color(0xFFFF9500);
      case Severity.medium:
        return const Color(0xFFE0AC00);
      case Severity.low:
        return const Color(0xFF2EA84A);
      case Severity.info:
        return const Color(0xFF0098C7);
    }
  }

  static IconData _severityIcon(Severity s) {
    switch (s) {
      case Severity.critical:
        return Icons.error_rounded;
      case Severity.high:
        return Icons.warning_rounded;
      case Severity.medium:
        return Icons.report_problem_rounded;
      case Severity.low:
        return Icons.check_circle_outline_rounded;
      case Severity.info:
        return Icons.info_outline_rounded;
    }
  }
}

class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _HeaderActionButton({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: p.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: p.primary.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: p.primary, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: p.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterEntry {
  final String label;
  final Severity? severity;
  final int count;
  final Color color;
  final IconData icon;

  _FilterEntry({
    required this.label,
    required this.severity,
    required this.count,
    required this.color,
    required this.icon,
  });
}

class _FilterPill extends StatefulWidget {
  final _FilterEntry entry;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterPill({
    required this.entry,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_FilterPill> createState() => _FilterPillState();
}

class _FilterPillState extends State<_FilterPill> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final color = widget.entry.color;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 7 + (_isPressed ? 1 : 0),
        ),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? color.withValues(alpha: p.isDark ? 0.22 : 0.14)
              : p.card,
          border: Border.all(
            color: widget.isSelected ? color : p.border,
            width: widget.isSelected ? 1.4 : 1,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            if (widget.isSelected || _isPressed)
              BoxShadow(
                color: color.withValues(
                  alpha: _isPressed ? 0.4 : 0.30,
                ),
                blurRadius: _isPressed ? 12 : 10,
                offset: Offset(0, _isPressed ? 4 : 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _isPressed ? 0.92 : 1.0,
              duration: const Duration(milliseconds: 100),
              child: Icon(
                widget.entry.icon,
                size: 15,
                color: widget.isSelected ? color : p.mutedText,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              widget.entry.label,
              style: TextStyle(
                color: widget.isSelected ? p.text : p.mutedText,
                fontSize: 13,
                fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              constraints: const BoxConstraints(minWidth: 22),
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? color.withValues(alpha: 0.35)
                    : p.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.isSelected
                      ? color.withValues(alpha: 0.5)
                      : p.border,
                ),
              ),
              child: Text(
                '${widget.entry.count}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.isSelected ? p.text : p.mutedText,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertCard extends StatefulWidget {
  final Alert alert;
  final AppLocale locale;
  final VoidCallback onMarkRead;

  const _AlertCard({
    required this.alert,
    required this.locale,
    required this.onMarkRead,
  });

  @override
  State<_AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<_AlertCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final severityColor = _severityColorFromHex(widget.alert.severity.toHexColor());
    final severityLabel = AppStrings.get(_sevKey(widget.alert.severity), widget.locale);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onMarkRead();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: p.card,
          border: Border.all(
            color: widget.alert.isRead
                ? p.border
                : severityColor.withValues(alpha: 0.5),
            width: widget.alert.isRead ? 1 : 1.3,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            if (widget.alert.isRead && !_isPressed && !p.isDark)
              BoxShadow(
                color: p.shadow,
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            else if (!widget.alert.isRead || _isPressed)
              BoxShadow(
                color: severityColor.withValues(
                  alpha: _isPressed ? 0.3 : (p.isDark ? 0.10 : 0.18),
                ),
                blurRadius: _isPressed ? 16 : 12,
                offset: Offset(0, _isPressed ? 6 : 2),
                spreadRadius: _isPressed ? 1 : 0,
              ),
          ],
        ),
        child: Transform.scale(
          scale: _isPressed ? 0.97 : 1.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: severityColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: severityColor.withValues(alpha: 0.35),
                  ),
                ),
                child: Icon(
                  _sevIcon(widget.alert.severity),
                  color: severityColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: severityColor.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: severityColor.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Text(
                            severityLabel,
                            style: TextStyle(
                              color: severityColor,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (!widget.alert.isRead) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: p.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                        const Spacer(),
                        Text(
                          _formatTime(widget.alert.timestamp, widget.locale),
                          style: TextStyle(
                            color: p.mutedText,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.alert.title,
                      style: TextStyle(
                        color: p.text,
                        fontSize: 14.5,
                        fontWeight:
                            widget.alert.isRead ? FontWeight.w600 : FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.alert.message,
                      style: TextStyle(
                        color: p.mutedText,
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.computer_rounded,
                          size: 13,
                          color: p.mutedText,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            widget.alert.affectedSystem ?? '—',
                            style: TextStyle(
                              color: p.mutedText,
                              fontSize: 11.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!widget.alert.isRead)
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: widget.onMarkRead,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: p.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: p.primary.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.done_rounded,
                                    color: p.primary,
                                    size: 13,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    AppStrings.get('alerts.mark_read', widget.locale),
                                    style: TextStyle(
                                      color: p.primary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatTime(DateTime t, AppLocale locale) {
  final now = DateTime.now();
  final diff = now.difference(t);
  final ago = AppStrings.get('time.ago', locale);
  if (diff.inMinutes < 1) return AppStrings.get('time.now', locale);
  final prefix = ago.isEmpty ? '' : '$ago ';
  if (diff.inMinutes < 60) {
    return '$prefix${diff.inMinutes} ${AppStrings.get('time.min', locale)}';
  }
  if (diff.inHours < 24) {
    return '$prefix${diff.inHours} ${AppStrings.get('time.hour', locale)}';
  }
  return '$prefix${diff.inDays} ${AppStrings.get('time.day', locale)}';
}

Color _severityColorFromHex(String hexColor) {
  final hex = hexColor.replaceFirst('#', '');
  return Color(int.parse('FF$hex', radix: 16));
}

IconData _sevIcon(Severity s) {
  switch (s) {
    case Severity.critical:
      return Icons.error_rounded;
    case Severity.high:
      return Icons.warning_rounded;
    case Severity.medium:
      return Icons.report_problem_rounded;
    case Severity.low:
      return Icons.check_circle_outline_rounded;
    case Severity.info:
      return Icons.info_outline_rounded;
  }
}

String _sevKey(Severity s) {
  switch (s) {
    case Severity.critical:
      return 'sev.critical';
    case Severity.high:
      return 'sev.high';
    case Severity.medium:
      return 'sev.medium';
    case Severity.low:
      return 'sev.low';
    case Severity.info:
      return 'sev.info';
  }
}
