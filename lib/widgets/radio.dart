import 'package:flutter/material.dart';

// Custom Radio Group usando InheritedWidget para gerenciar estado
class CustomRadioGroup<T> extends StatelessWidget {
  const CustomRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  final T? value;
  final ValueChanged<T?> onChanged;
  final List<CustomRadioItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return _RadioGroupProvider<T>(
      value: value,
      onChanged: onChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map(
              (item) => CustomRadio<T>(
                value: item.value,
                label: item.label,
                description: item.description,
              ),
            )
            .toList(),
      ),
    );
  }
}

// InheritedWidget para prover o estado do grupo
class _RadioGroupProvider<T> extends InheritedWidget {
  const _RadioGroupProvider({
    required this.value,
    required this.onChanged,
    required super.child,
  });

  final T? value;
  final ValueChanged<T?> onChanged;

  static _RadioGroupProvider<T>? of<T>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RadioGroupProvider<T>>();
  }

  @override
  bool updateShouldNotify(_RadioGroupProvider<T> oldWidget) {
    return value != oldWidget.value;
  }
}

// Custom Radio que usa o provider
class CustomRadio<T> extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.value,
    this.label,
    this.description,
  });

  final T value;
  final String? label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = _RadioGroupProvider.of<T>(context);

    final isSelected = provider?.value == value;
    final onChanged = provider?.onChanged;

    final radioButton = Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface.withAlpha(153),
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.primary,
                ),
              ),
            )
          : null,
    );

    if (label == null && description == null) {
      // Radio simples sem label
      return GestureDetector(
        onTap: onChanged != null ? () => onChanged(value) : null,
        child: radioButton,
      );
    }

    // Radio com label e/ou description
    return InkWell(
      onTap: onChanged != null ? () => onChanged(value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            radioButton,
            const SizedBox(width: 12),
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
          ],
        ),
      ),
    );
  }
}

class CustomRadioItem<T> {
  const CustomRadioItem({
    required this.value,
    required this.label,
    this.description,
  });

  final T value;
  final String label;
  final String? description;
}
