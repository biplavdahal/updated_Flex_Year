// import 'dart:async';
// import 'package:flutter/material.dart';

// class ProgressItem extends StatefulWidget {
//   const ProgressItem({Key? key}) : super(key: key);

//   @override
//   State<ProgressItem> createState() => _ProgressItemState();
// }

// class _ProgressItemState extends State<ProgressItem> {
//   bool checkedIn = false;

//   late DateTime checkInTime;

//   String remainingTime = '';
//   double _progress = 0.0;

//   void checkIn() {
//     checkedIn = true;
//     checkInTime = DateTime.now();

//     startProgressIndicator();
//   }

//   void startProgressIndicator() {
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       if (!checkedIn) {
//         timer.cancel();
//         return;
//       }

//       int elapsedSeconds = DateTime.now().difference(checkInTime).inSeconds;
//       double progress = elapsedSeconds / (8.5 * 60 * 60);

//       setState(() {
//         _progress = progress;
//         remainingTime =
//             getFormattedTime((8.5 * 60 * 60).round() - elapsedSeconds);
//       });
//     });
//   }

//   String getFormattedTime(int remainingSeconds) {
//     int hours = remainingSeconds ~/ 3600;
//     int minutes = (remainingSeconds % 3600) ~/ 60;
//     int seconds = remainingSeconds % 60;

//     return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (checkedIn) {
//       return Column(
//         children: [
//           LiquidLinearProgressIndicator(
//             value: _progress,
//             valueColor:
//                 AlwaysStoppedAnimation(getColorForPercentage(_progress)),
//             backgroundColor: const Color(0xFFF1F1F1),
//             borderColor: const Color(0xFFF1F1F1),
//             borderWidth: 0.0,
//             borderRadius: 5.0,
//             direction: Axis.horizontal,
//             center: Text(remainingTime),
//           ),
//           Text('Remaining time: $remainingTime')
//         ],
//       );
//     } else {
//       return const Text('Today\'s activity');
//     }
//   }

//   Color getColorForPercentage(double percentage) {
//     if (percentage < 0.5) {
//       return Colors.red;
//     } else if (percentage < 0.8) {
//       return Colors.orange;
//     } else {
//       return Colors.green;
//     }
//   }
// }
