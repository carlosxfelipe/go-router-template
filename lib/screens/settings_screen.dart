import 'package:flutter/material.dart';
import 'package:go_router_template/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      currentIndex: 1, // Índice correspondente à página de "Configurações"
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Configurações'),
        body: ProfileBody(),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 16),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text('Tela de Configurações', style: theme.textTheme.bodyLarge),
      ),
    );
  }
}
