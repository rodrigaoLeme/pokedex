/// Model da resposta da lista de Pokémons
class PokemonListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonBasicInfo> results;

  const PokemonListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    return PokemonListResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List)
          .map((e) => PokemonBasicInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }

  PokemonListResponse copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonBasicInfo>? results,
  }) {
    return PokemonListResponse(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonListResponse &&
        other.count == count &&
        other.next == next &&
        other.previous == previous &&
        _listEquals(other.results, results);
  }

  @override
  int get hashCode => Object.hash(count, next, previous, results);

  @override
  String toString() =>
      'PokemonListResponse(count: $count, results: ${results.length})';
}

/// Informações básicas do Pokémon
class PokemonBasicInfo {
  final String name;
  final String url;

  const PokemonBasicInfo({required this.name, required this.url});

  factory PokemonBasicInfo.fromJson(Map<String, dynamic> json) {
    return PokemonBasicInfo(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url};
  }

  PokemonBasicInfo copyWith({String? name, String? url}) {
    return PokemonBasicInfo(name: name ?? this.name, url: url ?? this.url);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PokemonBasicInfo && other.name == name && other.url == url;
  }

  @override
  int get hashCode => Object.hash(name, url);

  @override
  String toString() => 'PokemonBasicInfo(name: $name)';
}

/// Extension para helpers do PokemonListResponse
extension PokemonListResponseExtension on PokemonListResponse {
  /// Verifica se tem a próxima página
  bool get hasNext => next != null;

  /// Verifica se tem a página anterior
  bool get hasPrevious => previous != null;

  /// Verficica se é a primeira página
  bool get isFirstPage => previous == null;

  /// Verifica se é a última página
  bool get isLastPage => next == null;

  /// Retorna o número total de páginas (estimado, baseado em 20 por página)
  int get totalPages {
    return (count / 20).ceil();
  }
}

/// Extension para helpers do PokemonBasicInfo
extension PokemonBasicInfoExtension on PokemonBasicInfo {
  /// Extrai o ID do Pokémon a partir da URL
  /// Ex: "https://pokeapi.co/api/v2/pokemon/25/" → 25
  int get id {
    // Remove trailing slash se houver
    final cleanUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;

    // Pega o último segmento da URL
    final segments = cleanUrl.split('/');
    final idString = segments.last;

    // Converte para int
    return int.tryParse(idString) ?? 0;
  }

  /// Retorna o nome formatado (primeira letra maiúscula)
  String get displayName {
    if (name.isEmpty) return '';
    return name[0].toUpperCase() + name.substring(1);
  }

  /// Retorna o ID formatado como #001, #002, etc)
  String get formattedId {
    return '#${id.toString().padLeft(3, '0')}';
  }

  /// Retorna a URL da imagem oficial (sem precisar chamar a API de detalhes)
  String get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  /// Retorna a URL do sprite (versão menor)
  String get spriteUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
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
