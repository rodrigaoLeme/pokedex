import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Tela de Busca de Pokémons
///
/// Permite buscar pokémons por nome.
/// TODO: Implementar com provider de busca.
class PokemonSearchScreen extends StatelessWidget {
  final String initialQuery;

  const PokemonSearchScreen({super.key, this.initialQuery = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Pokémon'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Tela de Busca',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (initialQuery.isNotEmpty) Text('Query inicial: $initialQuery'),
            const SizedBox(height: 8),
            const Text('TODO: Implementar busca'),
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
