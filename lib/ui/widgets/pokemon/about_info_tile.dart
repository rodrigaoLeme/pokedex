import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';

/// Tile de Iformação (Peso, Altura, Habilidades)
///
/// Exibe uma informação do pokémon com:
/// - Ícone
/// - Valor
/// - Label
class AboutInfoTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const AboutInfoTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ícone
        Container(
          padding: const EdgeInsets.all(AppSpacing.xs),
          decoration: BoxDecoration(
            color: AppColors.light,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Icon(
            icon,
            size: AppSpacing.iconMd,
            color: AppColors.textSecondary,
          ),
        ),

        const SizedBox(height: AppSpacing.xs),

        // Valor
        Text(
          value,
          style: AppTextStyles.subtitle1.copyWith(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 4),

        // Label
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

/// Tile compacto (inline)
class AboutInfoTileCompact extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const AboutInfoTileCompact({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: AppSpacing.xs),
        Text(
          value,
          style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

/// Seção About completa (peso, altura, habilidades)
class AboutSection extends StatelessWidget {
  final double weightKg;
  final double heightM;
  final List<String> abilities;
  final Color? color;

  const AboutSection({
    super.key,
    required this.weightKg,
    required this.heightM,
    required this.abilities,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Text(
          'About',
          style: AppTextStyles.subtitle1.copyWith(
            color: color ?? AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Row com peso, altura e habilidade
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Peso
            AboutInfoTile(
              icon: Icons.monitor_weight_outlined,
              value: '${weightKg.toStringAsFixed(1)} kg',
              label: 'Weight',
            ),

            // Altura
            AboutInfoTile(
              icon: Icons.straight,
              value: '${heightM.toStringAsFixed(1)} m',
              label: 'Height',
            ),

            // Habilidades
            AboutInfoTile(
              icon: Icons.flash_on,
              value: abilities.length.toString(),
              label: abilities.length == 1 ? 'Ability' : 'Abilities',
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // Lista de habilidades (nomes)
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xxs,
          children: abilities.map((ability) {
            return Chip(
              label: Text(ability, style: AppTextStyles.caption),
              backgroundColor: AppColors.light,
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Info Row simples (label: valor)
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            '$label:',
            style: AppTextStyles.body3.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.body3.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
