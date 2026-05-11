import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final ButtonVariant variant;
  final double? width;
  final double height;
  final double borderRadius;
  final double? fontSize;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.variant = ButtonVariant.primary,
    this.width,
    this.height = 48,
    this.borderRadius = 12,
    this.fontSize,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  Color _getBackgroundColor() {
    if (!isEnabled) return AppColors.muted;

    switch (variant) {
      case ButtonVariant.primary:
        return backgroundColor ?? AppColors.primary;
      case ButtonVariant.secondary:
        return backgroundColor ?? AppColors.card;
      case ButtonVariant.outline:
        return backgroundColor ?? Colors.transparent;
      case ButtonVariant.danger:
        return backgroundColor ?? Color(0xFFFF3B30);
      case ButtonVariant.success:
        return backgroundColor ?? Color(0xFF34C759);
    }
  }

  Color _getForegroundColor() {
    if (!isEnabled) return AppColors.muted;

    switch (variant) {
      case ButtonVariant.primary:
        return foregroundColor ?? Colors.white;
      case ButtonVariant.secondary:
        return foregroundColor ?? AppColors.text;
      case ButtonVariant.outline:
        return foregroundColor ?? AppColors.primary;
      case ButtonVariant.danger:
        return foregroundColor ?? Colors.white;
      case ButtonVariant.success:
        return foregroundColor ?? Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled && !isLoading ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              border: variant == ButtonVariant.outline
                  ? Border.all(
                      color: borderColor ?? AppColors.primary,
                      width: 1.5,
                    )
                  : null,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(width: AppSpacing.s8),
                ],
                if (isLoading)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(_getForegroundColor()),
                    ),
                  )
                else
                  Text(
                    label,
                    style: TextStyle(
                      color: _getForegroundColor(),
                      fontSize: fontSize ?? 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (suffixIcon != null && !isLoading) ...[
                  SizedBox(width: AppSpacing.s8),
                  suffixIcon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonVariant {
  primary,
  secondary,
  outline,
  danger,
  success,
}
