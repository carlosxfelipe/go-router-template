import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.description,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (label == null && description == null) {
      // Switch simples sem label
      return Switch(
        value: value,
        onChanged: onChanged,
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return theme.colorScheme.onPrimary;
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return theme.colorScheme.primary;
          }
          return null;
        }),
      );
    }

    // Switch com label e/ou description
    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Switch(
              value: value,
              onChanged: onChanged,
              thumbColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return theme.colorScheme.onPrimary;
                }
                return null;
              }),
              trackColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return theme.colorScheme.primary;
                }
                return null;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
