import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({super.key, this.height, this.thickness = 1, this.margin});

  final double? height;
  final double thickness;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: margin,
      child: Divider(
        height: height,
        thickness: thickness,
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
      ),
    );
  }
}
