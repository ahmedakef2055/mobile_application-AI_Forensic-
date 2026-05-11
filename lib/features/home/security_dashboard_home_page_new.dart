import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/loading_view.dart';
import '../../core/widgets/error_view.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../models/severity.dart';
import '../../models/alert.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/alerts_provider.dart';
import '../../providers/settings_provider.dart';

class SecurityDashboardHomePage extends ConsumerStatefulWidget {
  const SecurityDashboardHomePage({super.key});
  static const routePath = '/dashboard';

  @override
  ConsumerState<SecurityDashboardHomePage> createState() =>
      _SecurityDashboardHomePageState();
}

class _SecurityDashboardHomePageState
    extends ConsumerState<SecurityDashboardHomePage> {
  late AppPalette _p;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dashboardProvider.notifier).refreshDashboard();
      ref.read(alertsProvider.notifier).refreshAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    _p = c(context);
    final dashboardState = ref.watch(dashboardProvider);
    final alertsState = ref.watch(alertsProvider);
    final settings = ref.watch(settingsProvider);
    String t(String k) => AppStrings.get(k, settings.locale);

    return Scaffold(
      backgroundColor: _p.background,
      appBar: AppBarWidget(
        title: t('home.title'),
        subtitle: 'لوحة التحكم الأساسية والإحصائيات الأمنية',
        notificationCount: alertsState.alerts.length,
        onNotificationTap: () => context.push('/notifications'),
        onSettingsTap: () => context.push('/settings'),
        showSearch: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: dashboardState.isLoading
                  ? LoadingView(message: t('home.loading'))
                  : dashboardState.error != null
                      ? ErrorView(
                          title: t('home.error'),
                          message: dashboardState.error!,
                          onRetry: () {
                            ref
                                .read(dashboardProvider.notifier)
                                .refreshDashboard();
                          },
                        )
                      : _buildContent(context, dashboardState, alertsState, t),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DashboardState dashboard,
      AlertsState alerts, String Function(String) t) {
    final metrics = dashboard.metrics;
    if (metrics == null) return SizedBox();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Metrics
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: t('home.metric.active_alerts'),
                  value: metrics.activeAlerts.toString(),
                  icon: Icons.warning_amber_rounded,
                  color: Color(0xFFFF9500),
                  animate: true,
                  onTap: () => context.go('/incidents'),
                ),
              ),
              SizedBox(width: AppSpacing.s12),
              Expanded(
                child: _MetricCard(
                  title: t('home.metric.open_incidents'),
                  value: metrics.openIncidents.toString(),
                  icon: Icons.report_problem_rounded,
                  color: Color(0xFFFF3B30),
                  animate: true,
                  onTap: () => context.go('/incidents'),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.s12),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: t('home.metric.threats_blocked'),
                  value: metrics.threatsBlocked.toString(),
                  icon: Icons.shield_rounded,
                  color: Color(0xFF34C759),
                  onTap: () {},
                ),
              ),
              SizedBox(width: AppSpacing.s12),
              Expanded(
                child: _MetricCard(
                  title: t('home.metric.system_health'),
                  value: '${metrics.systemHealth.toStringAsFixed(1)}%',
                  icon: Icons.monitor_heart_rounded,
                  color: Color(0xFF00C7FF),
                  onTap: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.s24),

          // Health Gauge
          _HealthGauge(health: metrics.systemHealth, title: t('home.gauge.title')),
          SizedBox(height: AppSpacing.s24),

          // Recent Alerts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t('home.recent_alerts'),
                style: AppTextStyles.h2.copyWith(color: _p.text),
              ),
              TextButton(
                onPressed: () => context.go('/alerts'),
                child: Text(
                  t('home.view_all'),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.s12),
          ...(alerts.alerts.take(3).map((alert) {
            return _AlertItem(alert: alert);
          })),

          SizedBox(height: AppSpacing.s32),
        ],
      ),
    );
  }
}

class _MetricCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool animate;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
    this.animate = false,
  });

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.animate) _pulse.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        child: Container(
          padding: EdgeInsets.all(AppSpacing.s16),
          decoration: BoxDecoration(
            color: _p.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _p.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedBuilder(
                animation: _pulse,
                builder: (context, child) {
                  final glow = widget.animate
                      ? (0.18 + _pulse.value * 0.25)
                      : 0.22;
                  return Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: widget.animate
                          ? [
                              BoxShadow(
                                color: widget.color.withOpacity(glow),
                                blurRadius: 14,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(widget.icon, color: widget.color, size: 22),
                  );
                },
              ),
              SizedBox(height: AppSpacing.s12),
              Text(
                widget.value,
                style: AppTextStyles.h2.copyWith(color: widget.color),
              ),
              SizedBox(height: AppSpacing.s4),
              Text(
                widget.title,
                style: AppTextStyles.caption.copyWith(color: _p.mutedText),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealthGauge extends StatelessWidget {
  final double health;
  final String title;

  const _HealthGauge({required this.health, required this.title});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    final healthColor = health >= 80
        ? Color(0xFF34C759)
        : health >= 60
            ? Color(0xFFFFC300)
            : Color(0xFFFF3B30);

    return Container(
      padding: EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _p.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.body.copyWith(color: _p.text)),
          SizedBox(height: AppSpacing.s12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: health / 100,
                    minHeight: 10,
                    backgroundColor: _p.border,
                    valueColor: AlwaysStoppedAnimation(healthColor),
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.s12),
              Text(
                '${health.toStringAsFixed(1)}%',
                style: AppTextStyles.body.copyWith(
                  color: healthColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AlertItem extends StatelessWidget {
  final Alert alert;

  const _AlertItem({required this.alert});

  @override
  Widget build(BuildContext context) {
    final _p = c(context);
    return Container(
      padding: EdgeInsets.all(AppSpacing.s12),
      margin: EdgeInsets.only(bottom: AppSpacing.s8),
      decoration: BoxDecoration(
        color: _p.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _p.border),
      ),
      child: Row(
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: _getSeverityColor(alert.severity),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          SizedBox(width: AppSpacing.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.title,
                  style: AppTextStyles.body.copyWith(
                    color: _p.text,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  alert.message,
                  style: AppTextStyles.caption.copyWith(color: _p.mutedText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.s8),
          Icon(
            Icons.arrow_back_ios_rounded,
            size: 14,
            color: _p.mutedText,
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(Severity severity) {
    switch (severity) {
      case Severity.critical:
        return Color(0xFFFF3B30);
      case Severity.high:
        return Color(0xFFFF9500);
      case Severity.medium:
        return Color(0xFFFFCC00);
      case Severity.low:
        return Color(0xFF34C759);
      case Severity.info:
        return Color(0xFF00C7FF);
    }
  }
}
