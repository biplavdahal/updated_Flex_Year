import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/resign/widget/resigh.widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/fy_shimmer.widget.dart';

class ResignView extends StatelessWidget {
  static String tag = 'resign-view';

  const ResignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ResignViewModel>(
      onDispose: (model) {},
      onModelReady: (model) async {
        await model.init();
      },
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Resign'),
          ),
          floatingActionButton: Stack(
            children: [
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {},
                ),
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (model.isLoading)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => getShimmerLoading(),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 30,
                            ),
                        itemCount: 9),
                  ),
                const SizedBox(height: 16),
                if (!model.isLoading)
                  if (model.resignData.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ResignItem(
                            resign: model.resignData[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: model.resignData.length,
                      ),
                    )
                  else
                    const Expanded(
                        child: Center(
                            child: Text('No Resignation letter sumbitted!')))
              ],
            ),
          ),
        );
      },
    );
  }
}
