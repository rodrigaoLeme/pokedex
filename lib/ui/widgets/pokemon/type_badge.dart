import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/pokemon_type_colors.dart';

/// Badge de Tipo de Pokémon
///
/// Exibe o tipo com:
/// - Cor de fundo do tipo
/// - Texto branco
/// - Bordas arredondadas
/// - Tamanhos: normal e small
class TypeBadge extends StatelessWidget {
  final String typeName;
  final bool small;

  const TypeBadge({super.key, required this.typeName, this.small = false});

  @override
  Widget build(BuildContext context) {
    final color = PokemonTypeColors.getTypeColor(typeName);
    final displayName = _getDisplayName(typeName);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? AppSpacing.xs : AppSpacing.sm,
        vertical: small ? 4 : AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        displayName,
        style: (small ? AppTextStyles.caption : AppTextStyles.body3).copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getDisplayName(String type) {
    // Capitaliza primeira letra
    if (type.isEmpty) return '';
    return type[0].toUpperCase() + type.substring(1);
  }
}

/// Badge do Tipo com tradução PT-BR
class TypeBadgePtBr extends StatelessWidget {
  final String typeName;
  final bool small;

  const TypeBadgePtBr({super.key, required this.typeName, this.small = false});

  @override
  Widget build(BuildContext context) {
    final color = PokemonTypeColors.getTypeColor(typeName);
    final displayName = _getPortugueseName(typeName);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? AppSpacing.xs : AppSpacing.sm,
        vertical: small ? 4 : AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Text(
        displayName,
        style: (small ? AppTextStyles.caption : AppTextStyles.body3).copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getPortugueseName(String type) {
    const typeTranslations = {
      'normal': 'Normal',
      'fire': 'Fogo',
      'water': 'Água',
      'electric': 'Elétrico',
      'grass': 'Planta',
      'ice': 'Gelo',
      'fighting': 'Lutador',
      'poison': 'Venenoso',
      'ground': 'Terra',
      'flying': 'Voador',
      'psychic': 'Psíquico',
      'bug': 'Inseto',
      'rock': 'Pedra',
      'ghost': 'Fantasma',
      'dragon': 'Dragão',
      'dark': 'Sombrio',
      'steel': 'Aço',
      'fairy': 'Fada',
    };

    return typeTranslations[type.toLowerCase()] ?? type;
  }
}

/// Lista horizontal de badges de tipo
class TypeBadgeList extends StatelessWidget {
  final List<String> types;
  final bool small;

  const TypeBadgeList({super.key, required this.types, this.small = false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xxs,
      children: types.map((type) {
        return TypeBadge(typeName: type, small: small);
      }).toList(),
    );
  }
}
