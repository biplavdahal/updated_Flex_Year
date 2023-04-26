import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/date_converter/date_converter.viewmodel.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_nepali_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_section.widget.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DateConverterView extends StatelessWidget {
  static String tag = 'date-converter-view';

  const DateConverterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<DateConverterViewModel>(
        enableTouchRepeal: true,
        onModelReady: (model) => model,
        builder: (ctx, model, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Date Converter'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildValidAttendance(model),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildEnglish(model),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildNepali(model)
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Widget _buildEnglish(DateConverterViewModel model) {
    return FYSection(
      title: "Convert From AD to BS : ",
      infoBox: true,
      child: Row(
        children: [
          Expanded(
            child: FYDateField(
              onChanged: (value) => model.dateFrom = value!,
              value: model.dateFrom,
              firstDate: DateTime.now().subtract(
                const Duration(days: 365 * 7),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  model.dateTo != null
                      ? DateFormat('yyyy-MM-dd').format(model.dateTo!)
                      : '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildValidAttendance(DateConverterViewModel model) {
    return const Text(
      "The selected date will automatically be converted.",
      style: TextStyle(
        color: Colors.deepOrange,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildNepali(DateConverterViewModel model) {
    return FYSection(
      title: "Convert From BS to AD",
      infoBox: true,
      child: Row(
        children: [
          Expanded(
            child: FYNepaliDateField(
              onNepaliChanged: (value) => model.nepaliDateFrom = value!,
              nepaliValue: model.nepaliDateFrom,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  model.nepaliDateTo != null
                      ? DateFormat('yyyy-MM-dd').format(model.nepaliDateTo!)
                      : '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
