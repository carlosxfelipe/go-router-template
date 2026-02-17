import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInput extends StatefulWidget {
  const OTPInput({
    super.key,
    this.length = 6,
    this.label,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.onCompleted,
  }) : assert(length > 0, 'length must be greater than 0');

  final int length;
  final String? label;
  final String? helperText;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  bool get _hasError => widget.errorText != null;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String get _currentValue {
    return _controllers.map((controller) => controller.text).join();
  }

  void _emitChanges() {
    final otp = _currentValue;
    widget.onChanged?.call(otp);
    final isCompleted = _controllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    if (isCompleted) {
      widget.onCompleted?.call(otp);
    }
  }

  void _handleChanged(int index, String value) {
    if (value.length > 1) {
      _fillFromPaste(value);
      return;
    }

    _controllers[index].text = value;
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    _emitChanges();
  }

  void _fillFromPaste(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.isEmpty) {
      return;
    }

    final chars = digitsOnly.split('');
    for (var i = 0; i < widget.length; i++) {
      _controllers[i].text = i < chars.length ? chars[i] : '';
    }

    final lastFilledIndex = (chars.length - 1).clamp(0, widget.length - 1);
    _focusNodes[lastFilledIndex].requestFocus();
    _emitChanges();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Row(
          children: List.generate(widget.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index < widget.length - 1 ? 8 : 0,
                ),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  enabled: widget.enabled,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  textInputAction: index == widget.length - 1
                      ? TextInputAction.done
                      : TextInputAction.next,
                  maxLength: 1,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  onChanged: (value) => _handleChanged(index, value),
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: _hasError
                            ? Colors.red
                            : (isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: _hasError
                            ? Colors.red
                            : (isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        color: _hasError
                            ? Colors.red
                            : theme.colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        if (widget.helperText != null || widget.errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorText ?? widget.helperText!,
            style: TextStyle(
              fontSize: 12,
              color: _hasError
                  ? Colors.red
                  : theme.colorScheme.onSurface.withAlpha(153),
            ),
          ),
        ],
      ],
    );
  }
}
