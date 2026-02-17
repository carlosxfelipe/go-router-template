import 'package:flutter/material.dart';

class CustomAccordionItem {
  const CustomAccordionItem({
    required this.title,
    required this.content,
    this.leading,
  });

  final String title;
  final Widget content;
  final Widget? leading;
}

class CustomAccordion extends StatefulWidget {
  const CustomAccordion({
    super.key,
    required this.items,
    this.allowMultipleExpanded = false,
    this.initiallyExpandedIndex,
    this.spacing = 8,
  });

  final List<CustomAccordionItem> items;
  final bool allowMultipleExpanded;
  final int? initiallyExpandedIndex;
  final double spacing;

  @override
  State<CustomAccordion> createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion> {
  late Set<int> _expandedIndexes;

  @override
  void initState() {
    super.initState();

    if (widget.initiallyExpandedIndex != null &&
        widget.initiallyExpandedIndex! >= 0 &&
        widget.initiallyExpandedIndex! < widget.items.length) {
      _expandedIndexes = {widget.initiallyExpandedIndex!};
    } else {
      _expandedIndexes = <int>{};
    }
  }

  void _toggle(int index) {
    setState(() {
      final isExpanded = _expandedIndexes.contains(index);

      if (isExpanded) {
        _expandedIndexes.remove(index);
        return;
      }

      if (!widget.allowMultipleExpanded) {
        _expandedIndexes = {index};
      } else {
        _expandedIndexes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.items.length, (index) {
        final item = widget.items[index];
        final isExpanded = _expandedIndexes.contains(index);

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < widget.items.length - 1 ? widget.spacing : 0,
          ),
          child: _AccordionTile(
            item: item,
            expanded: isExpanded,
            onTap: () => _toggle(index),
          ),
        );
      }),
    );
  }
}

class _AccordionTile extends StatelessWidget {
  const _AccordionTile({
    required this.item,
    required this.expanded,
    required this.onTap,
  });

  final CustomAccordionItem item;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  if (item.leading != null) ...[
                    item.leading!,
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      item.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: theme.colorScheme.onSurface.withAlpha(180),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: item.content,
              ),
            ),
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}
