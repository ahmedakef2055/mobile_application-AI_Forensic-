import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? errorText;
  final bool showErrorText;
  final TextInputAction textInputAction;
  final bool enabled;
  final double borderRadius;

  const AppTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.onTap,
    this.errorText,
    this.showErrorText = true,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    this.borderRadius = 12,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _validate() {
    if (widget.validator != null && widget.controller != null) {
      setState(() {
        _errorText = widget.validator!(widget.controller!.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = c(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyles.body.copyWith(
              fontWeight: FontWeight.w600,
              color: p.text,
            ),
          ),
          SizedBox(height: AppSpacing.s8),
        ],
        Container(
          decoration: BoxDecoration(
            color: p.isDark ? null : p.background,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _errorText != null && _errorText!.isNotEmpty
                  ? const Color(0xFFFF3B30)
                  : _isFocused
                      ? AppColors.primary
                      : p.border,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            minLines: widget.minLines,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            enabled: widget.enabled,
            textInputAction: widget.textInputAction,
            onChanged: (value) {
              _validate();
              widget.onChanged?.call(value);
            },
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.body.copyWith(
                color: p.mutedText,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s12,
              ),
              filled: true,
              fillColor: _isFocused
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : Colors.transparent,
            ),
            style: AppTextStyles.body.copyWith(
              color: p.text,
            ),
          ),
        ),
        if (_errorText != null && _errorText!.isNotEmpty && widget.showErrorText)
          Padding(
            padding: EdgeInsets.only(top: AppSpacing.s8),
            child: Text(
              _errorText!,
              style: AppTextStyles.caption.copyWith(
                color: Color(0xFFFF3B30),
              ),
            ),
          ),
      ],
    );
  }
}
