import 'package:flutter/material.dart';

enum ProgressBarSize { small, medium, large }

class CustomProgressBar extends StatelessWidget {
  const CustomProgressBar({
    super.key,
    required this.value,
    this.label,
    this.showPercentage = true,
    this.size = ProgressBarSize.medium,
  });

  final double value; // 0.0 to 1.0
  final String? label;
  final bool showPercentage;
  final ProgressBarSize size;

  double get _height {
    switch (size) {
      case ProgressBarSize.small:
        return 6;
      case ProgressBarSize.medium:
        return 8;
      case ProgressBarSize.large:
        return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (value * 100).clamp(0, 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              if (showPercentage)
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(_height / 2),
          child: LinearProgressIndicator(
            value: value,
            minHeight: _height,
            backgroundColor: theme.colorScheme.outlineVariant.withAlpha(80),
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

// Indeterminate progress bar
class CustomProgressBarIndeterminate extends StatelessWidget {
  const CustomProgressBarIndeterminate({
    super.key,
    this.label,
    this.size = ProgressBarSize.medium,
  });

  final String? label;
  final ProgressBarSize size;

  double get _height {
    switch (size) {
      case ProgressBarSize.small:
        return 6;
      case ProgressBarSize.medium:
        return 8;
      case ProgressBarSize.large:
        return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(_height / 2),
          child: LinearProgressIndicator(
            minHeight: _height,
            backgroundColor: theme.colorScheme.outlineVariant.withAlpha(80),
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
