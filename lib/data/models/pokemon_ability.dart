/// Model de Habilidade do Pokémon
///
/// Representa uma habilidade (ability)
/// Baseado na estrutura abilities[] da PokéAPI
class PokemonAbility {
  final bool isHidden;
  final int slot;
  final AbilityInfo ability;

  const PokemonAbility({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  // fromJson
  factory PokemonAbility.fromJson(Map<String, dynamic> json) {
    return PokemonAbility(
      isHidden: json['is_hidden'] as bool,
      slot: json['slot'] as int,
      ability: AbilityInfo.fromJson(json['ability'] as Map<String, dynamic>),
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {'is_hidden': isHidden, 'slot': slot, 'ability': ability.toJson()};
  }

  // copyWith
  PokemonAbility copyWith({bool? isHidden, int? slot, AbilityInfo? ability}) {
    return PokemonAbility(
      isHidden: isHidden ?? this.isHidden,
      slot: slot ?? this.slot,
      ability: ability ?? this.ability,
    );
  }

  // Equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonAbility &&
        other.isHidden == isHidden &&
        other.slot == slot &&
        other.ability == ability;
  }

  @override
  int get hashCode => Object.hash(isHidden, slot, ability);

  @override
  String toString() =>
      'PokemonAbility(isHidden: $isHidden, slot: $slot, ability: $ability)';
}

/// Informações detalhadas da habilidade
class AbilityInfo {
  final String name;
  final String url;

  const AbilityInfo({required this.name, required this.url});

  factory AbilityInfo.fromJson(Map<String, dynamic> json) {
    return AbilityInfo(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }

  AbilityInfo copyWith({String? name, String? url}) {
    return AbilityInfo(name: name ?? this.name, url: url ?? this.url);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AbilityInfo && other.name == name && other.url == url;
  }

  @override
  int get hashCode => Object.hash(name, url);

  @override
  String toString() => 'AbilityInfo(name: $name, url: $url)';
}

/// Extension para helpers do PokemonAbility
extension PokemonAbilityExetension on PokemonAbility {
  /// Retorna o nome formatado (palavras capitalizadas)
  String get displayName {
    final name = ability.name;
    if (name.isEmpty) return '';

    return name
        .split('-')
        .map(
          (word) =>
              word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }

  /// Retorna label indicando se é habilidade oculta
  String get label {
    return isHidden ? 'Habilidade Oculta' : 'Habilidade';
  }

  /// Retorna o nome completo com label
  String get fullDisplayName {
    return isHidden ? '$displayName (Oculta)' : displayName;
  }
}

/// Extension para lista de habilidades
extension PokemonAbilityListExtension on List<PokemonAbility> {
  /// Retorna apenas as habilidades visíveis (não ocultas)
  List<PokemonAbility> get visible {
    return where((ability) => !ability.isHidden).toList();
  }

  /// Retorna penas as habilidades ocultas
  List<PokemonAbility> get hidden {
    return where((ability) => ability.isHidden).toList();
  }

  /// Retorna a primeira habilidade visível
  PokemonAbility? get primaryAbility {
    final visibleAbilities = visible;
    return visibleAbilities.isNotEmpty ? visibleAbilities.first : null;
  }

  /// Return a habilidade oculta (se houver)
  PokemonAbility? get hiddenAbility {
    try {
      return firstWhere((ability) => ability.isHidden);
    } catch (_) {
      return null;
    }
  }
}
