import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

class FloatingDock extends StatefulWidget {
  final int currentIndex;
  final Widget child;

  const FloatingDock({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  @override
  State<FloatingDock> createState() => _FloatingDockState();
}

class _FloatingDockState extends State<FloatingDock> {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: SafeArea(bottom: false, child: widget.child),
      bottomNavigationBar:
          MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb
          ? null
          : Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 32),
              child: _buildDock(isDarkMode, theme),
            ),
    );
  }

  Widget _buildDock(bool isDarkMode, ThemeData theme) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDarkMode ? 40 : 15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            index: 0,
            icon: widget.currentIndex == 0 ? Icons.home : Icons.home_outlined,
            isDarkMode: isDarkMode,
          ),
          _buildNavItem(
            index: 1,
            icon: widget.currentIndex == 1
                ? Icons.settings
                : Icons.settings_outlined,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required bool isDarkMode,
  }) {
    final isSelected = widget.currentIndex == index;
    final theme = Theme.of(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: InkWell(
          onTap: () => _onItemTapped(index),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDarkMode
                        ? theme.colorScheme.onSurface.withAlpha(30)
                        : theme.colorScheme.secondary)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withAlpha(100),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
