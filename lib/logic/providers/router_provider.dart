import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/app_router.dart';

/// Provider do GoRouter
///
/// Fornece a instância do router para toda a aplicação.
/// Integrado com Riverpod para gerenciamentos de estado.
final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.createRouter();
});
