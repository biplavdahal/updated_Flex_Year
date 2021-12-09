import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/data_models/attendance_correction.data.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.arguments.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.model.dart';
import 'package:flex_year_tablet/ui/personal/request_review/request_review.view.dart';
import 'package:flutter/material.dart';

class CorrectionItem extends StatelessWidget {
  final AttendanceCorrectionData correction;
  final ValueSetter<String> onDeletePressed;

  const CorrectionItem({
    Key? key,
    required this.correction,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _status = {
      "P": "Pending",
      "D": "Declined",
      "A": "Approved",
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  correction.checkinDatetime != null
                      ? formattedDate(correction.checkinDatetime!)
                      : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Row(
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.edit,
                        color: _status[correction.correctionStatus] == "Pending"
                            ? AppColor.primary
                            : Colors.grey,
                      ),
                      onTap: _status[correction.correctionStatus] == "Pending"
                          ? () {
                              locator<AttendanceCorrectionModel>().goto(
                                RequestReviewView.tag,
                                arguments: RequestReviewArguments<
                                    AttendanceCorrectionData>(
                                  type: RequestReviewType.updateReview,
                                  payload: correction,
                                ),
                              );
                            }
                          : null,
                    ),
                    const SizedBox(width: 14),
                    GestureDetector(
                      child: Icon(
                        Icons.delete,
                        color: _status[correction.correctionStatus] == "Pending"
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      onTap: _status[correction.correctionStatus] == "Pending"
                          ? () {
                              onDeletePressed(correction.attendanceId);
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              headingRowHeight: 0,
              columns: const [
                DataColumn(label: Text("")),
                DataColumn(label: Text("")),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text("In Request Time")),
                    DataCell(
                      Text(
                        correction.checkinDatetime != null
                            ? formattedTime(correction.checkinDatetime!)
                            : "N/A",
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Out Request Time")),
                    DataCell(
                      Text(
                        correction.checkoutDatetime != null
                            ? formattedTime(correction.checkoutDatetime!)
                            : "N/A",
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("In Time")),
                    DataCell(
                      Text(
                        correction.checkinDatetimeRequest != null
                            ? formattedTime(correction.checkinDatetimeRequest!)
                            : "N/A",
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Out Time")),
                    DataCell(
                      Text(
                        correction.checkoutDatetimeRequest != null
                            ? formattedTime(correction.checkoutDatetimeRequest!)
                            : "N/A",
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("Status")),
                    DataCell(
                      Text(
                        _status[correction.correctionStatus]!,
                        style: TextStyle(
                          color:
                              _status[correction.correctionStatus] == "Pending"
                                  ? Colors.orange
                                  : _status[correction.correctionStatus] ==
                                          "Approved"
                                      ? Colors.green
                                      : Colors.red,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
