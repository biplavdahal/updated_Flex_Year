import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/widgets/correction_item.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flex_year_tablet/widgets/fy_shimmer.widget.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';

class AttendanceCorrectionView extends StatelessWidget {
  static String tag = 'attendance-correction-view';

  const AttendanceCorrectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<AttendanceCorrectionModel>(
      onModelReady: (model) => model.init(),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Correction'),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    model.tabs.length,
                    (index) => ChoiceChip(
                      label: Text(model.tabs[index]),
                      selected: model.selectedTab == index.toString(),
                      selectedColor: Colors.black38,
                      onSelected: (_) => model.selectedTab = index.toString(),
                    ),
                  ),
                ),
                if (model.isLoading)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => getShimmerLoading(),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 30,
                            ),
                        itemCount: 9),
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (!model.isLoading)
                  if (model.correctionsToShow.isNotEmpty)
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: model.init,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CorrectionItem(
                              correction: model.correctionsToShow[index],
                              isBusy: model.isBusyWidget(
                                  model.correctionsToShow[index].id),
                              onDeletePressed: model.onDelete,
                              onApprove: model.onApprove,
                              onDecline: model.onDecline,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                          itemCount: model.correctionsToShow.length,
                        ),
                      ),
                    )
                  else if (model.selectedTab == '0')
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: model.init,
                        child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CorrectionItem(
                                correction: model.corrections[index],
                                isBusy: model.isBusyWidget(
                                  model.corrections[index].id,
                                ),
                                onDeletePressed: model.onDelete,
                                onApprove: model.onApprove,
                                onDecline: model.onDecline,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: model.corrections.length),
                      ),
                    ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                      onTap: model.loadMore,
                      child: const SizedBox(
                        height: 30,
                        child: Center(
                            child: Text(
                          "Tap to loadMore ...",
                          style: TextStyle(color: AppColor.primary),
                        )),
                      )),
                ),
                if (model.selectedTab != '0')
                  if (model.correctionsToShow.isEmpty)
                    const Center(child: Text("No Attendance Corrections..."))
              ],
            ),
          ),
        );
      },
    );
  }
}
