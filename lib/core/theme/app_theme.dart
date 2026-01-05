import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

/// Design System - Tema Principal
///
/// Centraliza toda a configuração do tema do app.
/// Baseado no style Guide do Figma
/// URL: https://www.figma.com/design/LLCF4unNCeVDavpbR7bL4m/Pok%C3%A9dex--Community-?node-id=1016-1434&t=tjvK7qumtwN57fFT-0

class AppTheme {
  /// Theme Light (baseado no figma)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Cores principais
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDefault, // #EFEFEF do Figma
      colorScheme: const ColorScheme.light(
        primary: AppColors.light,
        secondary: AppColors.primary,
        surface: AppColors.surface,
        error: Colors.red,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.headline,
      ),

      // Cards - Aplicando sombra de 2dp do Figma
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0, // Usando o BoxShadow customizado
        shadowColor: AppColors.shadow2dp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadium),
        ),
        margin: const EdgeInsets.all(AppSpacing.xs),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        hintStyle: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
      ),

      // Botões
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTextStyles.subtitle1,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.subtitle1,
        ),
      ),

      // Ícones
      iconTheme: const IconThemeData(
        color: AppColors.textPrimary,
        size: AppSpacing.iconMd,
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.light,
        thickness: 1,
        space: AppSpacing.md,
      ),

      // Tipografia base
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.headline,
        displayMedium: AppTextStyles.subtitle1,
        displaySmall: AppTextStyles.subtitle2,
        headlineMedium: AppTextStyles.subtitle3,
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,
        bodySmall: AppTextStyles.body3,
        labelLarge: AppTextStyles.subtitle1,
        labelSmall: AppTextStyles.caption,
      ),
    );
  }
}
