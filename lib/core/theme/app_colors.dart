import 'package:flutter/material.dart';

/// Static dark-mode palette (kept as const so legacy `const TextStyle(...)`
/// usages still compile). For dynamic theme-aware colors, use
/// `AppColors.of(context)` (or the `c(context)` shortcut).
class AppColors {
  AppColors._();

  // ===== Dark (default, const-safe legacy aliases) =====
  static const Color background = Color(0xFF050A14);
  static const Color bgTop = Color(0xFF0B1220);
  static const Color bgBottom = Color(0xFF050A14);

  static const Color primary = Color(0xFF2F6BFF);

  static const Color text = Color(0xFFEAF0FF);
  static const Color mutedText = Color(0xFF9AA7C2);
  static const Color muted = Color(0xFF9AA7C2);

  static const Color card = Color(0x1AFFFFFF);
  static const Color border = Color(0x22FFFFFF);

  // ===== Light counterparts =====
  static const Color lightBackground = Color(0xFFF4F6FB);
  static const Color lightBgTop = Color(0xFFFFFFFF);
  static const Color lightBgBottom = Color(0xFFEDF1F8);
  static const Color lightText = Color(0xFF111827);
  static const Color lightMutedText = Color(0xFF6B7280);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0x1A1E2A44);

  static AppPalette of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppPalette.dark : AppPalette.light;
  }
}

@immutable
class AppPalette {
  final Color background;
  final Color bgTop;
  final Color bgBottom;
  final Color primary;
  final Color text;
  final Color mutedText;
  final Color card;
  final Color border;
  final Color shadow;
  final bool isDark;

  const AppPalette({
    required this.background,
    required this.bgTop,
    required this.bgBottom,
    required this.primary,
    required this.text,
    required this.mutedText,
    required this.card,
    required this.border,
    required this.shadow,
    required this.isDark,
  });

  Color get muted => mutedText;

  static const AppPalette dark = AppPalette(
    background: AppColors.background,
    bgTop: AppColors.bgTop,
    bgBottom: AppColors.bgBottom,
    primary: AppColors.primary,
    text: AppColors.text,
    mutedText: AppColors.mutedText,
    card: AppColors.card,
    border: AppColors.border,
    shadow: Color(0x66000000),
    isDark: true,
  );

  static const AppPalette light = AppPalette(
    background: AppColors.lightBackground,
    bgTop: AppColors.lightBgTop,
    bgBottom: AppColors.lightBgBottom,
    primary: AppColors.primary,
    text: AppColors.lightText,
    mutedText: AppColors.lightMutedText,
    card: AppColors.lightCard,
    border: AppColors.lightBorder,
    shadow: Color(0x141E2A44),
    isDark: false,
  );
}

/// Quick palette accessor: `c(context).text` instead of `AppColors.of(context).text`.
AppPalette c(BuildContext context) => AppColors.of(context);
