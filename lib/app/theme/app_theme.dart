import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary900 = Color(0xFF1F3A35);
  static const primary800 = Color(0xFF294A43);
  static const primary700 = Color(0xFF365D54);
  static const primary600 = Color(0xFF447268);
  static const primary500 = Color(0xFF557F75);
  static const primary100 = Color(0xFFE6EFEC);
  static const primary050 = Color(0xFFF3F7F6);
  static const hero = Color(0xFFF0F5F3);
  static const accent = Color(0xFFC98952);
  static const ink = Color(0xFF171A19);
  static const secondary = Color(0xFF6D736F);
  static const muted = Color(0xFF8A908C);
  static const border = Color(0xFFDEE1DF);
  static const background = Color(0xFFF7F8F7);
  static const error = Color(0xFFB23A3A);
  static const errorSurface = Color(0xFFFBE7E7);
  static const info = Color(0xFF35698F);
  static const infoSurface = Color(0xFFE5F0F8);
  static const warning = Color(0xFF9A6817);
  static const warningSurface = Color(0xFFFFF1D4);
  static const success = Color(0xFF2F6B4F);
  static const successSurface = Color(0xFFE4F2EA);
}

abstract final class AppSpacing {
  static const double xxs = 4, xs = 8, sm = 12, md = 16;
  static const double lg = 20, xl = 24, xxl = 32, xxxl = 40;
}

abstract final class AppRadius {
  static const double sm = 8, md = 12, lg = 16, xl = 20;
}

ThemeData buildAppTheme() {
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
  OutlineInputBorder border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color),
  );
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary800,
      secondary: AppColors.accent,
      surface: Colors.white,
      error: AppColors.error,
      onSurface: AppColors.ink,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      headlineSmall: TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.45,
      ),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 1.4,
        color: AppColors.secondary,
      ),
      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      foregroundColor: AppColors.primary900,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primary900,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.primary600),
      errorBorder: border(AppColors.error),
      focusedErrorBorder: border(AppColors.error),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
      errorStyle: const TextStyle(fontSize: 12, color: AppColors.error),
      errorMaxLines: 3,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary800,
        foregroundColor: Colors.white,
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: shape,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(48, 48),
        foregroundColor: AppColors.ink,
        backgroundColor: Colors.white,
        side: const BorderSide(color: AppColors.border),
        shape: shape,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary700,
        minimumSize: const Size(44, 44),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF202423),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      behavior: SnackBarBehavior.floating,
      insetPadding: const EdgeInsets.all(16),
      shape: shape,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? Colors.white
            : AppColors.secondary,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? AppColors.primary500
            : AppColors.border,
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.border),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary700,
    ),
  );
}
