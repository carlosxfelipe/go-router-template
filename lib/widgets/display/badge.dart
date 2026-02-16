import 'package:flutter/material.dart';

enum BadgeVariant { default_, secondary, success, warning, error, info }

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.label,
    this.variant = BadgeVariant.default_,
  });

  final String label;
  final BadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;

    switch (variant) {
      case BadgeVariant.default_:
        backgroundColor = isDarkMode
            ? Colors.grey.shade800
            : Colors.grey.shade200;
        textColor = theme.colorScheme.onSurface;
        break;
      case BadgeVariant.secondary:
        backgroundColor = theme.colorScheme.secondary;
        textColor = theme.colorScheme.onSecondary;
        break;
      case BadgeVariant.success:
        backgroundColor = isDarkMode
            ? const Color(0xFF166534)
            : const Color(0xFFDCFCE7);
        textColor = isDarkMode
            ? const Color(0xFF86EFAC)
            : const Color(0xFF166534);
        break;
      case BadgeVariant.warning:
        backgroundColor = isDarkMode
            ? const Color(0xFF854D0E)
            : const Color(0xFFFEF3C7);
        textColor = isDarkMode
            ? const Color(0xFFFDE047)
            : const Color(0xFF854D0E);
        break;
      case BadgeVariant.error:
        backgroundColor = isDarkMode
            ? const Color(0xFF991B1B)
            : const Color(0xFFFEE2E2);
        textColor = isDarkMode
            ? const Color(0xFFFCA5A5)
            : const Color(0xFF991B1B);
        break;
      case BadgeVariant.info:
        backgroundColor = isDarkMode
            ? const Color(0xFF1E3A8A)
            : const Color(0xFFDBEAFE);
        textColor = isDarkMode
            ? const Color(0xFF93C5FD)
            : const Color(0xFF1E3A8A);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
