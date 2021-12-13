import 'package:flutter/material.dart';

class FYCard extends StatelessWidget {
  final Widget child;
  final double? elevation;

  const FYCard({Key? key, required this.child, this.elevation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: elevation ?? 6,
      shadowColor: Colors.black54,
      child: child,
    );
  }
}
