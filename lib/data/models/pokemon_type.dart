/// Model do Tipo de Pokémon
///
/// Representa um tipo (fire, water, grass, etc)
/// Baseado na estrutura types[] da PokéAPI
class PokemonType {
  final int slot;
  final TypeInfo type;

  const PokemonType({required this.slot, required this.type});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      slot: json['slot'] as int,
      type: TypeInfo.fromJson(json['type'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'slot': slot, 'type': type.toJson()};
  }

  PokemonType copyWith({int? slot, TypeInfo? type}) {
    return PokemonType(slot: slot ?? this.slot, type: type ?? this.type);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonType && other.slot == slot && other.type == type;
  }

  @override
  int get hashCode => Object.hash(slot, type);

  @override
  String toString() => 'PokemonType(slot: $slot, type: $type)';
}

/// Informações detalhadas do tipo
class TypeInfo {
  final String name;
  final String url;

  const TypeInfo({required this.name, required this.url});

  factory TypeInfo.fromJson(Map<String, dynamic> json) {
    return TypeInfo(name: json['name'] as String, url: json['url'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }

  TypeInfo copyWith({String? name, String? url}) {
    return TypeInfo(name: name ?? this.name, url: url ?? this.url);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TypeInfo && other.name == name && other.url == url;
  }

  @override
  int get hashCode => Object.hash(name, url);

  @override
  String toString() => 'TypeInfo(name: $name, url: $url)';
}

/// Extension para helpers do PokemonType
extension PokemonTypeExtension on PokemonType {
  /// Retorna o nome do tipo formatado (primeira letra maiúscula)
  String get displayName {
    final name = type.name;
    if (name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1);
  }

  /// Retorna o nome do tipo em português (expandir depois)
  String get portugueseName {
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

    return typeTranslations[type.name] ?? displayName;
  }

  /// Verifica se é o tipo primário
  bool get isPrimary => slot == 1;

  /// Verifica se é o tipo secundário
  bool get isSecondary => slot == 2;
}
