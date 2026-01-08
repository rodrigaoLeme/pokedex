import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/models.dart';
import '../../data/repositories/pokemon_repository.dart';
import 'providers.dart';

/// Estado da lista de Pokémon
///
/// Armazena a lista atual, página, loading, etc.
class PokemonListState {
  final List<Pokemon> pokemons;
  final int currentPage;
  final bool isLoading;
  final bool hasMore;
  final String? error;

  const PokemonListState({
    this.pokemons = const [],
    this.currentPage = 0,
    this.isLoading = false,
    this.hasMore = true,
    this.error,
  });

  PokemonListState copyWith({
    List<Pokemon>? pokemons,
    int? currentPage,
    bool? isLoading,
    bool? hasMore,
    String? error,
  }) {
    return PokemonListState(
      pokemons: pokemons ?? this.pokemons,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      error: error ?? this.error,
    );
  }
}

/// StateNotifier para gerenciar lista de Pokémons
///
/// Gerencia estado complexo com:
/// = Paginação infinita (carregar mais)
/// - Loading states
/// - Tratamento de erros
/// - Reset da lista
class PokemonListNotifier extends StateNotifier<PokemonListState> {
  final PokemonRepository repository;

  PokemonListNotifier(this.repository) : super(const PokemonListState()) {
    // Carrega primeira página automaticamente
    loadPokemons();
  }

  // Carrega pimeira página (ou reseta a lista)
  Future<void> loadPokemons() async {
    if (state.isLoading) return;

    state = state.copyWith(
      isLoading: true,
      error: null,
      currentPage: 0,
      pokemons: [],
      hasMore: true,
    );

    try {
      final pokemons = await repository.getPokemonListWithDetails(
        limit: 20,
        offset: 0,
      );

      state = state.copyWith(
        pokemons: pokemons,
        currentPage: 0,
        isLoading: false,
        hasMore: pokemons.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Carrega mais pokémons (próxima página)
  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final nextPage = state.currentPage + 1;
      final newPokemons = await repository.getPokemonListWithDetails(
        limit: 20,
        offset: nextPage * 20,
      );

      state = state.copyWith(
        pokemons: [...state.pokemons, ...newPokemons],
        currentPage: nextPage,
        isLoading: false,
        hasMore: newPokemons.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Recarrega do zero (pull to refresh)
  Future<void> refresh() async {
    await loadPokemons();
  }

  /// Filtra por tipo (local)
  void filterByType(String type) {
    final filtered = state.pokemons.where((pokemon) {
      return pokemon.types.any((t) => t.type.name == type.toLowerCase());
    }).toList();

    state = state.copyWith(pokemons: filtered);
  }

  /// Limpa filtros (volta estado original)
  Future<void> clearFilters() async {
    await loadPokemons();
  }
}

/// Provider do PokemonListNotifier
///
/// Gerencia estado da lista com paginação
///
/// Exemplo de uso:
/// ```dart
/// //No Widget
/// final listState = ref.watch(pokemonListNotifierProvider);
/// final notifier = rer.read(pokemonListNotifierProvider.notifier);
///
/// // Carregar mais
/// notifier.loadMore();
///
/// // Refresh
/// notifier.refresh()
///
/// // Acessar dados
/// final pokemons = listState.pokemons;
/// final isLoading = listState.isLoading;
///
/// // Acessar dados
/// final pokemons = listState.pokemons;
/// final isLoading = listState.isLoading;
/// ```
final pokemonListNotifierProvider =
    StateNotifierProvider<PokemonListNotifier, PokemonListState>((ref) {
      final repository = ref.watch(pokemonRepositoryProvider);
      return PokemonListNotifier(repository);
    });
