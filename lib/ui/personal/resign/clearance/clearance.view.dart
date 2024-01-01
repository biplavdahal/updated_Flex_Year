import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/resign/widget/clearance.widget.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/fy_shimmer.widget.dart';
import '../resign_viewmodel.dart';

class ClearanceView extends StatelessWidget {
  static String tag = 'clearance-view';

  const ClearanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ResignViewModel>(
      onModelReady: (model) => model.Clearanceinit(),
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Clearance'),
          ),
          body: RefreshIndicator(
            onRefresh: () => model.Clearanceinit(),
            child: Container(
              padding: const EdgeInsets.fromLTRB(50, 50, 40, 0),
              child: Column(
                children: [
                  if (model.isLoading)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => getShimmerLoading(),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 30,
                        ),
                        itemCount: 5,
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (!model.isLoading)
                    if (model.clearanceData.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (index < model.clearanceData.length) {
                              return ClearanceItem(
                                clearance: model.clearanceData[index],
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 40,
                            );
                          },
                          itemCount: model.clearanceData.length,
                        ),
                      )
                    else
                      const Expanded(
                        child: Center(child: Text('No Clearance report found')),
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
