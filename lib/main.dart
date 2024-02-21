import 'package:corbado_auth/corbado_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poc/provider.dart';
import 'package:poc/router.dart';
import 'package:poc/src/loading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LoadingComponent());
  final relyingPartyServer = CustomCorbadoAuth();
  const corbadoProjectId = String.fromEnvironment('CORBADO_PROJECT_ID');
  await relyingPartyServer.init(corbadoProjectId);

  runApp(ProviderScope(overrides: [
    relyingPartyServerProvider.overrideWithValue(relyingPartyServer)
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF005DAA)),
      ),
    );
  }
}
