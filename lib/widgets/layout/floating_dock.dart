import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';

class FloatingDock extends StatefulWidget {
  final int currentIndex;
  final Widget child;
  final bool isGlass;

  const FloatingDock({
    super.key,
    required this.currentIndex,
    required this.child,
    this.isGlass = false,
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: widget.isGlass
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: _buildDock(isDarkMode, theme),
                      )
                    : _buildDock(isDarkMode, theme),
              ),
            ),
    );
  }

  Widget _buildDock(bool isDarkMode, ThemeData theme) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ), // Padding para os itens "dentro" do dock
      decoration: BoxDecoration(
        color: widget.isGlass
            ? (isDarkMode
                  ? Colors.black.withAlpha(40)
                  : Colors.white.withAlpha(150))
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(isDarkMode ? 40 : 15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
          width: 1.0,
        ),
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
          borderRadius: BorderRadius.circular(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isDarkMode
                        ? Colors.white.withAlpha(30)
                        : theme.colorScheme.secondary)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: isSelected
                    ? (isDarkMode ? Colors.white : theme.colorScheme.primary)
                    : theme.colorScheme.onSurface.withAlpha(100),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
