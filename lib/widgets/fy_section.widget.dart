import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class FYSection extends StatelessWidget {
  final Widget? child;
  final String? title;

  const FYSection({Key? key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              color: AppColor.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        const SizedBox(height: 10),
        if (child != null) child!,
      ],
    );
  }
}
