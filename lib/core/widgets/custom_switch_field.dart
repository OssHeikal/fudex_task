import 'package:flutter/material.dart';
import 'package:fudex/core/extensions/all_extensions.dart';

class CustomSwitchField extends StatefulWidget {
  const CustomSwitchField({super.key, this.title, required this.value, this.onChanged});

  final String? title;
  final bool value;
  final void Function(bool)? onChanged;

  @override
  State<CustomSwitchField> createState() => _CustomSwitchFieldState();
}

class _CustomSwitchFieldState extends State<CustomSwitchField> {
  late final ValueNotifier<bool> _value;
  @override
  void initState() {
    _value = ValueNotifier<bool>(widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title ?? '', style: context.bodyMedium.s12),
        ValueListenableBuilder<bool>(
          valueListenable: _value,
          builder: (context, value, __) {
            return FittedBox(
              fit: BoxFit.fill,
              child: Switch.adaptive(
                value: value,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: context.successColor,
                onChanged: (value) {
                  _value.value = value;
                  widget.onChanged?.call(value);
                },
              ),
            ).withHeight(24);
          },
        ),
      ],
    );
  }
}
