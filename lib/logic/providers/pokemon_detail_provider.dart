import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import 'providers.dart';

/// Provider de detalhes de um Pokémon por ID
///
/// Retorna [Pokemon] com todos os detalhes (stats, abilities, sprites, etc).
/// Usa .family para aceitar o ID como parâmetro.
/// Usa .autoDispose para limpar cache quando widget for destruído.
///
/// Exemplo de uso:
/// ```dart
/// final pokemonAsync = ref.watch(pokemonDetailProvider(25)); //🐁⚡️
///
/// pokemonAsync.when(
///   loading: () => CircularProgressIndicator(),
///   error: (err, stack) => Text('Erro: $err'),
///   data: (pokemon) => Text(pokemon.displayName),
/// );
/// ````
final pokemonDetailProvider = FutureProvider.family.autoDispose<Pokemon, int>((
  ref,
  id,
) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.getPokemonDetail(id);
});

/// Orivuder de detalhes de um Pokémon por NOME
///
/// Retorna [Pokemon] buscando pelo nome ao invés do ID.
/// Útil quando você tem o nome mas não o ID.
///
/// Exemplo de uso:
/// ```dart
/// final pokemonAsync = ref.watch(pokemonDetailsByNameProvider('pikachu'));
/// ````
final pokemonDetailsByNameProvider = FutureProvider.family
    .autoDispose<Pokemon, String>((ref, name) async {
      final repository = ref.watch(pokemonRepositoryProvider);
      return repository.getPokemonDetailByName(name);
    });

/// Provider de múltiplos Pokémons (batch)
///
/// Retorna [List<Pokemon>] buscando vários de uma vez.
/// Mais eficiente que buscar um por um.
///
/// Exemplo de uso:
/// ```dart
/// final pokemonsAsync = ref.watch(pokemonBatchProvider([1, 4, 7]));
/// // Busca Bulbasaur, Charmander e Squirtle ao mesmo tempo
/// ```
final pokemonBatchProvider = FutureProvider.family
    .autoDispose<List<Pokemon>, List<int>>((ref, ids) async {
      final repository = ref.watch(pokemonRepositoryProvider);
      return repository.getPokemonBatch(ids);
    });
