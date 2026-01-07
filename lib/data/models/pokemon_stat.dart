/// Model de Stat do Pokémon
///
/// Representa uma estatística (HP, Attack, Defense, etc)
/// Baseado na estrutura stats[] da PokéAPI
class PokemonStat {
  final int baseStat;
  final int effort;
  final StatInfo stat;

  const PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(
      baseStat: json['base_stat'] as int,
      effort: json['effort'] as int,
      stat: StatInfo.fromJson(json['stat'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'base_stat': baseStat, 'effort': effort, 'stat': stat.toJson()};
  }

  PokemonStat copyWith({int? baseStat, int? effort, StatInfo? stat}) {
    return PokemonStat(
      baseStat: baseStat ?? this.baseStat,
      effort: effort ?? this.effort,
      stat: stat ?? this.stat,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonStat &&
        other.baseStat == baseStat &&
        other.effort == effort &&
        other.stat == stat;
  }

  @override
  int get hashCode => Object.hash(baseStat, effort, stat);

  @override
  String toString() =>
      'PokemonStat(baseStat: $baseStat, effort: $effort, stat: $stat)';
}

/// Informações detalhadas da stat
class StatInfo {
  final String name;
  final String url;

  const StatInfo({required this.name, required this.url});

  factory StatInfo.fromJson(Map<String, dynamic> json) {
    return StatInfo(name: json['name'] as String, url: json['url'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }

  StatInfo copyWith({String? name, String? url}) {
    return StatInfo(name: name ?? this.name, url: url ?? this.url);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StatInfo && other.name == name && other.url == url;
  }

  @override
  int get hashCode => Object.hash(name, url);

  @override
  String toString() => 'StatInfo(name: $name, url: $url)';
}

/// Extension para helpers do PokemonStat
extension PokemonStatExtension on PokemonStat {
  /// Retorna o nome da stat formatado (sigla em maiúsculas)
  String get displayName {
    final name = stat.name;

    // Mapeamento dos nomes da API para siglas
    const statNames = {
      'hp': 'HP',
      'attack': 'ATK',
      'defense': 'DEF',
      'special-attack': 'SATK',
      'special-defense': 'SDEF',
      'speed': 'SPD',
    };

    return statNames[name] ?? name.toUpperCase();
  }

  /// Retorna o nome completo em português
  String get portugueseName {
    const statTranslations = {
      'hp': 'Vida',
      'attack': 'Ataque',
      'defense': 'Defesa',
      'special-attack': 'Ataque Especial',
      'special-defense': 'Defesa Especial',
      'speed': 'Velocidade',
    };

    return statTranslations[stat.name] ?? displayName;
  }

  /// Retorna a porcentagem da stat (baseado em max 255)
  double get percentage {
    const maxStat = 255.0;
    return (baseStat / maxStat).clamp(0.0, 1.0);
  }

  /// Verifica se é HP
  bool get isHp => stat.name == 'hp';

  /// Verifica se é Attack
  bool get isAttack => stat.name == 'attack';

  /// Verifica se é Defense
  bool get isDefense => stat.name == 'defense';

  /// Verifica se é Special Attack
  bool get isSpecialAttack => stat.name == 'special-attack';

  /// Verifica se é Special Defense
  bool get isSpecialDefense => stat.name == 'special-defense';

  /// Verifica se é Speed
  bool get isSpeed => stat.name == 'speed';
}

/// Extension para lista de stats
extension PokemonStatListExtension on List<PokemonStat> {
  /// Retorna o total de todas as stats
  int get total {
    return fold(0, (sum, stat) => sum + stat.baseStat);
  }

  /// Retorna a stat de HP
  PokemonStat? get hp {
    try {
      return firstWhere((stat) => stat.isHp);
    } catch (_) {
      return null;
    }
  }

  /// Retorna a stat de Attack
  PokemonStat? get attack {
    try {
      return firstWhere((stat) => stat.isAttack);
    } catch (_) {
      return null;
    }
  }

  /// Retorna a stat de Defense
  PokemonStat? get defense {
    try {
      return firstWhere((stat) => stat.isDefense);
    } catch (_) {
      return null;
    }
  }

  /// Retorna a stat de Special Attack
  PokemonStat? get specialAttack {
    try {
      return firstWhere((stat) => stat.isSpecialAttack);
    } catch (_) {
      return null;
    }
  }

  /// Retorna a stat de Special Defense
  PokemonStat? get specialDefense {
    try {
      return firstWhere((stat) => stat.isSpecialDefense);
    } catch (_) {
      return null;
    }
  }

  /// Retorna a stat de Speed
  PokemonStat? get speed {
    try {
      return firstWhere((stat) => stat.isSpeed);
    } catch (_) {
      return null;
    }
  }
}
