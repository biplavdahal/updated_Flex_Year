import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/material.dart';
import '../../../../data_models/attendance_correction.data.dart';

class TodaysAttendanceActivities extends StatelessWidget {
  final AttendanceCorrectionData correctionData;

  const TodaysAttendanceActivities(
    this.correctionData, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      scrollbarOrientation: ScrollbarOrientation.bottom,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Row(
              children: [
                if (correctionData.Status == "Lunch In")
                  const Text(
                    "Lunch In :- ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (correctionData.Status != "Lunch In")
                  const Text(
                    "Check In :- ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Text(correctionData.checkinDatetime == null
                    ? '-'
                    : correctionData.checkinDatetime.toString())
              ],
            ),
            if (correctionData.checkinDatetime != null)
              if (correctionData.Status != "Lunch In")
                SizedBox(
                    height: 29,
                    width: 110,
                    child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text("Request Review"),
                                  content: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Form(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          FYTimeField(
                                            title: "Request Time",
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          FYInputField(
                                              label: 'Message',
                                              title: 'message ')
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: Text(
                              "Request Review",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ))),
            const SizedBox(
              width: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (correctionData.checkoutDatetime != null)
                  if (correctionData.statusOut == "Lunch Out")
                    const Text("Lunch Out :- ",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                if (correctionData.checkoutDatetime != null)
                  if (correctionData.statusOut != "Lunch Out")
                    const Text(
                      "Check Out :- ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                Text(correctionData.checkoutDatetime == null
                    ? ''
                    : correctionData.checkoutDatetime.toString())
              ],
            ),
            if (correctionData.checkoutDatetime != null)
              if (correctionData.Status != "Lunch In")
                SizedBox(
                    height: 29,
                    width: 110,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: FittedBox(
                            fit: BoxFit.none,
                            child: Text(
                              "Request Review",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ))),
          ],
        ),
      ),
    );
  }
}
