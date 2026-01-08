import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import 'providers.dart';

/// Provider de lista de Pokémons (básica, sem detalhes)
///
/// Retorna [PokemonListResponse] com informações básicas
/// Usa .family para aceitar parâmetros de paginação.
/// Usa .autoDispose para limpar cache quando não for mais usado.
///
/// Exemplo de uso:
/// ```dart
/// final listAsync = ref.watch(pokemonListProvider(page: 0));
/// ````
final pokemonListProvider = FutureProvider.family
    .autoDispose<PokemonListResponse, int>((ref, page) async {
      final repository = ref.watch(pokemonRepositoryProvider);

      const limit = 20;
      final offset = page * limit;

      return repository.getPokemonList(limit: limit, offset: offset);
    });

/// Provider de lista de Pokémons COM DETALHES COMPLETOS
///
/// Retorna [List<Pokemon>] com todos os detalhes (stats, abilities, etc).
/// WARNING: Mais lento que o provider acima, pois faz múltipas requisições!
///
/// Exemplo de uso:
/// ```dart
/// final pokemonsAsync = ref.watch(pokemonListWithDetailsProvider(page: 0));
/// ````
final pokemonListWithDetailsProvider = FutureProvider.family
    .autoDispose<List<Pokemon>, int>((ref, page) async {
      final repository = ref.watch(pokemonRepositoryProvider);

      const limit = 20;
      final offset = page * limit;

      return repository.getPokemonListWithDetails(limit: limit, offset: offset);
    });

/// Provider de busca de Pokémons por nome
///
/// Retorna Lista de Pokémons que contém o termo buscado.
/// Se query estiver vazia, retorna lista vazia.
///
/// Exemplo de uso:
/// ```dart
/// final resultsAsync = ref.watch(pokemonSearchProvider('pika'));💁‍♂️
/// ````
final pokemonSearchProvider = FutureProvider.family
    .autoDispose<List<Pokemon>, String>((ref, query) async {
      if (query.isEmpty) {
        return [];
      }

      final repository = ref.watch(pokemonRepositoryProvider);
      return repository.searchPokemonByName(query);
    });

/// Provider de filtro por tipo
///
/// Retorna lista de Pokémons de um tipo específico.
///
/// Exemplo de uso:
/// ```dart
/// final firePokemons = ref.watch(pokemonsByTypeProvider('fire'));🔥
/// ````
final pokemonsByTypeProvider = FutureProvider.family
    .autoDispose<List<Pokemon>, String>((ref, type) async {
      final repository = ref.watch(pokemonRepositoryProvider);
      return repository.getPokemonsByType(type);
    });
