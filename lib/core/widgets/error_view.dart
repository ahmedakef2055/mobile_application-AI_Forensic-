import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';

class ErrorView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final bool fullScreen;
  final String? retryLabel;
  final String? dismissLabel;
  final IconData icon;

  const ErrorView({
    Key? key,
    this.title = 'خطأ',
    required this.message,
    this.onRetry,
    this.onDismiss,
    this.fullScreen = false,
    this.retryLabel,
    this.dismissLabel,
    this.icon = Icons.error_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 64,
          color: Color(0xFFFF3B30),
        ),
        SizedBox(height: AppSpacing.s24),
        Text(
          title,
          style: AppTextStyles.h2.copyWith(
            color: AppColors.text,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.s12),
        Text(
          message,
          style: AppTextStyles.body.copyWith(
            color: AppColors.mutedText,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppSpacing.s32),
        if (onRetry != null)
          AppButton(
            label: retryLabel ?? 'إعادة محاولة',
            onPressed: onRetry!,
            width: 200,
          ),
        if (onDismiss != null) ...[
          SizedBox(height: AppSpacing.s12),
          AppButton(
            label: dismissLabel ?? 'إغلاق',
            onPressed: onDismiss!,
            variant: ButtonVariant.outline,
            width: 200,
          ),
        ],
      ],
    );

    if (fullScreen) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppSpacing.s24),
          child: Center(child: child),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.s24),
        child: child,
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const ErrorDialog({
    Key? key,
    this.title = 'خطأ',
    required this.message,
    this.actionLabel,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: AppTextStyles.h2.copyWith(
          color: AppColors.text,
        ),
      ),
      content: Text(
        message,
        style: AppTextStyles.body.copyWith(
          color: AppColors.mutedText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'إغلاق',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
        if (actionLabel != null && onAction != null)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onAction!();
            },
            child: Text(
              actionLabel!,
              style: TextStyle(color: Color(0xFFFF3B30)),
            ),
          ),
      ],
    );
  }
}
