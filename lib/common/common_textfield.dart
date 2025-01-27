import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixicon,
    this.suffixicon,
    this.changeobsecure,
    this.validator,
    this.obsecure = false,
    this.hintStyle,
    this.centerLabel = false,
    this.maxline = 1,
    this.onTap,
  });

  final TextEditingController controller;

  final String hint;

  final IconData? prefixicon;

  final IconData? suffixicon;

  final bool obsecure;
  final Function? onTap;
  final Function? changeobsecure;
  final TextStyle? hintStyle;
  final bool centerLabel;
  final int maxline;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obsecure,
      maxLines: maxline,
      onTap: () {
        onTap!();
      },
      decoration: InputDecoration(
          alignLabelWithHint: true,
          label: centerLabel
              ? Center(
                  child: Text(
                    hint,
                    style: hintStyle ??
                        TextStyle(
                          fontSize: 13,
                          color: Colors.grey.withOpacity(0.9),
                        ),
                  ),
                )
              : Text(
                  hint,
                  style: hintStyle ??
                      TextStyle(
                        fontSize: 13,
                        color: Colors.grey.withOpacity(0.9),
                      ),
                ),
          prefixIcon: Icon(prefixicon),
          suffixIcon: suffixicon != null
              ? GestureDetector(
                  onTap: () {
                    changeobsecure!();
                  },
                  child: Icon(suffixicon))
              : null,
          border: border,
          enabledBorder: border,
          isDense: true,
          filled: true,
          fillColor: Colors.white),
    );
  }

  OutlineInputBorder border =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26));
}
