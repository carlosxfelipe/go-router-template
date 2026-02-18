import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final VoidCallback? onIconPressed;

  const SearchAppBar({
    super.key,
    this.onChanged,
    this.icon,
    this.onIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      // automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            flex: icon != null ? 7 : 1,
            child: SearchAppBarContent(onChanged: onChanged),
          ),
          if (icon != null)
            Expanded(
              flex: 1,
              child: Center(
                child: IconButton(
                  icon: Icon(icon, color: theme.colorScheme.onSurface),
                  onPressed: onIconPressed ?? () {},
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchAppBarContent extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const SearchAppBarContent({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar...',
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withAlpha(128),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: theme.colorScheme.onSurface.withAlpha(153),
          ),
          filled: false,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: theme.colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: theme.colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
        style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14),
      ),
    );
  }
}
