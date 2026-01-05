import 'package:flutter/material.dart';

/// Cores específicas para cada tipo de Pokémon
class PokemonTypeColors {
  static const Map<String, Color> typeColors = {
    'bug': Color(0xFFA7B723), // #A7B723
    'dark': Color(0xFF75574C), // #75574C
    'dragon': Color(0xFF7037FF), // #7037FF
    'electric': Color(0xFFF9CF30), // #F9CF30
    'fairy': Color(0xFFE69EAC), // #E69EAC
    'fighting': Color(0xFFC12239), // #C12239
    'fire': Color(0xFFF57D31), // #F57D31
    'flying': Color(0xFFA891EC), // #A891EC
    'ghost': Color(0xFF70559B), // #70559B
    'normal': Color(0xFFAAA67F), // #AAA67F
    'grass': Color(0xFF74CB48), // #74CB48
    'ground': Color(0xFFDEC16B), // #DEC16B
    'ice': Color(0xFF9AD6DF), // #9AD6DF
    'poison': Color(0xFFA43E9E), // #A43E9E
    'psychic': Color(0xFFFB5584), // #FB5584
    'rock': Color(0xFFB69E31), // #B69E31
    'steel': Color(0xFFB7B9D0), // #B7B9D0
    'water': Color(0xFF6493EB), // #6493EB
  };

  /// Retorna a cor para um tipo específico ou cinza se não encontrar o type
  static Color getTypeColor(String type) {
    return typeColors[type.toLowerCase()] ?? const Color(0xFF68A090);
  }

  /// Retorna uma versão mais clara da cor (para gradientes)
  static Color getTypeLightColor(String type) {
    final baseColor = getTypeColor(type);
    return Color.lerp(baseColor, Colors.white, 0.3) ?? baseColor;
  }

  /// Retorna uma versão mais escura da cor
  static Color getTypeDarkColor(String type) {
    final baseColor = getTypeColor(type);
    return Color.lerp(baseColor, Colors.black, 0.2) ?? baseColor;
  }

  /// Verifica se o texto deve ser branco ou preto baseado na cor de fundo
  static Color getContrastColor(String type) {
    final color = getTypeColor(type);
    // Calcula a luminância
    final luminance = color.computeLuminance();
    // Se for escuro, usa texto branco; se for claro, usa texto preto
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  PokemonTypeColors._(); // Construtor privado
}
