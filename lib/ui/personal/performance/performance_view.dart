import 'package:bestfriend/di.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/constants/api.constants.dart';
import 'package:flex_year_tablet/ui/personal/performance/performance_model.dart';
import 'package:flutter/material.dart';

import '../../../data_models/staff.data.dart';
import '../../../services/authentication.service.dart';
import '../../../theme.dart';

class PerformanceView extends StatelessWidget {
  static String tag = "performance-view";
  const PerformanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StaffData _user = locator<AuthenticationService>().user!.staff;
    return View<PerformanceModel>(
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
                          width: 100,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Employee Performance Review",
                          style: TextStyle(color: Colors.white),
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
            child: RefreshIndicator(
              onRefresh: model.init,
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
                              Text(_user.firstName +
                                  " " +
                                  _user.middleName +
                                  " " +
                                  _user.lastName)
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
                              Text("Development"),
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
                              Text("2080-Baishakh"),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
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
                                  child: Text("1= poor"),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.amber,
                                    thickness: 1,
                                  ),
                                ),
                                Expanded(
                                  child: Text("2=  Fair"),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.amber,
                                    thickness: 1,
                                  ),
                                ),
                                Expanded(
                                  child: Text("3= Satisfy"),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.amber,
                                    thickness: 1,
                                  ),
                                ),
                                Expanded(
                                  child: Text("4= Good"),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.amber,
                                    thickness: 1,
                                  ),
                                ),
                                Expanded(
                                  child: Text("5=    Excellent"),
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
                                      children: [Text("3")],
                                    )),
                                  ],
                                ),
                                const DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "",
                                        style: const TextStyle(
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
                                        "3",
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ),
                                    DataCell(
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
                                        "3",
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ),
                                    DataCell(
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
                                      Text(
                                        "2",
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ),
                                    DataCell(
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
                                        "2",
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ),
                                    DataCell(
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
                                        "4",
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    const DataCell(
                                      Text(
                                        "Comments",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ),
                                    DataCell(
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
                    SizedBox(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Additional Comments",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(_user.firstName +
                                  " " +
                                  _user.middleName +
                                  " " +
                                  _user.lastName)
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Employee Goals',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text("Flex-Year"),
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
                                    DataCell(Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [Text("Tika Raj Shrestha")],
                                    )),
                                  ],
                                ),
                                const DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        "Date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        "2023-05-15",
                                        style: const TextStyle(
                                          height: 1.5,
                                        ),
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
          ),
        );
      },
    );
  }
}
