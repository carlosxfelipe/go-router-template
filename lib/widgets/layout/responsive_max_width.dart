import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ResponsiveMaxWidth extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveMaxWidth({
    super.key,
    required this.child,
    this.maxWidth = 1024,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
