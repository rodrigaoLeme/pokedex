import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/models.dart';

/// Barra de Stat Individual
///
/// Exibe uma stat com:
/// - Nome da stat (HP, ATK, DEF, etc)
/// - Valor numérico
/// - Barra de progresso colorida
class StatBar extends StatelessWidget {
  final String statName;
  final int statValue;
  final double percentage;
  final Color? color;

  const StatBar({
    super.key,
    required this.statName,
    required this.statValue,
    required this.percentage,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Cor da barra baseada no valor
    final barColor = color ?? _getColorByValue(statValue);

    return Row(
      children: [
        // Nome da stat (ex: HP, ATL)
        SizedBox(
          width: 50,
          child: Text(
            statName,
            style: AppTextStyles.body3.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: AppSpacing.sm),

        // Valor numérico (ex: 45)
        SizedBox(
          width: 35,
          child: Text(
            statValue.toString(),
            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        ),

        const SizedBox(width: AppSpacing.sm),

        // Barra de progresso
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: AppColors.light,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
              minHeight: 6,
            ),
          ),
        ),
      ],
    );
  }

  Color _getColorByValue(int value) {
    // Cires baseadas no valor da stat
    if (value >= 150) return Colors.green;
    if (value >= 100) return Colors.lightGreen;
    if (value >= 75) return Colors.orange;
    if (value >= 50) return Colors.deepOrange;
    return Colors.red;
  }
}

/// Lista completa de Stats
///
/// Exibe todas as 6 stats de um pokémon:
/// HP, Attack, Defense, SP. Atk, Sp. Def, Speed
class StatsList extends StatelessWidget {
  final List<PokemonStat> stats;
  final Color? color;

  const StatsList({super.key, required this.stats, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stats.map((stat) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: StatBar(
            statName: stat.displayName,
            statValue: stat.baseStat,
            percentage: stat.percentage,
            color: color,
          ),
        );
      }).toList(),
    );
  }
}

/// Seção de Base State (com título e total)
class BaseStatsSection extends StatelessWidget {
  final List<PokemonStat> stats;
  final Color? color;

  const BaseStatsSection({super.key, required this.stats, this.color});

  @override
  Widget build(BuildContext context) {
    final total = stats.total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título
        Text(
          'Base Stats',
          style: AppTextStyles.subtitle1.copyWith(
            color: color ?? AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        // Lista de stats
        StatsList(stats: stats, color: color),

        const SizedBox(height: AppSpacing.xs),

        // Total
        Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                'Total',
                style: AppTextStyles.body3.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),

            Text(
              total.toString(),
              style: AppTextStyles.body2.copyWith(
                fontWeight: FontWeight.bold,
                color: color ?? AppColors.textPrimary,
              ),
            ),

            const SizedBox(width: AppSpacing.sm),

            Expanded(
              child: Container(height: 2, color: color ?? AppColors.primary),
            ),
          ],
        ),
      ],
    );
  }
}

// Mini Stat (versão compacta para cards)
class MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const MiniStat({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(height: 4),
        ],
        Text(
          value,
          style: AppTextStyles.subtitle2.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
