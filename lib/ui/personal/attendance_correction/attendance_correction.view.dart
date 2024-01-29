import 'package:bestfriend/ui/view.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/attendance_correction.model.dart';
import 'package:flex_year_tablet/ui/personal/attendance_correction/widgets/correction_item.dart';
import 'package:flex_year_tablet/widgets/fy_shimmer.widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../theme.dart';

class AttendanceCorrectionView extends StatelessWidget {
  static String tag = 'attendance-correction-view';

  const AttendanceCorrectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrontView<AttendanceCorrectionModel>(
      onModelReady: (model) => model.init(),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance Correction'),
          ),
          floatingActionButton: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.grey[300],
                      padding: const EdgeInsets.all(2),
                    ),
                    onPressed: () async {
                      model.loadMore();
                    },
                    child: const Text('Tap to loadMore...'),
                  ),
                ),
              )
            ],
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
                      child: SmartRefresher(
                        header: ClassicHeader(
                          idleText: "Pull down to refresh",
                          releaseText: "Release to refresh",
                          refreshingText: "Refreshing...",
                          completeText: "Refresh complete",
                          failedText: "Refre* sh failed",
                          completeIcon:
                              Icon(MdiIcons.checkAll, color: Colors.grey),
                        ),
                        enablePullDown: true,
                        controller: model.refreshController,
                        onRefresh: model.init,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DelayedDisplay(
                              child: CorrectionItem(
                                index: index,
                                correction: model.correctionsToShow[index],
                                isBusy: model.isBusyWidget(
                                    model.correctionsToShow[index].id),
                                // onDeletePressed: model.onDelete,
                                onApprove: model.onApprove,
                                onDecline: model.onDecline,
                              ),
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
                      child: SmartRefresher(
                        header: ClassicHeader(
                          idleText: "Pull down to refresh",
                          releaseText: "Release to refresh",
                          refreshingText: "Refreshing...",
                          completeText: "Refresh complete",
                          failedText: "Refre* sh failed",
                          completeIcon:
                              Icon(MdiIcons.checkAll, color: Colors.grey),
                        ),
                        enablePullDown: true,
                        controller: model.refreshController,
                        onRefresh: model.init,
                        child: ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DelayedDisplay(
                                child: CorrectionItem(
                                  index: index,
                                  correction: model.corrections[index],
                                  isBusy: model.isBusyWidget(
                                    model.corrections[index].id,
                                  ),
                                  // onDeletePressed: model.onDelete,
                                  onApprove: model.onApprove,
                                  onDecline: model.onDecline,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: model.corrections.length),
                      ),
                    )
                  else
                    const Expanded(
                        child:
                            Center(child: Text("No Attendance Correncion...")))
              ],
            ),
          ),
        );
      },
    );
  }
}
