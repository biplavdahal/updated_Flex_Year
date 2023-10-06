import 'package:bestfriend/di.dart';
import 'package:bestfriend/model/arguments.model.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/ui/personal/performance/performance_model.dart';
import 'package:flex_year_tablet/ui/personal/profile/widget/arguments.dart';
import 'package:flutter/material.dart';
import '../../../data_models/staff.data.dart';
import '../../../services/authentication.service.dart';
import '../../../theme.dart';

class PerformanceView extends StatelessWidget {
  final Arguments? arguments;
  static String tag = "performance-view";

  const PerformanceView({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StaffData _user = locator<AuthenticationService>().user!.staff;
    return View<PerformanceModel>(
      onModelReady: (model) =>
          model.init(arguments as StaffPerformanceArguments),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Performance report"),
            bottom: PreferredSize(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          auBaseURL + model.logo.logoPath,
                          width: 90,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Performance review of " +
                              (model.data['year'] ?? '') +
                              " " +
                              (model.data['month_name'] ?? '').toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              preferredSize: const Size(double.infinity, 50),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F1F1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      iconColor: AppColor.primary,
                      textColor: AppColor.primary,
                      childrenPadding:
                          const EdgeInsets.only(left: 16, right: 16),
                      tilePadding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "Employee Information",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Name ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(_user.firstName.toString() +
                                " " +
                                _user.middleName.toString() +
                                " " +
                                _user.lastName.toString())
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Department',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('Developent')
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Perf.Date',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(model.data['year'] +
                                " " +
                                model.data['month_name']),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Emp Type',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text("Full Time"),
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Text(
                                  "Ratings",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Colors.amber,
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "1= poor",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Colors.amber,
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "2=  Fair",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Colors.amber,
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "3= Satisfy",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Colors.amber,
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "4= Good",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: VerticalDivider(
                                  color: Colors.amber,
                                  thickness: 1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "5=    Excellent",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            headingRowHeight: 0,
                            dividerThickness: 0,
                            horizontalMargin: 10,
                            columns: const [
                              DataColumn(
                                label: Text(""),
                              ),
                              DataColumn(
                                label: Text(""),
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Job Knowledge",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(model.data['job_know'] != null
                                          ? model.data['job_know'].toString()
                                          : '--')
                                    ],
                                  )),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      'Comments : ' +
                                          model.data['job_know_commrnt'],
                                    ),
                                  ),
                                  const DataCell(
                                    Text(
                                      "",
                                      style: TextStyle(
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Work Quality",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      model.data['quality'] != null
                                          ? model.data['quality'].toString()
                                          : '--',
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "Comments : " +
                                          model.data['quality_comment'],
                                    ),
                                  ),
                                  const DataCell(
                                    Text(""),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Attendance/Punctuality",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      model.data['punctuality'] != null
                                          ? model.data['punctuality'].toString()
                                          : '--',
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "Comments : " +
                                          model.data['punctuality_comment'],
                                    ),
                                  ),
                                  const DataCell(
                                    Text(
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Productivity",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(model.data['productivity'] != null
                                        ? model.data['productivity'].toString()
                                        : '--'),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "Comments : " +
                                          model.data['productivity_comment'],
                                    ),
                                  ),
                                  const DataCell(
                                    Text(
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Comm./Listening Skills",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      model.data['communication'] != null
                                          ? model.data['communication']
                                              .toString()
                                          : '--',
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "Comments : " +
                                          model.data['communication_comment'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                  const DataCell(
                                    Text(
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Dependability",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      model.data['dependability'] != null
                                          ? model.data['dependability']
                                              .toString()
                                          : "--",
                                    ),
                                  ),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text(
                                      "Comments : " +
                                          model.data['dependability_comment'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w100,
                                      ),
                                    ),
                                  ),
                                  const DataCell(
                                    Text(
                                      "",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      iconColor: AppColor.primary,
                      textColor: AppColor.primary,
                      childrenPadding:
                          const EdgeInsets.only(left: 16, right: 16),
                      tilePadding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "Evaluation",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Additional Comments : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(model.data['additional_comment'])
                            ],
                          ),
                        ),
                        const Divider(),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Goal comment :',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text("  " + model.data['goal_comment']),
                            ],
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Text(
                                  "Verification of Review ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            headingRowHeight: 0,
                            dividerThickness: 0,
                            horizontalMargin: 10,
                            columns: const [
                              DataColumn(
                                label: Text(""),
                              ),
                              DataColumn(
                                label: Text(""),
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Supervisor Signature",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [Text(model.data['s_name'])],
                                    ),
                                  )),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  const DataCell(
                                    Text(
                                      "Date",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      model.data['from'] +
                                          " - " +
                                          model.data['s_date'],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
