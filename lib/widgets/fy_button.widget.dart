import 'package:flutter/material.dart';

class FYPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const FYPrimaryButton({Key? key, required this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class FYSecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const FYSecondaryButton({Key? key, required this.label, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
