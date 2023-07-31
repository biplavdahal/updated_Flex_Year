import 'package:bestfriend/ui/view.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/presentStaff/presentstaff.model.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/presentStaff/widget/presentstaff.item.dart';
import 'package:flex_year_tablet/ui/personal/dashboard/presentStaff/widget/presentstaffsearch.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../../widgets/fy_shimmer.widget.dart';

class PresentStaffView extends StatelessWidget {
  static String tag = 'presentstaff-view';

  const PresentStaffView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<PresentStaffModel>(
      onModelReady: (model) async {
        await model.init();
      },
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Present Staffs'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'Search',
                onPressed: () {
                  showSearch(context: context, delegate: PresentStaffSearch());
                },
              ),
            ],
          ),
          body: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 30,
                      children: List.generate(
                        model.tabs.length,
                        (index) => ChoiceChip(
                          label: Text(model.tabs[index]),
                          selected: model.selectedTab == index.toString(),
                          onSelected: (_) =>
                              model.selectedTab = index.toString(),
                          selectedColor: Colors.black38,
                        ),
                      ),
                    ),
                    if (model.isLoading)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                getShimmerLoading(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 30,
                                ),
                            itemCount: 9),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (!model.isLoading)
                      if (model.filteredList.isNotEmpty)
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: model.init,
                            child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return DelayedDisplay(
                                    child: PresentStaffItem(
                                        staff: model.filteredList[index]),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 0,
                                  );
                                },
                                itemCount: model.filteredList.length),
                          ),
                        )
                      else
                        const Expanded(
                            child: Center(child: Text('No data available!')))
                  ])),
        );
      },
    );
  }
}
