import 'package:flutter/material.dart';

class CustomSelect<T> extends StatelessWidget {
  const CustomSelect({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.placeholder = 'Selecione...',
  });

  final T? value;
  final List<CustomSelectItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  placeholder,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withAlpha(128),
                    fontSize: 16,
                  ),
                ),
              ),
              isExpanded: true,
              icon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.colorScheme.onSurface.withAlpha(153),
                ),
              ),
              borderRadius: BorderRadius.circular(6),
              dropdownColor: theme.scaffoldBackgroundColor,
              onChanged: onChanged,
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSelectItem<T> {
  const CustomSelectItem({required this.value, required this.label});

  final T value;
  final String label;
}
