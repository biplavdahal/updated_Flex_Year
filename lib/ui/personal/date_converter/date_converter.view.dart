import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/date_converter/date_converter.viewmodel.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_nepali_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_section.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class DateConverterView extends StatelessWidget {
  static String tag = 'date-converter-view';

  const DateConverterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrontView<DateConverterViewModel>(
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
                        _buildEnglish(context, model),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildNepali(context, model)
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Widget _buildEnglish(BuildContext context, DateConverterViewModel model) {
    void copyToClipboard(BuildContext context, String text) {
      ClipboardData data = ClipboardData(text: text);
      Clipboard.setData(data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: AppColor.primary,
            content: const Text('Text copied to clipboard.')),
      );
    }

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
                const Duration(days: 365 * 140),
              ),
              lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.dateTo != null
                          ? DateFormat('yyyy-MM-dd').format(model.dateTo!)
                          : '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      onPressed: () {
                        String text = model.dateTo != null
                            ? DateFormat('yyyy-MM-dd').format(model.dateTo!)
                            : '';
                        copyToClipboard(context, text);
                      },
                      icon: const Icon(
                        Icons.copy,
                        size: 16,
                      ),
                    ),
                  ],
                ),
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

  Widget _buildNepali(BuildContext context, DateConverterViewModel model) {
    void copyToClipboard(BuildContext context, String text) {
      ClipboardData data = ClipboardData(text: text);
      Clipboard.setData(data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: const Text(
            'Text copied to clipboard.',
          ),
          backgroundColor: AppColor.accent,
        ),
      );
    }

    return FYSection(
      title: "Convert From BS to AD",
      infoBox: true,
      child: Row(
        children: [
          Expanded(
            child: FYNepaliDateField(
              onNepaliChanged: (value) => model.nepaliDateFrom = value!,
              nepaliValue: model.nepaliDateFrom,
              nepaliFirstDate: NepaliDateTime.now()
                  .subtract(const Duration(days: 365 * 140)),
              nepaliLastDate:
                  NepaliDateTime.now().add(const Duration(days: 365 * 20)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.nepaliDateTo != null
                          ? DateFormat('yyyy-MM-dd').format(model.nepaliDateTo!)
                          : '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    String text = model.nepaliDateTo != null
                        ? DateFormat('yyyy-MM-dd').format(model.nepaliDateTo!)
                        : '';
                    copyToClipboard(context, text);
                  },
                  icon: const Icon(
                    Icons.copy,
                    size: 16,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
