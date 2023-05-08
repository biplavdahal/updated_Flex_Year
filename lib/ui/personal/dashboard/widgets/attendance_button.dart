import 'package:flutter/material.dart';

class AttendanceButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onPressed;
  final bool isTablet;
  final String titles;

  const AttendanceButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.title,
    this.onPressed,
    required this.titles,
    this.isTablet = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Opacity(
        opacity: onPressed == null ? 0.3 : 1,
        child: Material(
          color: color.withOpacity(0.95),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onPressed,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: color,
                  width: 0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            icon,
                            color: Colors.white,
                            size: isTablet ? 64 : null,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 32 : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
