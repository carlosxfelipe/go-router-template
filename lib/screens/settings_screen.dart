import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

// class ProfileBody extends StatelessWidget {
//   const ProfileBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: EdgeInsets.only(left: 16, top: 16),
//       child: Align(
//         alignment: Alignment.topLeft,
//         child: Text('Tela de Configurações', style: theme.textTheme.bodyLarge),
//       ),
//     );
//   }
// }

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tela de Configurações',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          CustomCard(
            onTap: () {
              context.push('/components');
            },
            child: Row(
              children: [
                Icon(Icons.widgets, color: theme.colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Componentes',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ver todos os componentes customizados',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withAlpha(153),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: theme.colorScheme.onSurface.withAlpha(153),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
