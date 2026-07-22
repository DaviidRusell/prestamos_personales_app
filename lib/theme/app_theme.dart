import 'package:flutter/material.dart';

/// Tema centralizado de la app.
/// Cambia estos colores para personalizar la marca sin tocar el resto del código.
class AppTheme {
  static const Color primary = Color(0xFF1B6E4F); // verde principal
  static const Color primaryDark = Color(0xFF104A34);
  static const Color accent = Color(0xFFF2A93B);
  static const Color background = Color(0xFFF7F8FA);
  static const Color textDark = Color(0xFF1E2124);
  static const Color textMuted = Color(0xFF6B7280);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: accent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: textDark),
        titleMedium: TextStyle(fontWeight: FontWeight.w600, color: textDark),
        bodyMedium: TextStyle(color: textDark),
        bodySmall: TextStyle(color: textMuted),
      ),
    );
  }
}
