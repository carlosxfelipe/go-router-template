import 'package:flutter/material.dart';

enum LoadingSpinnerSize { small, medium, large }

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({
    super.key,
    this.size = LoadingSpinnerSize.medium,
    this.strokeWidth,
    this.color,
    this.label,
  });

  final LoadingSpinnerSize size;
  final double? strokeWidth;
  final Color? color;
  final String? label;

  double get _dimension {
    switch (size) {
      case LoadingSpinnerSize.small:
        return 16;
      case LoadingSpinnerSize.medium:
        return 24;
      case LoadingSpinnerSize.large:
        return 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spinner = SizedBox(
      width: _dimension,
      height: _dimension,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? theme.colorScheme.primary,
        ),
      ),
    );

    if (label == null) {
      return spinner;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        spinner,
        const SizedBox(width: 10),
        Text(label!, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
