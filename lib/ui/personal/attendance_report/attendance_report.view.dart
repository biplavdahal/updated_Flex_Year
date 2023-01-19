import 'package:bestfriend/bestfriend.dart';
import 'package:flex_year_tablet/helper/date_time_formatter.helper.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attandance_report.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/attendance_report.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/widgets/monthly_horizontal_report_item.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/widgets/monthly_report_item.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/widgets/one_day_report_item.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report/widgets/weekly_report_item.dart';
import 'package:flex_year_tablet/ui/personal/attendance_report_filter/attendance_report_filter.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.arguments.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/attendance_summary.view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_summary/widgets/summary_item.dart';
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
              model.filterType == AttendanceReportFilterType.daily ||
                      model.filterType ==
                          AttendanceReportFilterType.oneDayReport
                  ? 'One Days Report'
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
                if (model.filterType == AttendanceReportFilterType.monthly)
                  _buildHorizontalData(model),
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

    if (model.filterType == AttendanceReportFilterType.daily ||
        model.filterType == AttendanceReportFilterType.oneDayReport) {
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

  Widget _buildHorizontalData(AttendanceReportModel model) {
    if (model.isLoading) {
      return const FYLinearLoader();
    }
    if (model.filterType == AttendanceReportFilterType.monthly) {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: model.monthlyReport.length,
          itemBuilder: (context, index) {
            final _report = model.monthlyReport[index];

            return MonthlyHorizontalReportItem(
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
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildData(AttendanceReportModel model) {
    if (model.filterType == AttendanceReportFilterType.monthly) {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final _report = model.monthlyReport[index];

            return MonthlyReportItem(
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

            return WeeklyReportItem(report: _report);
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

    if (model.filterType == AttendanceReportFilterType.oneDayReport) {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return OneDayReport(
              report: model.oneDayReports[index],
            );
          },
          itemCount: model.oneDayReports.length,
        ),
      );
    }

    return Container();
  }
}
