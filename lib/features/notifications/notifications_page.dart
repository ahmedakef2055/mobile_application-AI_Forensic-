import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../core/widgets/app_toast.dart';
import '../../models/severity.dart';
import '../../providers/alerts_provider.dart';
import '../../providers/settings_provider.dart';

class NotificationsPage extends ConsumerWidget {
  static const routePath = '/notifications';

  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = c(context);
    final alertsState = ref.watch(alertsProvider);
    final settings = ref.watch(settingsProvider);
    String t(String k) => AppStrings.get(k, settings.locale);

    return Scaffold(
      backgroundColor: p.background,
      appBar: AppBarWidget(
        title: t('alerts.title'),
        subtitle: 'جميع الإشعارات والتنبيهات المهمة',
      ),
      body: SafeArea(
        child: alertsState.alerts.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Center(
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
                        t('alerts.empty'),
                        style: TextStyle(
                          color: p.text,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: alertsState.alerts.length,
              itemBuilder: (context, index) {
                final alert = alertsState.alerts[index];
                final sevColor = _parseColor(alert.severity.toHexColor());
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: p.card,
                    border: Border.all(color: p.border),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: p.isDark
                        ? null
                        : [
                            BoxShadow(
                              color: p.shadow,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              alert.title,
                              style: TextStyle(
                                color: p.text,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: sevColor.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: sevColor.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              AppStrings.get(
                                  _sevKey(alert.severity), settings.locale),
                              style: TextStyle(
                                color: sevColor,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        alert.message,
                        style: TextStyle(
                          color: p.mutedText,
                          fontSize: 12.5,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(alert.timestamp, settings.locale),
                            style: TextStyle(
                              color: p.mutedText,
                              fontSize: 11.5,
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              AppToast.show(
                                context,
                                message: settings.isArabic
                                    ? 'تم حذف الإشعار'
                                    : 'Notification deleted',
                                kind: AppToastKind.success,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: p.background,
                                border: Border.all(color: p.border),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: p.mutedText,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }

  String _formatTime(DateTime dt, AppLocale locale) {
    final diff = DateTime.now().difference(dt);
    final isAr = locale == AppLocale.ar;
    if (diff.inMinutes < 1) return AppStrings.get('time.now', locale);
    if (diff.inMinutes < 60) {
      return isAr
          ? 'قبل ${diff.inMinutes} دقيقة'
          : '${diff.inMinutes} min ago';
    }
    if (diff.inHours < 24) {
      return isAr
          ? 'قبل ${diff.inHours} ساعة'
          : '${diff.inHours} h ago';
    }
    return isAr
        ? 'قبل ${diff.inDays} أيام'
        : '${diff.inDays} d ago';
  }

  Color _parseColor(String hexColor) {
    final hex = hexColor.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
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
}
