import 'package:flutter/material.dart';

class CustomTabs extends StatelessWidget {
  const CustomTabs({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
  });

  final List<CustomTab> tabs;
  final List<Widget> children;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
            ),
            child: TabBar(
              isScrollable: false,
              indicatorColor: theme.colorScheme.primary,
              indicatorWeight: 2,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor: theme.colorScheme.onSurface.withAlpha(153),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              tabs: tabs
                  .map(
                    (tab) => Tab(
                      icon: tab.icon != null ? Icon(tab.icon, size: 20) : null,
                      text: tab.label,
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(child: TabBarView(children: children)),
        ],
      ),
    );
  }
}

class CustomTab {
  const CustomTab({required this.label, this.icon});

  final String label;
  final IconData? icon;
}
