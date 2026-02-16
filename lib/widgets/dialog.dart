import 'package:flutter/material.dart';
import 'package:go_router_template/widgets/button.dart';

enum DialogType { alert, confirm, custom }

class CustomDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? description,
    DialogType type = DialogType.alert,
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget? content,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => _DialogContent(
        title: title,
        description: description,
        type: type,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        content: content,
      ),
    );
  }
}

class _DialogContent extends StatelessWidget {
  const _DialogContent({
    required this.title,
    this.description,
    required this.type,
    required this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.content,
  });

  final String title;
  final String? description;
  final DialogType type;
  final String confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            // Description or custom content
            if (description != null || content != null) ...[
              const SizedBox(height: 12),
              if (content != null)
                content!
              else
                Text(
                  description!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(179),
                  ),
                ),
            ],

            const SizedBox(height: 24),

            // Buttons
            if (type == DialogType.confirm) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Button(
                      label: cancelText ?? 'Cancelar',
                      outlined: true,
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        onCancel?.call();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Button(
                      label: confirmText,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        onConfirm?.call();
                      },
                    ),
                  ),
                ],
              ),
            ] else ...[
              Button(
                label: confirmText,
                onPressed: () {
                  Navigator.of(context).pop(true);
                  onConfirm?.call();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
