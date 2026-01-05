import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design System - Tipografia (baseado no Figma)
///
/// Tamanhos e line-heights extraídos do Style Guide.
/// Font-family sera Poppins

class AppTextStyles {
  /// Família de fonte
  static const String _fontFamily = 'Poppins';

  // ===== HEADER STYLES =====

  /// Headline - Bold 24/32px
  static const TextStyle headline = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 32.0 / 24.0, // line-height / font-size
    color: AppColors.textPrimary,
  );

  /// Subtitle 1 - Bold 14/16px
  static const TextStyle subtitle1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    height: 16.0 / 14.0,
    color: AppColors.textPrimary,
  );

  /// Subtitle 2 - Bold 12/16px
  static const TextStyle subtitle2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    height: 16.0 / 12.0,
    color: AppColors.textPrimary,
  );

  /// Subtitle 3 - Bold 10/16px
  static const TextStyle subtitle3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10.0,
    fontWeight: FontWeight.bold,
    height: 16.0 / 10.0,
    color: AppColors.textPrimary,
  );

  // ===== BODY STYLES =====

  /// Body 1 - Regular 14/16px
  static const TextStyle body1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 16.0 / 14.0,
    color: AppColors.textPrimary,
  );

  /// Body 2 - Regular 12/16px
  static const TextStyle body2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 16.0 / 12.0,
    color: AppColors.textPrimary,
  );

  /// Body 3 - Regular 10/16px
  static const TextStyle body3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10.0,
    fontWeight: FontWeight.normal,
    height: 16.0 / 10.0,
    color: AppColors.textPrimary,
  );

  /// Caption - Regular 8/12px
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 8.0,
    fontWeight: FontWeight.normal,
    height: 12.0 / 8.0,
    color: AppColors.textSecondary,
  );

  // ===== ALIASES PARA FACILITAR USO =====

  // Aliases dos Headers (para retrocompatibilidade)
  static const TextStyle h1 = headline;
  static const TextStyle h2 = subtitle1;
  static const TextStyle h3 = subtitle2;
  static const TextStyle h4 = subtitle3;

  // Aliases dos Bodies
  static const TextStyle bodyLarge = body1;
  static const TextStyle body = body2;
  static const TextStyle bodySmall = body3;

  // ===== ESPECÍFICOS PARA POKÉDEX =====

  /// Número do Pokémon (#001, #002...)
  static const TextStyle pokemonNumber = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
    height: 16.0 / 12.0,
    color: AppColors.textSecondary,
  );

  /// Nome do Pokémon (tela de detalhes)
  static const TextStyle pokemonName = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 32.0 / 24.0,
    color: AppColors.white,
  );

  /// Label de tipo (FIRE, WATER, etc)
  static const TextStyle typeLabel = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10.0,
    fontWeight: FontWeight.bold,
    height: 16.0 / 10.0,
    color: AppColors.white,
  );

  /// Nome em cards
  static const TextStyle cardTitle = subtitle1;

  AppTextStyles._(); // Construtor privado
}
