import 'package:flutter/material.dart';
import 'package:go_router_template/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      currentIndex: 0, // Índice correspondente à página de "Início"
      child: Scaffold(
        appBar: SearchAppBar(
          icon: Icons.notifications_outlined,
          onIconPressed: () {
            // Ação de notificações
          },
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tela de Início', style: theme.textTheme.bodyLarge),
          SizedBox(height: 16),
          Button(label: 'Botão', onPressed: () {}, icon: Icons.check),
        ],
      ),
    );
  }
}
