import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/attendance_correction/attendance_correction.model.dart';
import 'package:flex_year_tablet/ui/attendance_correction/widgets/correction_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class AttendanceCorrectionView extends StatelessWidget {
  static String tag = 'attendance-correction-view';

  const AttendanceCorrectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceCorrectionModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Correction'),
          ),
          body: model.isLoading
              ? const FYLinearLoader()
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final _correction = model.corrections[index];
                      return CorrectionItem(
                        correction: _correction,
                        onDeletePressed: model.onDelete,
                      );
                    },
                    itemCount: model.corrections.length,
                  ),
                ),
        );
      },
    );
  }
}
