import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router_template/theme/theme.dart';
import 'package:go_router_template/routes/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        AppTheme.setSystemUIOverlayStyle(brightness);
        // return child!;

        // Limita a largura máxima da aplicação e centraliza o conteúdo.
        // Isso é especialmente útil para web e tablets, evitando que
        // os componentes fiquem muito esticados em telas grandes.
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1024),
              child: child!,
            ),
          ),
        );
      },
    );
  }
}
