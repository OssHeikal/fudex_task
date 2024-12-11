import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

import '../resources/resources.dart';
import '../utils/validators.dart';
import 'custom_input_field.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.prefix,
    this.controller,
    this.hint,
    this.title,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.height,
    this.focusNode,
    this.onChanged,
    this.maxLines = 1,
    this.suffixIcon,
    this.inputFormatters,
    this.inputType = InputType.text,
    this.isRequired = true,
  });
  final String? prefixIcon;
  final Widget? prefix;
  final TextEditingController? controller;
  final String? hint;
  final String? title;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final double? height;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final int maxLines;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final InputType inputType;
  final bool isRequired;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _hasFocus = ValueNotifier<bool>(false);

  @override
  void initState() {
    _focusNode.addListener(() {
      _hasFocus.value = _focusNode.hasFocus;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _hasFocus,
      builder: (context, hasFocus, child) {
        final bool enabled = hasFocus || widget.controller?.text.isNotEmpty == true;
        return FormField(
          validator: _getValidator(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<String> formState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  curve: Curves.easeInOutCubic,
                  duration: 200.milliseconds,
                  padding: 1.edgeInsetsAll,
                  decoration: BoxDecoration(borderRadius: AppSize.inputBorderRadius.borderRadius),
                  child: CustomInputField.outlined(
                    isRequired: widget.isRequired,
                    inputType: widget.inputType,
                    readOnly: widget.readOnly,
                    height: widget.height,
                    hint: widget.hint,
                    label: widget.title,
                    focusNode: widget.focusNode ?? _focusNode,
                    isPassword: widget.isPassword,
                    background: context.scaffoldBackgroundColor,
                    borderColor: _borderColor(formState, enabled, context),
                    controller: widget.controller,
                    inputFormatters: widget.inputFormatters,
                    keyboardType: widget.keyboardType,
                    maxLines: widget.maxLines,
                    suffixIcon: widget.suffixIcon,
                    labelStyle: context.bodyLarge.s12,
                    prefixIcon: widget.prefix ??
                        widget.prefixIcon?.toSvg(
                          colorFilter:
                              enabled ? context.iconColor.colorFilter : context.hintTextStyle.color!.colorFilter,
                          width: AppSize.iconNormal,
                          height: AppSize.iconNormal,
                        ),
                    onChanged: (value) {
                      widget.onChanged?.call(value);
                      formState.didChange(value);
                    },
                    onEditingComplete: () {
                      _focusNode.unfocus();
                      widget.focusNode?.unfocus();
                    },
                    onTap: () {
                      _focusNode.requestFocus();
                      widget.onTap?.call();
                    },
                  ),
                ),
                if (formState.hasError)
                  Text(formState.errorText!, style: context.errorStyle).paddingTop(4.sp).paddingStart(4),
              ],
            );
          },
        );
      },
    );
  }

  Color _borderColor(FormFieldState<String> formState, bool enabled, BuildContext context) {
    if (formState.hasError) {
      return context.errorColor;
    } else if (enabled) {
      return context.primaryBorder;
    } else {
      return context.inputFieldBorderColor;
    }
  }

  String? Function(String?)? _getValidator() {
    switch (widget.inputType) {
      default:
        if (widget.validator != null) {
          return (_) => widget.validator!(widget.controller!.text);
        } else if (widget.isRequired) {
          return (_) => Validator.validateEmpty(widget.controller!.text);
        }
    }
    return null;
  }
}
