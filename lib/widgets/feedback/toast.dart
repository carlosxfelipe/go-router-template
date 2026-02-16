import 'package:flutter/material.dart';

enum ToastVariant { success, error, warning, info }

class Toast {
  static void show(
    BuildContext context, {
    required String message,
    ToastVariant variant = ToastVariant.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;
    IconData icon;

    switch (variant) {
      case ToastVariant.success:
        backgroundColor = isDarkMode
            ? const Color(0xFF166534)
            : const Color(0xFFDCFCE7);
        textColor = isDarkMode
            ? const Color(0xFF86EFAC)
            : const Color(0xFF166534);
        icon = Icons.check_circle;
        break;
      case ToastVariant.error:
        backgroundColor = isDarkMode
            ? const Color(0xFF991B1B)
            : const Color(0xFFFEE2E2);
        textColor = isDarkMode
            ? const Color(0xFFFCA5A5)
            : const Color(0xFF991B1B);
        icon = Icons.error;
        break;
      case ToastVariant.warning:
        backgroundColor = isDarkMode
            ? const Color(0xFF854D0E)
            : const Color(0xFFFEF3C7);
        textColor = isDarkMode
            ? const Color(0xFFFDE047)
            : const Color(0xFF854D0E);
        icon = Icons.warning;
        break;
      case ToastVariant.info:
        backgroundColor = isDarkMode
            ? const Color(0xFF1E3A8A)
            : const Color(0xFFDBEAFE);
        textColor = isDarkMode
            ? const Color(0xFF93C5FD)
            : const Color(0xFF1E3A8A);
        icon = Icons.info;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        duration: duration,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
