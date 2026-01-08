import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/data/models/models.dart';
import 'package:pokedex/core/network/dio_config.dart';
import 'package:pokedex/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedex/data/repositories/pokemon_repository.dart';
import 'package:pokedex/logic/providers/pokemon_detail_provider.dart';
import 'package:pokedex/logic/providers/pokemon_list_notifier.dart';
import 'package:pokedex/logic/providers/pokemon_list_provider.dart';
import 'package:pokedex/logic/providers/providers.dart';

void main() async {
  runApp(const MyApp());
  testProvider();
}

Future<void> testDio() async {
  final dio = DioConfig.createDio();
  final dataSource = PokemonRemoteDataSource(dio: dio);
  final repository = PokemonRepository(remoteDatasource: dataSource);

  try {
    print('🔍 Buscando Pikachu...\n');
    final pikachu = await repository.getPokemonDetail(25);

    print('✅ Sucesso!');
    print('Nome: ${pikachu.displayName}');
    print('ID: ${pikachu.formattedId}');
    print('Tipo: ${pikachu.primaryType.displayName}');
    print('HP: ${pikachu.stats.hp?.baseStat}');
  } catch (e) {
    print('❌ Erro: $e');
  }
}

Future<void> testProvider() async {
  print('🧪 TESTANDO PROVIDERS COM RIVERPOD\n');

  final container = ProviderContainer();

  try {
    // ========================================
    // TESTE 1: Provider de Dependências
    // ========================================
    print('📦 Teste 1: Providers de Dependência');
    print('─────────────────────────────────────');

    final dio = container.read(dioProvider);
    print('✅ Dio configurado: ${dio.options.baseUrl}');

    final dataSource = container.read(pokemonRemoteDataSourceProvider);
    print('✅ DataSource criado: ${dataSource.runtimeType}');

    final repository = container.read(pokemonRepositoryProvider);
    print('✅ Repository criado: ${repository.runtimeType}\n');

    // ========================================
    // TESTE 2: Lista de Pokémons
    // ========================================
    print('📋 Teste 2: Lista de Pokémons (página 0)');
    print('─────────────────────────────────────');

    // Aguarda o provider carregar
    final listAsync = await container.read(pokemonListProvider(0).future);

    print('✅ Total de pokémons: ${listAsync.count}');
    print('✅ Resultados nesta página: ${listAsync.results.length}');
    print('✅ Tem próxima página? ${listAsync.hasNext}');
    print('✅ Primeiros 3 pokémons:');
    for (var i = 0; i < 3 && i < listAsync.results.length; i++) {
      final info = listAsync.results[i];
      print('   ${info.formattedId} - ${info.displayName}');
    }
    print('');

    // ========================================
    // TESTE 3: Detalhes do Pikachu
    // ========================================
    print('🔍 Teste 3: Detalhes do Pikachu (#25)');
    print('─────────────────────────────────────');

    final pikachu = await container.read(pokemonDetailProvider(25).future);

    print('✅ Nome: ${pikachu.displayName}');
    print('✅ ID: ${pikachu.formattedId}');
    print('✅ Tipo primário: ${pikachu.primaryType.displayName}');
    print(
      '✅ Tipo secundário: ${pikachu.secondaryType?.displayName ?? 'Nenhum'}',
    );
    print('✅ Altura: ${pikachu.heightInMeters}m');
    print('✅ Peso: ${pikachu.weightInKilograms}kg');
    print('✅ HP: ${pikachu.stats.hp?.baseStat}');
    print('✅ Attack: ${pikachu.stats.attack?.baseStat}');
    print('✅ Defense: ${pikachu.stats.defense?.baseStat}');
    print('✅ Total Stats: ${pikachu.stats.total}');
    print('✅ Habilidades: ${pikachu.abilities.length}');
    for (var ability in pikachu.abilities) {
      print(
        '   - ${ability.displayName} ${ability.isHidden ? '(Oculta)' : ''}',
      );
    }
    print('');

    // ========================================
    // TESTE 4: Busca por "pika"
    // ========================================
    print('🔎 Teste 4: Busca por "pika"');
    print('─────────────────────────────────────');

    final searchResults = await container.read(
      pokemonSearchProvider('pika').future,
    );

    print('✅ Resultados encontrados: ${searchResults.length}');
    for (var pokemon in searchResults) {
      print('   ${pokemon.formattedId} - ${pokemon.displayName}');
    }
    print('');

    // ========================================
    // TESTE 5: Batch (múltiplos pokémons)
    // ========================================
    print('📦 Teste 5: Buscar múltiplos pokémons [1, 4, 7]');
    print('─────────────────────────────────────');

    final batchPokemons = await container.read(
      pokemonBatchProvider([1, 4, 7]).future,
    );

    print('✅ Pokémons carregados: ${batchPokemons.length}');
    for (var pokemon in batchPokemons) {
      print(
        '   ${pokemon.formattedId} - ${pokemon.displayName} (${pokemon.primaryType.displayName})',
      );
    }
    print('');

    // ========================================
    // TESTE 6: StateNotifier - Paginação
    // ========================================
    print('📄 Teste 6: StateNotifier com Paginação');
    print('─────────────────────────────────────');

    // Aguarda carregar primeira página (carrega automaticamente)
    await Future.delayed(Duration(seconds: 3));

    var state = container.read(pokemonListNotifierProvider);

    print('✅ Página inicial:');
    print('   Pokémons: ${state.pokemons.length}');
    print('   Página atual: ${state.currentPage}');
    print('   Tem mais? ${state.hasMore}');
    print('   Carregando? ${state.isLoading}');

    if (state.pokemons.isNotEmpty) {
      print('   Primeiros 3:');
      for (var i = 0; i < 3 && i < state.pokemons.length; i++) {
        print(
          '      ${state.pokemons[i].formattedId} - ${state.pokemons[i].displayName}',
        );
      }
    }

    // Carregar mais
    print('\n🔄 Carregando página 2...');
    final notifier = container.read(pokemonListNotifierProvider.notifier);
    await notifier.loadMore();
    await Future.delayed(Duration(seconds: 2));

    state = container.read(pokemonListNotifierProvider);
    print('✅ Após loadMore:');
    print('   Pokémons: ${state.pokemons.length}');
    print('   Página atual: ${state.currentPage}');

    // Refresh
    print('\n🔄 Fazendo refresh...');
    await notifier.refresh();
    await Future.delayed(Duration(seconds: 2));

    state = container.read(pokemonListNotifierProvider);
    print('✅ Após refresh:');
    print('   Pokémons: ${state.pokemons.length}');
    print('   Página atual: ${state.currentPage}');

    print('');

    // ========================================
    // RESUMO FINAL
    // ========================================
    print('═════════════════════════════════════');
    print('✅ TODOS OS TESTES PASSARAM!');
    print('═════════════════════════════════════');
    print('');
    print('Providers testados:');
    print('  ✅ dioProvider');
    print('  ✅ pokemonRemoteDataSourceProvider');
    print('  ✅ pokemonRepositoryProvider');
    print('  ✅ pokemonListProvider');
    print('  ✅ pokemonDetailProvider');
    print('  ✅ pokemonSearchProvider');
    print('  ✅ pokemonBatchProvider');
    print('  ✅ pokemonListNotifierProvider');
    print('');
    print('🚀 Pronto para criar a UI!');
  } catch (e, stack) {
    print('❌ ERRO NO TESTE:');
    print(e);
    print('\n📍 Stack trace:');
    print(stack);
  } finally {
    container.dispose();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
