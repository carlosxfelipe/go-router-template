import 'package:flutter/material.dart';

enum AvatarSize { small, medium, large }

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.icon,
    this.size = AvatarSize.medium,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String? imageUrl;
  final String? name;
  final IconData? icon;
  final AvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  double get _sizeValue {
    switch (size) {
      case AvatarSize.small:
        return 32;
      case AvatarSize.medium:
        return 48;
      case AvatarSize.large:
        return 64;
    }
  }

  double get _iconSize {
    switch (size) {
      case AvatarSize.small:
        return 16;
      case AvatarSize.medium:
        return 24;
      case AvatarSize.large:
        return 32;
    }
  }

  double get _fontSize {
    switch (size) {
      case AvatarSize.small:
        return 14;
      case AvatarSize.medium:
        return 18;
      case AvatarSize.large:
        return 24;
    }
  }

  String _getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words[0].substring(0, 1).toUpperCase();
    }
    return '${words[0].substring(0, 1)}${words[words.length - 1].substring(0, 1)}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final bgColor =
        backgroundColor ??
        (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200);
    final fgColor = foregroundColor ?? theme.colorScheme.onSurface;

    Widget child;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      // Avatar com imagem
      child = CircleAvatar(
        radius: _sizeValue / 2,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: bgColor,
      );
    } else if (name != null && name!.isNotEmpty) {
      // Avatar com iniciais
      child = CircleAvatar(
        radius: _sizeValue / 2,
        backgroundColor: bgColor,
        child: Text(
          _getInitials(name!),
          style: TextStyle(
            color: fgColor,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      // Avatar com ícone fallback
      child = CircleAvatar(
        radius: _sizeValue / 2,
        backgroundColor: bgColor,
        child: Icon(icon ?? Icons.person, color: fgColor, size: _iconSize),
      );
    }

    return SizedBox(width: _sizeValue, height: _sizeValue, child: child);
  }
}
