import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/pokemon_type_colors.dart';
import '../../../data/models/models.dart';
import 'type_badge.dart';

/// Card de Pokémon para Grid
///
/// Exibe:
/// - Número de pokémon (#001)
/// - Nome
/// - Imagem
/// - Badge de tipo (se houver espaço)
/// - Fund com cor do tipo primário
class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback? onTap;

  const PokemonCard({super.key, required this.pokemon, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Pega cor do tipo primário
    final typeColor = PokemonTypeColors.getTypeColor(
      pokemon.primaryType.type.name,
    );
    final lightTypeColor = PokemonTypeColors.getTypeLightColor(
      pokemon.primaryType.type.name,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: lightTypeColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow2dp,
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Padrão de pokébola no fundo (decorativo)
            Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: 0.2,
                child: Icon(Icons.circle, size: 100, color: typeColor),
              ),
            ),

            // Conteúdo
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Número do pokémon (#001)
                  Text(
                    pokemon.formattedId,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.black.withValues(alpha: 0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Nome do pokémon
                  Text(
                    pokemon.displayName,
                    style: AppTextStyles.subtitle1.copyWith(
                      color: AppColors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Badge do tipo (só o primeiro para economizar espaço)
                  TypeBadge(
                    typeName: pokemon.primaryType.type.name,
                    small: true,
                  ),

                  const Spacer(),

                  // Imagem do pokémon
                  Center(
                    child: Hero(
                      tag: 'pokemon-${pokemon.id}',
                      child: CachedNetworkImage(
                        imageUrl: pokemon.mainImageUrl,
                        height: 80,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const SizedBox(
                          height: 80,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.catching_pokemon,
                          size: 80,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Versão simplificada do card (para lista básica sem detalhes completos)
class PokemonCardSimple extends StatelessWidget {
  final String name;
  final String formattedId;
  final String imageUrl;
  final String primaryType;
  final VoidCallback? onTap;

  const PokemonCardSimple({
    super.key,
    required this.name,
    required this.formattedId,
    required this.imageUrl,
    required this.primaryType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final typeColor = PokemonTypeColors.getTypeColor(primaryType);
    final lightTypeColor = PokemonTypeColors.getTypeLightColor(primaryType);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: lightTypeColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow2dp,
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Padrão de pokébola
            Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: 0.2,
                child: Icon(Icons.circle, size: 100, color: typeColor),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Número
                  Text(
                    formattedId,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.black.withValues(alpha: 0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Nome
                  Text(
                    name,
                    style: AppTextStyles.subtitle1.copyWith(
                      color: AppColors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Badge
                  TypeBadge(typeName: primaryType, small: true),

                  const Spacer(),

                  // Imagem
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 80,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const SizedBox(
                        height: 80,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.catching_pokemon,
                        size: 80,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
