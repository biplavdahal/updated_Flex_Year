import 'package:flutter/material.dart';

class FYInputField extends StatefulWidget {
  final int? maxLength;
  final String label;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  const FYInputField({
    Key? key,
    this.controller,
    required this.label,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  State<FYInputField> createState() => _FYInputFieldState();
}

class _FYInputFieldState extends State<FYInputField> {
  bool _visiblePassword = false;
  set visiblePassword(bool value) {
    setState(() {
      _visiblePassword = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.obscureText
            ? IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  _visiblePassword ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  visiblePassword = !_visiblePassword;
                },
              )
            : null,
      ),
      validator: widget.validator,
      style: const TextStyle(fontSize: 14),
      maxLength: widget.maxLength,
      keyboardType: widget.obscureText
          ? TextInputType.visiblePassword
          : widget.keyboardType,
      obscureText: widget.obscureText == false ? false : _visiblePassword,
    );
  }
}
