import 'package:bestfriend/di.dart';
import 'package:bestfriend/mixins/snack_bar.mixin.dart';
import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.mixin.dart';
import 'package:flex_year_tablet/managers/dialog/dialog.model.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data_models/attendance_correction.data.dart';
import '../../../../services/attendance.service.dart';

class TodaysAttendanceActivities extends StatefulWidget
    with SnackbarMixin, DialogMixin {
  final AttendanceCorrectionData correctionData;

  TodaysAttendanceActivities(
    this.correctionData, {
    Key? key,
  }) : super(key: key);

  @override
  State<TodaysAttendanceActivities> createState() =>
      _TodaysAttendanceActivitiesState();
}

class _TodaysAttendanceActivitiesState
    extends State<TodaysAttendanceActivities> {
  //Request Review
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;
  final AttendanceService _attendanceService = locator<AttendanceService>();
  String currentDateTime = DateTime.now().toString();

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
                if (widget.correctionData.Status == "Lunch In")
                  const Text(
                    "Lunch In :- ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (widget.correctionData.Status != "Lunch In")
                  const Text(
                    "Check In :- ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Text(widget.correctionData.checkinDatetime == null
                    ? '-'
                    : widget.correctionData.checkinDatetime.toString())
              ],
            ),
            if (widget.correctionData.checkinDatetime != null)
              if (widget.correctionData.Status != "Lunch In")
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
                                  title: Text(
                                    "Request Review " +
                                        "(" "${widget.correctionData.Status.toString()}" +
                                        ")",
                                    style: const TextStyle(
                                        color: AppColor.primary),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          onSubmit(
                                              "${widget.correctionData.attendanceId}");
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: AppColor.primary),
                                        ))
                                  ],
                                  content: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Form(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Card(
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.calendar_today),
                                              title: const Expanded(
                                                  child:
                                                      Text('Select date...')),
                                              subtitle: Text(
                                                '${DateFormat.jm().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, _selectedTime.hour, _selectedTime.minute))}',
                                              ),
                                              trailing: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              onTap: _pickTime,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          FYInputField(
                                            label: 'Message',
                                            title: 'message ',
                                            controller: messageController,
                                          )
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
                if (widget.correctionData.checkoutDatetime != null)
                  if (widget.correctionData.statusOut == "Lunch Out")
                    const Text("Lunch Out :- ",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                if (widget.correctionData.checkoutDatetime != null)
                  if (widget.correctionData.statusOut != "Lunch Out")
                    const Text(
                      "Check Out :- ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                Text(widget.correctionData.checkoutDatetime == null
                    ? ''
                    : widget.correctionData.checkoutDatetime.toString()),
              ],
            ),
            if (widget.correctionData.checkoutDatetime != null)
              if (widget.correctionData.Status != "Lunch In")
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
                                  title: Text(
                                    "Request Review " + "(" "Check Out" + ")",
                                    style: const TextStyle(
                                        color: AppColor.primary),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          onSubmit(
                                              "${widget.correctionData.attendanceId}");
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: AppColor.primary),
                                        ))
                                  ],
                                  content: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Form(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Card(
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.calendar_today),
                                              title: const Text('Select Date'),
                                              subtitle: Text(
                                                '${DateFormat.jm().format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, _selectedTime.hour, _selectedTime.minute))}',
                                              ),
                                              trailing: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              onTap: _pickTime,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          FYInputField(
                                            label: 'Message',
                                            title: 'message ',
                                            controller: messageController,
                                          )
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
          ],
        ),
      ),
    );
  }

  Future<void> _pickTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (newTime != null) {
      setState(() {
        _selectedTime = newTime;
      });
    }
  }

  Future<void> onSubmit(String attendanceID) async {
    await _attendanceService.postTodayAttendanceRequestReview(
        reqDate:
            '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}',
        dateTime:
            '${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${_selectedTime.hour}:${_selectedTime.minute}:00',
        attendanceId: attendanceID,
        message: _messageController.text);
  }
}
