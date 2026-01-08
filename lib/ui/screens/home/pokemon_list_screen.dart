import 'package:flutter/material.dart';

/// Tele de Lista de Pokémons
///
/// Exibe grid de pokémons com paginação infinita.
/// TODO: Implementar com providers e componentes.
class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokédex')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.catching_pokemon, size: 64),
            SizedBox(height: 16),
            Text(
              'Tela de Lista',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('TODO: Implementar grid de pokémons'),
          ],
        ),
      ),
    );
  }
}
