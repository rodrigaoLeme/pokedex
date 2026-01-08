import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'logic/providers/router_provider.dart';

void main() {
  runApp(
    // ProviderScope é necessário para Riverpod funcionar
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assiste o router provider
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      // Configuração do Router
      routerConfig: router,

      // Título do app
      title: 'Pokédex',

      // Tema (Design System criado)
      theme: AppTheme.lightTheme,

      // Remove banner de debug
      debugShowCheckedModeBanner: false,
    );
  }
}
