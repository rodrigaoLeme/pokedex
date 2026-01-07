import '../datasources/pokemon_remote_datasource.dart';
import '../models/models.dart';

/// Repository de Pokémons
///
/// Orquestra os datasources e fornece uma interface limpa
/// para a camada de lógica (providers)
///
/// Responsável por:
/// - Chamar os datasources
/// - Tratar erros de forma amigável
/// - Cachear dados (no futuro)
/// - Aplicar regras de negócio
class PokemonRepository {
  final PokemonRemoteDataSource remoteDatasource;

  PokemonRepository({required this.remoteDatasource});

  /// Busca lista paginada de Pokémons
  ///
  /// Retorna lista de [PokemonBasicInfo] ou lança exceção
  Future<PokemonListResponse> getPokemonList({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      return await remoteDatasource.getPokemonList(
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw Exception('Erro ao carregar lista de pokémons: $e');
    }
  }

  /// Busca detalhes completos de um Pokémon por ID
  Future<Pokemon> getPokemonDetail(int id) async {
    try {
      return await remoteDatasource.getPokemonDetail(id);
    } catch (e) {
      throw Exception('Erro ao carregar pokémon #$id: $e');
    }
  }

  /// Busca detalhes completos de um Pokémon por nome
  Future<Pokemon> getPokemonDetailByName(String name) async {
    try {
      return await remoteDatasource.getPokemonDetailByName(name);
    } catch (e) {
      throw Exception('Erro ao carregar pokémon "$name": $e');
    }
  }

  /// Busca múltiplos pokémons de uma vez
  ///
  /// Útil para carregar detalhes de uma lista básica
  Future<List<Pokemon>> getPokemonBatch(List<int> ids) async {
    try {
      return await remoteDatasource.getPokemonBatch(ids);
    } catch (e) {
      throw Exception('Erro ao carregar pokémons em lote: $e');
    }
  }

  /// Busca de uma lista básica com detalhes completos
  ///
  /// Pega a lista básica e carrega os detalhes de cada um
  Future<List<Pokemon>> getPokemonListWithDetails({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // 1. Busca lista básica
      final listResponse = await getPokemonList(limit: limit, offset: limit);

      // 2. Extrai os IDs
      final ids = listResponse.results.map((info) => info.id).toList();

      // 3. Busca detalhes de todos
      final pokemons = await getPokemonBatch(ids);

      return pokemons;
    } catch (e) {
      throw Exception('Erro ao carregar pokémons com detalhes: $e');
    }
  }

  /// Busca pokémons por tipo
  ///
  /// Nota: A PokéAPI tem um endpoint específico para isso
  /// que seria /type/{id ou name}, mas por enquanto vou
  /// filtrar localmente depois de carregar a lista
  Future<List<Pokemon>> getPokemonsByType(String type) async {
    try {
      // Carrega uma quantidade maior para filtrar
      final pokemons = await getPokemonListWithDetails(limit: 100);

      // Filtrar por tipo
      return pokemons.where((pokemon) {
        return pokemon.types.any((t) => t.type.name == type.toLowerCase());
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar pokémons do tipo $type: $e');
    }
  }

  /// Busca pokémons por nome (search)
  ///
  /// Carrega lista e filtra localmente
  Future<List<Pokemon>> searchPokemonByName(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      // Carrega uma quantidade maior para buscar
      final pokemons = await getPokemonListWithDetails(limit: 150);

      // Filtra por nome
      final lowerQuery = query.toLowerCase();
      return pokemons.where((pokemon) {
        return pokemon.name.toLowerCase().contains(lowerQuery);
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar pokémon "$query": $e');
    }
  }
}
