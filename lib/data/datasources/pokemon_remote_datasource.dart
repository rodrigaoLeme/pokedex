import 'package:dio/dio.dart';
import '../models/models.dart';

/// DataSource para requisições HTTP da PokéAPI
///
/// Responsável por fazer as chamadas à API e converter
/// os JSONs em models.
class PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSource({required this.dio});

  /// Busca lista pagina de Pokémons
  ///
  /// [limit] - Quantidade de pokémons por página (padrão: 20)
  /// [offset] - Início da página (padrão: 0)
  ///
  /// Retorna [PokemonListResponse] com a lista básica
  Future<PokemonListResponse> getPokemonList({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await dio.get(
        '/pokemon',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return PokemonListResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Busca detalhes completos de um Pokémon por ID
  ///
  /// [id] - ID do pokémon (ex: 25 para Pikachu)
  ///
  /// Retorna [Pokemon] com todos os detalhes
  Future<Pokemon> getPokemonDetail(int id) async {
    try {
      final response = await dio.get('/pokemon/$id');
      return Pokemon.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Busca detalhes completos de um Pokémon por nome
  ///
  /// [name] - Nome do pokémon (ex: "pikachu")
  ///
  /// Retorna [Pokemon] com todos os detalhes
  Future<Pokemon> getPokemonDetailByName(String name) async {
    try {
      final response = await dio.get('/pokemon/${name.toLowerCase()}');
      return Pokemon.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Busca múltiplos pokémons de uma vez (batch)
  ///
  /// [ids] - Lista de IDs para buscar
  ///
  /// Retorna lista de [Pokemon]
  Future<List<Pokemon>> getPokemonBatch(List<int> ids) async {
    try {
      final futures = ids.map((id) => getPokemonDetail(id));
      return await Future.wait(futures);
    } catch (e) {
      rethrow;
    }
  }

  /// Trata erros do Dio e transforma em exceções mais amigáveis
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Tempo de conexão esgotado. Verifique sua internet');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 404) {
          return Exception('Pokémon não encontrado');
        } else if (statusCode == 500) {
          return Exception('Erro no servidor. Tente novamente mais tarde');
        }
        return Exception('Erro ao buscar dados: $statusCode');

      case DioExceptionType.cancel:
        return Exception('Requisição cancelada.');

      case DioExceptionType.connectionError:
        return Exception('Sem conexão com a internet');

      default:
        return Exception('Erro desconhecido: ${error.message}');
    }
  }
}
