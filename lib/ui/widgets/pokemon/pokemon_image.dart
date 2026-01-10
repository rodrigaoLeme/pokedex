import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';

/// Image de Pokémon com Loading e Error
///
/// Componente reutilizável para exibir imagens de pokémons
/// com estados de loading e erro tratados.
class PokemonImage extends StatelessWidget {
  final String imageUrl;
  final double? size;
  final BoxFit fit;
  final String? heroTag;

  const PokemonImage({
    super.key,
    required this.imageUrl,
    this.size,
    required this.fit,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      fit: fit,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildError(),
    );

    // Se tem hero tag, envolve com Hero
    if (heroTag != null) {
      return Hero(tag: heroTag!, child: image);
    }

    return image;
  }

  Widget _buildPlaceholder() {
    return SizedBox(
      width: size,
      height: size,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildError() {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Icon(
          Icons.catching_pokemon,
          size: size != null ? size! * 0.5 : 50,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

/// Imagem grande de Pokémon (para tela de detalhes)
class PokemonImageLarge extends StatelessWidget {
  final String imageUrl;
  final int pokemonId;

  const PokemonImageLarge({
    super.key,
    required this.imageUrl,
    required this.pokemonId,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'pokemon-$pokemonId',
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 200,
        fit: BoxFit.contain,
        placeholder: (context, url) => const SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
            ),
          ),
        ),
        errorWidget: (context, url, error) => SizedBox(
          height: 200,
          child: Center(
            child: Icon(
              Icons.catching_pokemon,
              size: 100,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}

/// Avatar circular de Pokémon (para lista pequenas)
class PokemonAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final Color? backgroudColor;

  const PokemonAvatar({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.backgroudColor,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroudColor ?? AppColors.light,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.catching_pokemon,
            size: radius,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
