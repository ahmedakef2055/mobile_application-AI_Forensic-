import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_bar_widget.dart';
import '../../models/severity.dart';
import '../../providers/alerts_provider.dart';

class NotificationsPage extends ConsumerWidget {
  static const routePath = '/notifications';

  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsState = ref.watch(alertsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(
        title: 'الإشعارات',
      ),
      body: alertsState.alerts.isEmpty
          ? Center(
              child: Text(
                'لا توجد إشعارات جديدة',
                style: AppTextStyles.body
                    .copyWith(color: AppColors.mutedText),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s12,
              ),
              itemCount: alertsState.alerts.length,
              itemBuilder: (context, index) {
                final alert = alertsState.alerts[index];
                return Container(
                  margin: EdgeInsets.only(bottom: AppSpacing.s12),
                  padding: EdgeInsets.all(AppSpacing.s16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              alert.title,
                              style: AppTextStyles.h2.copyWith(
                                color: AppColors.text,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.s8,
                              vertical: AppSpacing.s4,
                            ),
                            decoration: BoxDecoration(
                              color: _parseColor(
                                  alert.severity.toHexColor()),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              alert.severity.toDisplayString(),
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSpacing.s8),
                      Text(
                        alert.message,
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.mutedText,
                        ),
                      ),
                      SizedBox(height: AppSpacing.s12),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatTime(alert.timestamp),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.mutedText,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'تم حذف الإشعار'),
                                  backgroundColor:
                                      AppColors.primary,
                                ),
                              );
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.mutedText,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'قبل ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'قبل ${difference.inHours} ساعة';
    } else {
      return 'قبل ${difference.inDays} أيام';
    }
  }

  Color _parseColor(String hexColor) {
    final hex = hexColor.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }
}
