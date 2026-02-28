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

        // Aplicar limites globais de largura quebra a barra de rolagem no Flutter Web.
        // Para contornar, usamos `ResponsiveMaxWidth` dentro de cada tela para limitar o conteúdo apenas no navegador.
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: child!,
        );
      },
    );
  }
}
