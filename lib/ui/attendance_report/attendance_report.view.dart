import 'package:bestfriend/bestfriend.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/attendance_report/attandance_report.model.dart';
import 'package:flex_year_tablet/ui/attendance_report/attendance_report.arguments.dart';
import 'package:flex_year_tablet/ui/attendance_report/widgets/report_item.dart';
import 'package:flex_year_tablet/ui/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/ui/attendance_summary/attendance_summary.arguments.dart';
import 'package:flex_year_tablet/ui/attendance_summary/attendance_summary.view.dart';
import 'package:flex_year_tablet/ui/attendance_summary/widgets/summary_item.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AttendanceReportView extends StatelessWidget {
  static String tag = 'attendance-report-view';

  final Arguments? arguments;

  const AttendanceReportView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceReportModel>(
      onModelReady: (model) =>
          model.init(arguments as AttendanceReportArguments),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              model.filterType == AttendanceReportFilterType.daily
                  ? 'One Day Report'
                  : model.filterType == AttendanceReportFilterType.weekly
                      ? 'Weekly Report'
                      : 'Monthly Report',
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: model.onFilterPressed,
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopInfoBar(model),
                const SizedBox(height: 16),
                _buildData(model),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopInfoBar(AttendanceReportModel model) {
    if (model.filterType == AttendanceReportFilterType.monthly) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Attendence [${model.searchParams['type']}] Report for ${getMonthStringFromDateString(model.searchParams['date_from'])}',
            ),
            if (model.searchParams.containsKey('client_id'))
              const SizedBox(height: 6),
            if (model.searchParams.containsKey('client_id'))
              Text(
                'Client: ${model.searchParams['client_name']}',
              ),
          ],
        ),
      );
    }

    if (model.filterType == AttendanceReportFilterType.daily) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formattedDate(
                model.searchParams['date'],
              ),
            ),
            if (model.searchParams.containsKey('client_id'))
              const SizedBox(height: 6),
            if (model.searchParams.containsKey('client_id'))
              Text(
                'Client: ${model.searchParams['client_name']}',
              ),
            if (model.searchParams['type'] != 'All') const SizedBox(height: 6),
            if (model.searchParams['type'] != 'All')
              FYSecondaryButton(
                label: 'View [All] detailed report',
                onPressed: () {},
              ),
          ],
        ),
      );
    }

    if (model.filterType == AttendanceReportFilterType.weekly) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Date: ${formattedDate(model.searchParams['begDate'])} - ${formattedDate(model.searchParams['endDate'])}',
            ),
            if (model.searchParams.containsKey('client_id'))
              const SizedBox(height: 6),
            if (model.searchParams.containsKey('client_id'))
              Text(
                'Client: ${model.searchParams['client_name']}',
              ),
          ],
        ),
      );
    }

    return Container();
  }

  Widget _buildData(AttendanceReportModel model) {
    if (model.isLoading) {
      return const FYLinearLoader();
    }

    if (model.filterType == AttendanceReportFilterType.monthly) {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final _report = model.monthlyReport[index];

            return ReportItem(
              _report,
              onTap: () => model.goto(
                AttendanceSummaryView.tag,
                arguments: AttendanceSummaryArguments(
                  date: _report.date,
                  clientId: model.searchParams['client_id'],
                ),
              ),
            );
          },
          itemCount: model.monthlyReport.length,
        ),
      );
    }

    if (model.filterType == AttendanceReportFilterType.weekly) {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final _report = model.weeklyReport[index];

            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Text(
                          "Employee name:",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _report.name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all<Color>(
                        AppColor.primary.withOpacity(0.16),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text('Weekday'),
                        ),
                        DataColumn(
                          label: Text('Working Hr.'),
                        ),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            const DataCell(Text("Monday")),
                            DataCell(
                              Text(
                                _report.monday,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _report.monday == "NS"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Tuesday")),
                            DataCell(
                              Text(
                                _report.tuesday,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _report.tuesday == "NS"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Wednesday")),
                            DataCell(
                              Text(
                                _report.wednesday,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _report.wednesday == "NS"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Thursday")),
                            DataCell(
                              Text(
                                _report.thursday,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _report.thursday == "NS"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Friday")),
                            DataCell(
                              Text(
                                _report.friday,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _report.friday == "NS"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Saturday")),
                            DataCell(
                              Text(
                                _report.saturday,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _report.saturday == "NS"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Sunday")),
                            DataCell(
                              Text(
                                _report.sunday,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _report.sunday == "NS"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                _report.totalWorkingHr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: model.weeklyReport.length,
        ),
      );
    }

    if (model.filterType == AttendanceReportFilterType.daily) {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final _report = model.summary[index];

            return SummaryItem(
              _report,
            );
          },
          itemCount: model.summary.length,
        ),
      );
    }

    return Container();
  }
}
