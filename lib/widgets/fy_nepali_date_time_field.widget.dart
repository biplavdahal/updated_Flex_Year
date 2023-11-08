import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../theme.dart';

class FYNepaliDateField extends StatelessWidget {
  final NepaliDateTime? nepaliValue;
  final String? title;
  final ValueSetter<NepaliDateTime?>? onNepaliChanged;
  final NepaliDateTime? nepaliFirstDate;
  final NepaliDateTime? nepaliLastDate;
  final Icon? icon;

  const FYNepaliDateField({
    Key? key,
    this.nepaliValue,
    this.title,
    this.onNepaliChanged,
    this.nepaliFirstDate,
    this.nepaliLastDate,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (title != null)
          const SizedBox(
            height: 8,
          ),
        GestureDetector(
          onTap: () {
            _showDatePicker(context);
          },
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    nepaliValue != null
                        ? (nepaliValue.toString())
                        : "Select date...",
                    style: nepaliValue == null
                        ? const TextStyle(
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  // Future<void> _selectNepaliDate() async {
  //   final NepaliDateTime? picked = await showMaterialDatePicker(
  //     context: context,
  //     firstDate: widget.nepaliFirstDate ??
  //         NepaliDateTime.now().subtract(Duration(days: 365)),
  //     lastDate: widget.nepaliLastDate ??
  //         NepaliDateTime.now().add(Duration(days: 365)),
  //     initialDate: _nepaliDate ?? NepaliDateTime.now(),
  //     textDirection: TextDirection.ltr,
  //     initialDatePickerMode: DatePickerMode.day,
  //   );

  //   if (picked != null && picked != _nepaliDate) {
  //     setState(() {
  //       _nepaliDate = picked;
  //     });
  //     widget.onNepaliChanged?.call(_nepaliDate);
  //   }
  // }

  Future<void> _showDatePicker(BuildContext context) async {
    final _pickeddate = await showMaterialDatePicker(
        context: context,
        firstDate: nepaliFirstDate ?? NepaliDateTime.now(),
        lastDate: nepaliLastDate ??
            NepaliDateTime.now().add(const Duration(days: 365)),
        helpText: title,
        initialDate: nepaliValue ?? NepaliDateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColor.primary,
              ),
              dialogBackgroundColor: AppColor.scaffold,
            ),
            child: child!,
          );
        });
    if (_pickeddate != null) {
      onNepaliChanged?.call(_pickeddate);
    }
  }
}
