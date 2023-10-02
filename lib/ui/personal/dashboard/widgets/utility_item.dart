import 'package:bestfriend/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../../data_models/user.data.dart';
import '../../../../services/authentication.service.dart';

class UtilityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final String? labelText;

  const UtilityItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.labelText,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (labelText != null)
                Align(
                  alignment: Alignment.topCenter,
                  child: _AnimatedTotalLeaveCount(),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 25,
                    color: iconColor,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedTotalLeaveCount extends StatefulWidget {
  @override
  _AnimatedTotalLeaveCountState createState() =>
      _AnimatedTotalLeaveCountState();
}

class _AnimatedTotalLeaveCountState extends State<_AnimatedTotalLeaveCount>
    with SingleTickerProviderStateMixin {
  UserData get user => locator<AuthenticationService>().user!;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
            begin: 0, end: double.parse(user.staff.remainingLeave.toString()))
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String formattedValue = _animation.value.toStringAsFixed(1);
        return Text(
          user.staff.remainingLeave == '' ? '0 days' : '$formattedValue days',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.lightGreen),
        );
      },
    );
  }
}
