import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/network/dio_config.dart';
import '../../data/datasources/pokemon_remote_datasource.dart';
import '../../data/repositories/pokemon_repository.dart';

/// Provaider do Dio (HTTP client)
///
/// Fornece uma instância configurada do Dio para toda a aplicação.
/// É um Provider simples porque Dio não muda durante a execução.
final dioProvider = Provider<Dio>((ref) {
  return DioConfig.createDio();
});

/// Provider de PokemonRemoteDataSource
///
/// Fornece o DataSource que faz as requisições HTTP
/// Depende do dioProvider para funcionar.
final pokemonRemoteDataSourceProvider = Provider<PokemonRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return PokemonRemoteDataSource(dio: dio);
});

/// Provider do PokemonRepository
///
/// Fornece o Repository que orquestra o DataSource.
/// Esta é a camada que a UI vai usar!
final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final dataSource = ref.watch(pokemonRemoteDataSourceProvider);
  return PokemonRepository(remoteDatasource: dataSource);
});
