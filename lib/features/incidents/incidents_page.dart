import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../models/incident.dart';
import '../../models/severity.dart';
import '../../providers/incidents_provider.dart';
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

  List<Incident> _filterIncidents(List<Incident> all) {
    switch (selectedTabIndex) {
      case 1: return all.where((i) => i.status == 'open').toList();
      case 2: return all.where((i) => i.status == 'investigating').toList();
      case 3: return all.where((i) => i.status == 'closed').toList();
      default: return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    final settings = ref.watch(settingsProvider);
    String t(String k) => AppStrings.get(k, settings.locale);
    final incidentsState = ref.watch(incidentsProvider);

    final tabs = [
      t('incidents.tab.all'),
      t('incidents.tab.open'),
      t('incidents.tab.in_progress'),
      t('incidents.tab.resolved'),
    ];

    final filtered = _filterIncidents(incidentsState.incidents);

    return Scaffold(
      appBar: AppBarWidget(
        title: t('incidents.title'),
        subtitle: t('incidents.subtitle'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [p.bgTop, p.bgBottom],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _TabsRow(
                  tabs: tabs,
                  selectedIndex: selectedTabIndex,
                  onTap: (i) => setState(() => selectedTabIndex = i),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: incidentsState.isLoading
                    ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                    : incidentsState.error != null
                        ? _ErrorView(
                            message: incidentsState.error!,
                            onRetry: () => ref.read(incidentsProvider.notifier).refreshIncidents(),
                          )
                        : filtered.isEmpty
                            ? _EmptyView(label: t('incidents.tab.all'))
                            : RefreshIndicator(
                                color: AppColors.primary,
                                onRefresh: () => ref.read(incidentsProvider.notifier).refreshIncidents(),
                                child: ListView.separated(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  itemCount: filtered.length + 1,
                                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                                  itemBuilder: (context, index) {
                                    if (index == filtered.length) {
                                      return _FooterInfo(
                                        attentionLabel: '${filtered.length} ${t('incidents.footer.attention')}',
                                        updatedLabel: t('incidents.footer.updated'),
                                      );
                                    }
                                    final item = filtered[index];
                                    return _IncidentCard(
                                      item: item,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => IncidentDetailPage(
                                              data: IncidentData(
                                                id: item.id,
                                                title: item.title,
                                                description: item.description,
                                                code: 'INC-${item.id.padLeft(5, '0')}',
                                                severityLabel: item.severity.name,
                                                status: item.status,
                                                time: _formatTime(item.timestamp),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

/* ─── Error / Empty views ─── */

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, color: p.mutedText, size: 48),
            const SizedBox(height: 12),
            Text(message, style: TextStyle(color: p.mutedText, fontSize: 13), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final String label;
  const _EmptyView({required this.label});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield_outlined, color: p.mutedText, size: 48),
          const SizedBox(height: 12),
          Text('No incidents found', style: TextStyle(color: p.mutedText, fontSize: 13)),
        ],
      ),
    );
  }
}

/* ─── Tabs ─── */

class _TabsRow extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _TabsRow({required this.tabs, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) => _TabButton(
          label: tabs[i],
          isSelected: i == selectedIndex,
          onTap: () => onTap(i),
        ),
      ),
    );
  }
}

class _TabButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.isSelected, required this.onTap});

  @override
  State<_TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<_TabButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) { setState(() => _isPressed = false); widget.onTap(); },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.primary.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: widget.isSelected ? AppColors.primary : p.border,
            width: widget.isSelected ? 1.4 : 1,
          ),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isSelected ? AppColors.primary : p.mutedText,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

/* ─── Incident Card ─── */

class _IncidentCard extends StatefulWidget {
  final Incident item;
  final VoidCallback onTap;
  const _IncidentCard({required this.item, required this.onTap});

  @override
  State<_IncidentCard> createState() => _IncidentCardState();
}

class _IncidentCardState extends State<_IncidentCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Color get _accentColor {
    switch (widget.item.severity) {
      case Severity.critical: return const Color(0xFFFF6B6B);
      case Severity.high:     return const Color(0xFFFFA04D);
      case Severity.medium:   return const Color(0xFFFFD34D);
      case Severity.low:      return const Color(0xFF4ADE80);
      default:                return AppColors.primary;
    }
  }

  Color get _badgeBg {
    switch (widget.item.severity) {
      case Severity.critical: return const Color(0x33FF6B6B);
      case Severity.high:     return const Color(0x33FFA04D);
      case Severity.medium:   return const Color(0x33FFD34D);
      case Severity.low:      return const Color(0x334ADE80);
      default:                return AppColors.primary.withValues(alpha: 0.2);
    }
  }

  String get _severityLabel {
    switch (widget.item.severity) {
      case Severity.critical: return 'Critical';
      case Severity.high:     return 'High';
      case Severity.medium:   return 'Medium';
      case Severity.low:      return 'Low';
      default:                return 'Info';
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return GestureDetector(
      onTapDown: (_) { setState(() => _isPressed = true); _ctrl.forward(); },
      onTapUp: (_) { setState(() => _isPressed = false); _ctrl.reverse(); widget.onTap(); },
      onTapCancel: () { setState(() => _isPressed = false); _ctrl.reverse(); },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => Transform.scale(
          scale: 1.0 - (_ctrl.value * 0.03),
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: p.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isPressed ? _accentColor : p.border,
                width: _isPressed ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: _accentColor.withValues(alpha: _isPressed ? 0.2 : 0.0),
                  blurRadius: 16, offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 48, width: 3,
                  decoration: BoxDecoration(
                    color: _accentColor,
                    borderRadius: BorderRadius.circular(999),
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
                              'INC-${widget.item.id.padLeft(5, '0')} — ${widget.item.title}',
                              style: TextStyle(color: p.text, fontSize: 13, fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(color: _badgeBg, borderRadius: BorderRadius.circular(999)),
                            child: Text(
                              _severityLabel,
                              style: TextStyle(color: _accentColor, fontSize: 11, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: p.mutedText, fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.circle, size: 7,
                            color: widget.item.status == 'closed'
                                ? const Color(0xFF4ADE80)
                                : AppColors.primary),
                          const SizedBox(width: 5),
                          Text(
                            widget.item.status.toUpperCase(),
                            style: TextStyle(
                              color: widget.item.status == 'closed'
                                  ? const Color(0xFF4ADE80)
                                  : AppColors.primary,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: p.mutedText, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ─── Footer ─── */

class _FooterInfo extends StatelessWidget {
  final String attentionLabel;
  final String updatedLabel;
  const _FooterInfo({required this.attentionLabel, required this.updatedLabel});

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: p.border),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: p.mutedText, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(attentionLabel, style: TextStyle(color: p.text, fontSize: 12.8, fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(updatedLabel, style: TextStyle(color: p.mutedText, fontSize: 11.5, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
