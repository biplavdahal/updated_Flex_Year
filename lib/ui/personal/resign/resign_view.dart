import 'package:bestfriend/model/arguments.model.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_arguments.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/resign/widget/resigh.widget.dart';
import 'package:flex_year_tablet/ui/personal/resign/write_resigh_request/write_resign_request.view.dart';
import 'package:flutter/material.dart';

import '../../../widgets/fy_shimmer.widget.dart';

class ResignView extends StatelessWidget {
  static String tag = 'resign-view';

  final Arguments? arguments;

  const ResignView(this.arguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrontView<ResignViewModel>(
      onDispose: ((model) {}),
      onModelReady: (model) => model.init(arguments as ResighViewArguments?),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Resign Letter'),
          ),
          floatingActionButton: Stack(
            children: [
              if (model.resignData.isEmpty)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () async {
                      model.goto(WriteResignRequestView.tag);
                    },
                  ),
                ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => model.init(arguments as ResighViewArguments?),
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  if (model.isLoading)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => getShimmerLoading(),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 30,
                              ),
                          itemCount: 5),
                    ),
                  const SizedBox(height: 16),
                  if (!model.isLoading)
                    if (model.resignData.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ResignItem(
                              resign: model.resignData[index],
                              onEditTap: model.onUpdatePressed,
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
                      Expanded(
                          child: RefreshIndicator(
                        onRefresh: () =>
                            model.init(arguments as ResighViewArguments?),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No resignation Letter submitted !!'),
                            IconButton(
                                onPressed: (() => model
                                    .init(arguments as ResighViewArguments?)),
                                icon: const Icon(Icons.refresh))
                          ],
                        )),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
