import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.label,
    this.onDeleted,
    this.selected = false,
    this.onSelected,
    this.avatar,
  });

  final String label;
  final VoidCallback? onDeleted;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    // Cores inspiradas no shadcn/ui
    final backgroundColor = selected
        ? (isDarkMode ? Colors.grey.shade800 : const Color(0xFFF4F4F5))
        : (isDarkMode ? Colors.grey.shade900 : Colors.white);

    final borderColor = selected
        ? (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300)
        : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200);

    final foregroundColor = selected
        ? theme.colorScheme.onSurface
        : theme.colorScheme.onSurface.withAlpha(179);

    if (onDeleted != null) {
      // Chip removível
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (avatar != null) ...[avatar!, const SizedBox(width: 6)],
                  Text(
                    label,
                    style: TextStyle(
                      color: foregroundColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: onDeleted,
                    child: Icon(
                      Icons.close,
                      size: 14,
                      color: foregroundColor.withAlpha(153),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else if (onSelected != null) {
      // Chip selecionável
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () => onSelected!(!selected),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (avatar != null) ...[avatar!, const SizedBox(width: 6)],
                  Text(
                    label,
                    style: TextStyle(
                      color: foregroundColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      // Chip simples
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (avatar != null) ...[avatar!, const SizedBox(width: 6)],
            Text(
              label,
              style: TextStyle(
                color: foregroundColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
  }
}
