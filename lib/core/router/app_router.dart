import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/screens/home/pokemon_list_screen.dart';
import '../../ui/screens/details/pokemon_detail_screen.dart';
import '../../ui/screens/search/pokemon_search_screen.dart';

/// Configuração de rotas do app com GoRouter
///
/// Define todas as rotas e navegação do aplicativo.
/// Suporta deep linking automaticamente!
class AppRouter {
  /// Cria instância do GoRouter
  static GoRouter createRouter() {
    return GoRouter(
      // Rota inicial
      initialLocation: '/',

      // Define as rotas
      routes: [
        // ========================================
        // HOME - Lista de Pokémons
        // ========================================
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const PokemonListScreen(),
        ),

        // ========================================
        // DETALHES - Detalhes de 1 Pokémon
        // ========================================
        GoRoute(
          path: '/pokemon/:id',
          name: 'details',
          builder: (context, state) {
            // Extrai o ID da URL
            final idParam = state.pathParameters['id'];

            // Valida se o ID é válido
            if (idParam == null) {
              // Se não houver ID, volta pra home
              return const PokemonListScreen();
            }

            final id = int.tryParse(idParam);
            if (id == null || id <= 0) {
              // ID inválido, volta pra home
              return const PokemonListScreen();
            }

            // ID válido, mostra detalhes
            return PokemonDetailScreen(pokemonId: id);
          },
        ),

        // ========================================
        // BUSCA - Buscar Pokémons
        // ========================================
        GoRoute(
          path: '/search',
          name: 'search',
          builder: (context, state) {
            // Pega query opcional da URL (?q=pikachu)
            final query = state.uri.queryParameters['q'] ?? '';
            return PokemonSearchScreen(initialQuery: query);
          },
        ),
      ],

      // Rota de erro (404)
      errorBuilder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Erro')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Página não encontrada',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Rota ${state.uri}'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Voltar para Home'),
                ),
              ],
            ),
          ),
        );
      },

      // Debug de navegação (desabilitar em produção)
      debugLogDiagnostics: true,
    );
  }
}

/// Extension para facilitar navegação
///
/// Adiciona métodos helper no BuildContext
extension GoRouterExtension on BuildContext {
  /// Navega para detalhes de um pokémon
  void goToPokemonDetail(int id) {
    go('/pokemon/$id');
  }

  /// Navega para home
  void goToHome() {
    go('/');
  }

  /// Navega para busca
  void goToSearch({String? query}) {
    if (query != null && query.isNotEmpty) {
      go('/search?q=$query');
    } else {
      go('/search');
    }
  }
}
