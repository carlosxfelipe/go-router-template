import 'package:flutter/material.dart';

enum SkeletonShape { rectangle, circle }

class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    this.width,
    this.height = 16,
    this.shape = SkeletonShape.rectangle,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final SkeletonShape shape;
  final BorderRadius? borderRadius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final baseColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlightColor = isDarkMode
        ? Colors.grey.shade700
        : Colors.grey.shade100;

    final effectiveBorderRadius = widget.shape == SkeletonShape.circle
        ? BorderRadius.circular(widget.height / 2)
        : (widget.borderRadius ?? BorderRadius.circular(4));

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: effectiveBorderRadius,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget auxiliar para skeleton de texto
class SkeletonText extends StatelessWidget {
  const SkeletonText({
    super.key,
    this.lines = 1,
    this.lineHeight = 16,
    this.spacing = 8,
  });

  final int lines;
  final double lineHeight;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        lines,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index < lines - 1 ? spacing : 0),
          child: Skeleton(
            height: lineHeight,
            width: index == lines - 1 ? null : double.infinity,
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para skeleton de card
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Skeleton(width: 48, height: 48, shape: SkeletonShape.circle),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(height: 16, width: 120),
                    SizedBox(height: 8),
                    Skeleton(height: 14, width: 80),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SkeletonText(lines: 3),
        ],
      ),
    );
  }
}
