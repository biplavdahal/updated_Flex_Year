import 'package:bestfriend/bestfriend.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flex_year_tablet/data_models/present_staff.data.dart';
import 'package:flex_year_tablet/services/attendance.service.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/presentStaff/widget/presentstaff.item.dart';
import 'package:flutter/material.dart';

class PresentStaffSearch extends SearchDelegate {
  @override
  final _attendanceService = locator<AttendanceService>();

  //Data of presenstaff
  List<PresentStaffModelData> get presentStaff =>
      _attendanceService.presentStaff;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<PresentStaffModelData> matchQuery = [];
    for (var value in presentStaff) {
      if (value.staffName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(value);
      }
    }

    return Stack(
      children: [
        ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  height: 3,
                ),
            itemBuilder: (context, index) {
              final _staff = matchQuery[index];
              return DelayedDisplay(child: PresentStaffItem(staff: _staff));
            },
            itemCount: matchQuery.length)
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PresentStaffModelData> matchQuery = [];
    for (var value in presentStaff) {
      if (value.staffName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(value);
      }
    }
    return Stack(
      children: [
        ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  height: 3,
                ),
            itemBuilder: (context, index) {
              final _staff = matchQuery[index];
              return DelayedDisplay(child: PresentStaffItem(staff: _staff));
            },
            itemCount: matchQuery.length)
      ],
    );
  }
}
