import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/font_style.dart';

class CustomFormFieldText extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Icon prefixIcon;
  final bool obscureText;
   final String? Function(String?)? validator;
  final String? initialValue;
  final bool isPassword;
  final FocusNode? focusNode;
  final bool isEnabled;
  final TextInputType keyboardType;
  final bool autovalidateMode;

  const CustomFormFieldText({
    super.key,
    this.validator,
    this.initialValue,
    this.autovalidateMode = false,
    this.isEnabled = true,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.isPassword = false,
    this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
  });

  @override
  State<CustomFormFieldText> createState() => _CustomFormFieldTextState();
}

class _CustomFormFieldTextState extends State<CustomFormFieldText> {
  ValueNotifier<bool>? obscureTextNotifier;
  @override
  void initState() {
    super.initState();
    obscureTextNotifier = ValueNotifier(widget.obscureText);
    if (widget.initialValue != null && widget.controller!.text.isEmpty) {
      widget.controller!.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    obscureTextNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (obscureTextNotifier == null) {
      return const SizedBox.shrink();
    }
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier!,
      builder: (context, obscureText, child) {
        return TextFormField(
          
          enabled: widget.isEnabled,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorStyle.neutral200,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: ColorStyle.neutral200,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: MyTextStyles.regularText.copyWith(
              color: ColorStyle.neutral300,
            ),
            
            prefixIcon: Icon(
              widget.prefixIcon.icon,
              color: ColorStyle.neutral200,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      obscureTextNotifier!.value = !obscureTextNotifier!.value;
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: ColorStyle.neutral200,
                    ),
                  )
                : null,
          ),
          //validator: (value) => value!.isEmpty ? 'Field tidak boleh kosong' : null,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
            
        );
      },
    );
  }
}
