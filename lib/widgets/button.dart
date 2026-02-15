import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum IconPosition { left, right }

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.iconPosition = IconPosition.left,
    this.outlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconPosition iconPosition;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bgColor = backgroundColor ?? colorScheme.primary;
    final fgColor = foregroundColor ?? colorScheme.onPrimary;

    final effectiveFgColor = onPressed == null ? theme.disabledColor : fgColor;

    final ButtonStyle style = outlined
        ? OutlinedButton.styleFrom(
            foregroundColor: effectiveFgColor,
            side: BorderSide(color: effectiveFgColor),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 0,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        : FilledButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: effectiveFgColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          );

    Widget content = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: iconPosition == IconPosition.right
                ? [
                    Text(label),
                    const SizedBox(width: 8),
                    Icon(icon, size: 18, color: effectiveFgColor),
                  ]
                : [
                    Icon(icon, size: 18, color: effectiveFgColor),
                    const SizedBox(width: 8),
                    Text(label),
                  ],
          );

    return SizedBox(
      width: double.infinity,
      child: outlined
          ? OutlinedButton(onPressed: onPressed, style: style, child: content)
          : FilledButton(onPressed: onPressed, style: style, child: content),
    );
  }
}
