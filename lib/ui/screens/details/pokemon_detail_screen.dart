import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Tela de Detalhes de um Pokémon
///
/// Exibe informações completa: stats, abilities, sprites, etc.
/// TODO: Implementar com provider e componentes.
class PokemonDetailScreen extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon #$pokemonId'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.catching_pokemon, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Tela de Detalhes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Pokémon ID: $pokemonId'),
            const SizedBox(height: 8),
            const Text('TODO: Implementar detalhes completos'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
