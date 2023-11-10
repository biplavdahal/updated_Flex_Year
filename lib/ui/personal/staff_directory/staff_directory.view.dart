import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/staff_directory.viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/staff_directory/widget/staff_directory_widget.dart';
import 'package:flex_year_tablet/widgets/fy_loader.widget.dart';
import 'package:flutter/material.dart';

class StaffDirectoryView extends StatelessWidget {
  static String tag = 'staff-directory-view';

  const StaffDirectoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<StaffDirectoryViewModel>(
      onModelReady: (model) => model.init(),
      killViewOnClose: false,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Staff Directory"),
          ),
          body: RefreshIndicator(
            onRefresh: model.init,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (model.isLoading) const FYLinearLoader(),
                if (!model.isLoading)
                  if (model.departmentListData.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final _directory = model.departmentListData[index];
                          return StaffDirectoryItem(
                            directory: _directory,
                            onClick: () async {
                              model.onClick(
                                  _directory.departmentName!.toString(), index);
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 0,
                        ),
                        itemCount: model.departmentListData.length,
                      ),
                    )
                  else
                    const Expanded(
                      child: Center(
                        child: Text('No Staff Directory Found'),
                      ),
                    )
              ],
            ),
          ),
        );
      },
    );
  }
}
