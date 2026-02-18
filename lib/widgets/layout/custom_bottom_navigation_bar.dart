import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Widget child;
  final bool hideOnScroll;
  final bool showLabels;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.child,
    this.hideOnScroll = false,
    this.showLabels = true,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _hideController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    _hideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _hideController.forward();
  }

  @override
  void dispose() {
    _hideController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == widget.currentIndex) return;

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/settings');
        break;
    }
  }

  bool _handleScrollNotification(UserScrollNotification notification) {
    if (!widget.hideOnScroll) return false;

    if (notification.direction == ScrollDirection.reverse && _isVisible) {
      setState(() {
        _isVisible = false;
        _hideController.reverse();
      });
    } else if (notification.direction == ScrollDirection.forward &&
        !_isVisible) {
      setState(() {
        _isVisible = true;
        _hideController.forward();
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bottomBar =
        MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb
        ? null
        : NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: theme.colorScheme.secondary,
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                final isSelected = states.contains(WidgetState.selected);
                return TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withAlpha(153),
                );
              }),
              iconTheme: WidgetStateProperty.resolveWith((states) {
                final isSelected = states.contains(WidgetState.selected);
                return IconThemeData(
                  size: 24,
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withAlpha(153),
                );
              }),
            ),
            child: NavigationBar(
              selectedIndex: widget.currentIndex,
              onDestinationSelected: _onItemTapped,
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              height: widget.showLabels ? 80 : 64,
              labelBehavior: widget.showLabels
                  ? NavigationDestinationLabelBehavior.alwaysShow
                  : NavigationDestinationLabelBehavior.alwaysHide,
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: 'Início',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.settings_outlined),
                  selectedIcon: const Icon(Icons.settings),
                  label: 'Configurações',
                ),
              ],
            ),
          );

    return Scaffold(
      extendBody: true,
      body: NotificationListener<UserScrollNotification>(
        onNotification: _handleScrollNotification,
        child: SafeArea(child: widget.child),
      ),
      bottomNavigationBar: widget.hideOnScroll && bottomBar != null
          ? SizeTransition(
              sizeFactor: _hideController,
              axisAlignment: -1.0,
              child: bottomBar,
            )
          : bottomBar,
    );
  }
}
