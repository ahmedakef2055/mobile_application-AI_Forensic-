import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get dark => _build(AppPalette.dark);
  static ThemeData get light => _build(AppPalette.light);

  static ThemeData _build(AppPalette p) {
    final brightness = p.isDark ? Brightness.dark : Brightness.light;
    final base = p.isDark ? ThemeData.dark() : ThemeData.light();

    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: p.background,
      canvasColor: p.background,
      colorScheme: base.colorScheme.copyWith(
        brightness: brightness,
        primary: p.primary,
        surface: p.bgTop,
        onSurface: p.text,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: p.bgTop,
        elevation: 0,
        foregroundColor: p.text,
        iconTheme: IconThemeData(color: p.text),
        titleTextStyle: TextStyle(
          color: p.text,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.bgTop,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: p.bgTop,
        contentTextStyle: TextStyle(color: p.text),
        behavior: SnackBarBehavior.floating,
      ),
      dividerColor: p.border,
      iconTheme: IconThemeData(color: p.text),
      textTheme: base.textTheme.apply(
        bodyColor: p.text,
        displayColor: p.text,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.card,
        hintStyle: TextStyle(color: p.mutedText),
        labelStyle: TextStyle(color: p.mutedText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: p.primary, width: 1.5),
        ),
      ),
    );
  }
}
