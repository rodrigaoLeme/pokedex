/// Model dos Sprites/Imagens do Pokémon
///
/// Representa as URLs das diferente versões de imagens
/// Baseado na estrutura sprites da PokéAPI
class PokemonSprite {
  final String? frontDefault;
  final String? frontShiny;
  final String? backDefault;
  final String? backShiny;
  final PokemonOtherSprites? other;

  const PokemonSprite({
    this.frontDefault,
    this.frontShiny,
    this.backDefault,
    this.backShiny,
    this.other,
  });

  factory PokemonSprite.fromJson(Map<String, dynamic> json) {
    return PokemonSprite(
      frontDefault: json['front_default'] as String?,
      frontShiny: json['front_shiny'] as String?,
      backDefault: json['back_default'] as String?,
      backShiny: json['back_shiny'] as String?,
      other: json['other'] != null
          ? PokemonOtherSprites.fromJson(['other'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'front_shiny': frontShiny,
      'back_default': backDefault,
      'back_shiny': backShiny,
      'other': other?.toJson(),
    };
  }

  PokemonSprite copyWith({
    String? frontDefault,
    String? frontShiny,
    String? backDefault,
    String? backShiny,
    PokemonOtherSprites? other,
  }) {
    return PokemonSprite(
      frontDefault: frontDefault ?? this.frontDefault,
      frontShiny: frontShiny ?? this.frontShiny,
      backDefault: backDefault ?? this.backDefault,
      backShiny: backShiny ?? this.backShiny,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonSprite &&
        other.frontDefault == frontDefault &&
        other.frontShiny == frontShiny &&
        other.backDefault == backDefault &&
        other.backShiny == backShiny &&
        other.other == this.other;
  }

  @override
  int get hashCode =>
      Object.hash(frontDefault, frontShiny, backDefault, backShiny, other);

  @override
  String toString() =>
      'PokemonSprite(frontDefault: $frontDefault, other: $other)';
}

/// Outras versões de sprites
class PokemonOtherSprites {
  final OfficialArtwork? officialArtwork;
  final DreamWorld? dreamWorld;
  final PokemonHome? home;

  const PokemonOtherSprites({this.officialArtwork, this.dreamWorld, this.home});

  factory PokemonOtherSprites.fromJson(Map<String, dynamic> json) {
    return PokemonOtherSprites(
      officialArtwork: json['official-artwork'] != null
          ? OfficialArtwork.fromJson(
              json['official-artwork'] as Map<String, dynamic>,
            )
          : null,
      dreamWorld: json['dream_world'] != null
          ? DreamWorld.fromJson(json['dream_world'] as Map<String, dynamic>)
          : null,
      home: json['home'] != null
          ? PokemonHome.fromJson(json['home'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official-artwork': officialArtwork?.toJson(),
      'dream_world': dreamWorld?.toJson(),
      'home': home?.toJson(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonOtherSprites &&
        other.officialArtwork == officialArtwork &&
        other.dreamWorld == dreamWorld &&
        other.home == home;
  }

  @override
  int get hashCode => Object.hash(officialArtwork, dreamWorld, home);
}

/// Official Artwork
class OfficialArtwork {
  final String? frontDefault;
  final String? frontShiny;

  const OfficialArtwork({this.frontDefault, this.frontShiny});

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) {
    return OfficialArtwork(
      frontDefault: json['front_default'] as String?,
      frontShiny: json['front_shiny'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'front_default': frontDefault, 'front_shiny': frontShiny};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OfficialArtwork &&
        other.frontDefault == frontDefault &&
        other.frontShiny == frontShiny;
  }

  @override
  int get hashCode => Object.hash(frontDefault, frontShiny);
}

/// Dream World sprites
class DreamWorld {
  final String? frontDefault;
  final String? frontFamele;

  const DreamWorld({this.frontDefault, this.frontFamele});

  factory DreamWorld.fromJson(Map<String, dynamic> json) {
    return DreamWorld(
      frontDefault: json['front_default'] as String?,
      frontFamele: json['front_female'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'front_default': frontDefault, 'front_female': frontFamele};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DreamWorld &&
        other.frontDefault == frontDefault &&
        other.frontFamele == frontFamele;
  }

  @override
  int get hashCode => Object.hash(frontDefault, frontFamele);
}

/// Pokemon Home sprites
class PokemonHome {
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  const PokemonHome({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  factory PokemonHome.fromJson(Map<String, dynamic> json) {
    return PokemonHome(
      frontDefault: json['front_default'] as String?,
      frontFemale: json['front_female'] as String?,
      frontShiny: json['front_shiny'] as String?,
      frontShinyFemale: json['front_shiny_female'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front_default': frontDefault,
      'front_female': frontFemale,
      'front_shiny': frontShiny,
      'front_shiny_female': frontShinyFemale,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonHome &&
        other.frontDefault == frontDefault &&
        other.frontFemale == frontFemale &&
        other.frontShiny == frontShiny &&
        other.frontShinyFemale == frontShinyFemale;
  }

  @override
  int get hashCode =>
      Object.hash(frontDefault, frontFemale, frontShiny, frontShinyFemale);
}

/// Extension para helpers do PokemonSprite
extension PokemonSpriteExtension on PokemonSprite {
  /// Retorna a URL da melhor imagem disponível (prioridade: artwork > sprite)
  String get bestImageUrl {
    // 1. Tenta artwork oficial
    final artwork = other?.officialArtwork?.frontDefault;
    if (artwork != null && artwork.isNotEmpty) return artwork;

    // 2. Tenta home
    final home = other?.home?.frontDefault;
    if (home != null && home.isNotEmpty) return home;

    // 3. Fallback para sprite padrão
    return frontDefault ?? '';
  }

  /// Retorna a URL da imagem oficial (artwork)
  String get officialArtwork {
    return other?.officialArtwork?.frontDefault ?? bestImageUrl;
  }

  /// Retorna a URL da versão shiny
  String get shinyImageUrl {
    // 1. Tenta artwork shiny
    final artwork = other?.officialArtwork?.frontShiny;
    if (artwork != null && artwork.isNotEmpty) return artwork;

    // 2. Tenta home shiny
    final home = other?.home?.frontShiny;
    if (home != null && home.isNotEmpty) return home;

    // 3. Fallback para sprite shiny
    return frontShiny ?? '';
  }

  /// Verifica se tem artwork oficial disponível
  bool get hasOfficialArtwork {
    return other?.officialArtwork?.frontDefault != null;
  }

  /// Verifica se tem versão shiny disponível
  bool get hasShinyVersion {
    return frontShiny != null ||
        other?.officialArtwork?.frontShiny != null ||
        other?.home?.frontShiny != null;
  }
}
