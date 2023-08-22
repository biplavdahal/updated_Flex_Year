import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/holidays/holidays.model.dart';
import 'package:flex_year_tablet/ui/personal/notice/notice.viewmodel.dart';
import 'package:flex_year_tablet/ui/personal/notice/widget/notice_item.dart';
import 'package:flutter/material.dart';

class NoticeView extends StatelessWidget {
  static String tag = 'notice-view';

  const NoticeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<NoticeModel>(
      onModelReady: (model) => model.init(),
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Upcoming Notice'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (HolidaysModel.upcomingHoliday.date.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final _notice = HolidaysModel.upcomingHoliday;
                          return NoticeItem(
                            notice: _notice,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 0,
                        ),
                        itemCount: 1,
                      ),
                    )
                  // else
                  // const Expanded(
                  //     child: Center(child: Text('No upcomming notice!!')))
                ],
              )),
        );
      },
    );
  }
}


//  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//                           DateTime date = dateFormat.parse(_holiday.date);

//                           if (date.compareTo(DateTime.now()) < 0) {
//                             return Container();
//                           }
