import 'package:dio/dio.dart';

/// Configuração do Dio (HTTP client)
///
/// Centraliza a configuração do Dio para toda a aplicação
class DioConfig {
  /// Cria instância configurada do Dio
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        // Base URL da PokéAPI
        baseUrl: 'https://pokeapi.co/api/v2',

        // Timeouts
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),

        // Headers padrão
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },

        // Configurações de resposta
        responseType: ResponseType.json,
      ),
    );

    // Adiciona interceptors para logging (em dev)
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: false,
        responseHeader: false,
        error: true,
        logPrint: (obj) {
          // Em produção pode-se usar um logger mais robusto
          // ignore: avoid_print
          print(obj);
        },
      ),
    );

    return dio;
  }
}
