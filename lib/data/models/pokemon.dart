import 'pokemon_type.dart';
import 'pokemon_stat.dart';
import 'pokemon_ability.dart';
import 'pokemon_sprite.dart';

/// Model principal do Pokémon
///
/// Representa um Pokémon completo com todas suas informações.
/// Baseado na resposta da PokéAPI endpoint /pokemon/{id}
class Pokemon {
  final int id;
  final String name;
  final int height;
  final int weight;
  final List<PokemonType> types;
  final List<PokemonStat> stats;
  final List<PokemonAbility> abilities;
  final PokemonSprite sprites;
  final int order;

  const Pokemon({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.types,
    required this.stats,
    required this.abilities,
    required this.sprites,
    required this.order,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      types: (json['types'] as List)
          .map((e) => PokemonType.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: (json['stats'] as List)
          .map((e) => PokemonStat.fromJson(e as Map<String, dynamic>))
          .toList(),
      abilities: (json['abilities'] as List)
          .map((e) => PokemonAbility.fromJson(e as Map<String, dynamic>))
          .toList(),
      sprites: PokemonSprite.fromJson(json['sprites'] as Map<String, dynamic>),
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'types': types.map((e) => e.toJson()).toList(),
      'stats': stats.map((e) => e.toJson()).toList(),
      'abilities': abilities.map((e) => e.toJson()).toList(),
      'sprites': sprites.toJson(),
      'order': order,
    };
  }

  Pokemon copyWith({
    int? id,
    String? name,
    int? height,
    int? weight,
    List<PokemonType>? types,
    List<PokemonStat>? stats,
    List<PokemonAbility>? abilities,
    PokemonSprite? sprites,
    int? order,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      types: types ?? this.types,
      stats: stats ?? this.stats,
      abilities: abilities ?? this.abilities,
      sprites: sprites ?? this.sprites,
      order: order ?? this.order,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pokemon &&
        other.id == id &&
        other.name == name &&
        other.height == height &&
        other.weight == weight &&
        _listEquals(other.types, types) &&
        _listEquals(other.stats, stats) &&
        _listEquals(other.abilities, abilities) &&
        other.sprites == sprites &&
        other.order == order;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    height,
    weight,
    types,
    stats,
    abilities,
    sprites,
    order,
  );

  @override
  String toString() => 'Pokemon(id: $id, name: $name)';
}

/// Extension para helpers do Pokemon
extension PokemonExtension on Pokemon {
  /// Retorna o nome formatado (primeira letra maiúscula)
  String get displayName {
    if (name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1);
  }

  /// Retorna o ID formatado como #001, #002, etc
  String get formattedId {
    return '#${id.toString().padLeft(3, '0')}';
  }

  /// Retorna a altura em metros
  double get heightInMeters {
    return height / 10.0;
  }

  /// Retorna o peso em quilogramas
  double get weightInKilograms {
    return weight / 10.0;
  }

  /// Retorna o tipo primário (primeiro da lista)
  PokemonType get primaryType {
    return types.first;
  }

  /// Retorna o tipo secundário (se houver)
  PokemonType? get secondaryType {
    return types.length > 1 ? types[1] : null;
  }

  /// Verifica se tem dois tipos
  bool get hasTwoTypes {
    return types.length >= 2;
  }

  /// Retorna a URL da imagem principal (artwork oficial)
  String get mainImageUrl {
    return sprites.officialArtwork;
  }
}

// Helper para comparar listas
bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
