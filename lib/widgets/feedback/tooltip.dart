import 'package:flutter/material.dart';

enum TooltipArrowAlignment { left, centerLeft, center, centerRight, right }

class CustomTooltip extends StatelessWidget {
  const CustomTooltip({
    super.key,
    required this.message,
    required this.child,
    this.triggerMode = TooltipTriggerMode.tap,
    this.showArrow = true,
    this.arrowAlignment = TooltipArrowAlignment.center,
    this.preferBelow = false,
    this.waitDuration = const Duration(milliseconds: 300),
    this.showDuration = const Duration(seconds: 2),
    this.verticalOffset = 20,
  });

  final String message;
  final Widget child;
  final TooltipTriggerMode triggerMode;
  final bool showArrow;
  final TooltipArrowAlignment arrowAlignment;
  final bool preferBelow;
  final Duration waitDuration;
  final Duration showDuration;
  final double verticalOffset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Tooltip(
      message: message,
      triggerMode: triggerMode,
      preferBelow: preferBelow,
      waitDuration: waitDuration,
      showDuration: showDuration,
      verticalOffset: verticalOffset,
      padding: EdgeInsets.fromLTRB(
        10,
        showArrow && preferBelow ? 12 : 8,
        10,
        showArrow && !preferBelow ? 12 : 8,
      ),
      decoration: ShapeDecoration(
        color: isDarkMode ? const Color(0xFFF4F4F5) : const Color(0xFF18181B),
        shape: _TooltipBubbleShape(
          borderRadius: 6,
          arrowWidth: showArrow ? 12 : 0,
          arrowHeight: showArrow ? 6 : 0,
          arrowAlignment: arrowAlignment,
          arrowOnTop: preferBelow,
        ),
      ),
      textStyle: TextStyle(
        color: isDarkMode ? const Color(0xFF09090B) : Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      child: child,
    );
  }
}

class _TooltipBubbleShape extends ShapeBorder {
  const _TooltipBubbleShape({
    required this.borderRadius,
    required this.arrowWidth,
    required this.arrowHeight,
    required this.arrowAlignment,
    required this.arrowOnTop,
  });

  final double borderRadius;
  final double arrowWidth;
  final double arrowHeight;
  final TooltipArrowAlignment arrowAlignment;
  final bool arrowOnTop;

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.only(
      top: arrowOnTop ? arrowHeight : 0,
      bottom: arrowOnTop ? 0 : arrowHeight,
    );
  }

  @override
  ShapeBorder scale(double t) {
    return _TooltipBubbleShape(
      borderRadius: borderRadius * t,
      arrowWidth: arrowWidth * t,
      arrowHeight: arrowHeight * t,
      arrowAlignment: arrowAlignment,
      arrowOnTop: arrowOnTop,
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final bodyRect = arrowOnTop
        ? Rect.fromLTWH(
            rect.left,
            rect.top + arrowHeight,
            rect.width,
            rect.height - arrowHeight,
          )
        : Rect.fromLTWH(
            rect.left,
            rect.top,
            rect.width,
            rect.height - arrowHeight,
          );

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(bodyRect, Radius.circular(borderRadius)),
      );

    if (arrowWidth <= 0 || arrowHeight <= 0) {
      return path;
    }

    final edgePadding = borderRadius + (arrowWidth / 2) + 4;
    final minX = bodyRect.left + edgePadding;
    final maxX = bodyRect.right - edgePadding;

    double positionAt(double factor) {
      return (bodyRect.left + (bodyRect.width * factor))
          .clamp(minX, maxX)
          .toDouble();
    }

    final centerX = switch (arrowAlignment) {
      TooltipArrowAlignment.left => minX,
      TooltipArrowAlignment.centerLeft => positionAt(0.35),
      TooltipArrowAlignment.center => bodyRect.center.dx,
      TooltipArrowAlignment.centerRight => positionAt(0.65),
      TooltipArrowAlignment.right => maxX,
    };

    if (arrowOnTop) {
      path
        ..moveTo(centerX - arrowWidth / 2, bodyRect.top)
        ..lineTo(centerX, bodyRect.top - arrowHeight)
        ..lineTo(centerX + arrowWidth / 2, bodyRect.top)
        ..close();
    } else {
      path
        ..moveTo(centerX - arrowWidth / 2, bodyRect.bottom)
        ..lineTo(centerX, bodyRect.bottom + arrowHeight)
        ..lineTo(centerX + arrowWidth / 2, bodyRect.bottom)
        ..close();
    }

    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}
}
