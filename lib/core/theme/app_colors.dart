import 'package:flutter/material.dart';

/// Design System - Paleta de Cores (baseado no Figma)
///
/// Define todas as cores usadas no app de forma centralizada
/// Cores extraídas do Style Guide oficial do projeto
/// URL: https://www.figma.com/design/LLCF4unNCeVDavpbR7bL4m/Pok%C3%A9dex--Community-?node-id=1016-1434&t=tjvK7qumtwN57fFT-0
class AppColors {
  // ===== IDENTITY COLORS =====
  static const Color primary = Color(0xFFDC0A2D); // Primary Red (Figma)

  // ===== GRAYSCALE (Figma) =====
  static const Color dark = Color(0xFF212121); // Dark
  static const Color medium = Color(0xFF666666); // Medium
  static const Color light = Color(0xFFE0E0E0); // Light
  static const Color background = Color(0xFFEFEFEF); // Background
  static const Color white = Color(0xFFFFFFFF); // White

  // ===== TEXT COLORS =====
  static const Color textPrimary = dark; // #212121
  static const Color textSecondary = medium; // #666666
  static const Color textLight = light; // #E0E0E0
  static const Color textWhite = white; // #FFFFFF

  // ===== SURFACE COLORS =====
  static const Color surface = white; // Cards e superfícies
  static const Color backgroundDefault = background; // Fundo do app

  // ===== SHADOW COLORS =====
  // Drop Shadow 2dp
  static const Color shadow2dp = Color(0x1F000000); // ~12% opacity
  // Drop Shadow 6dp
  static const Color shadow6dp = Color(0x3D000000); // ~24% opacity
  // Inner Shadow 2pd
  static const Color innerShadow = Color(0x1A000000); // ~10% opacity

  AppColors._(); // Construtor privado para classe utilitária
}
