import 'package:flutter/material.dart';

class UtilityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final String pending;
  final String approved;
  final String declined;

  const UtilityItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.pending,
    required this.approved,
    required this.declined,
    this.onPressed,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        pending,
                        style: const TextStyle(color: Colors.orange),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        approved,
                        style: const TextStyle(color: Colors.green),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        declined,
                        style: const TextStyle(color: Colors.red),
                      )
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 32,
                    color: iconColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(title)
                ],
              )
            ],

            // mainAxisAlignment: MainAxisAlignment.center,
            // children: <Widget>[
            //   Icon(
            //     icon,
            //     size: 32,
            //     color: iconColor,
            //   ),
            //   const SizedBox(
            //     height: 10,
            //   ),
            //   Text(title)
            // ],
          ),
        ),
      ),
    );
  }
}
