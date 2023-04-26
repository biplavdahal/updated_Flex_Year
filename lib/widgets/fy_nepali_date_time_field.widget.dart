import 'package:flutter/material.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class FYNepaliDateField extends StatefulWidget {
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
  _NepaliDateFieldState createState() => _NepaliDateFieldState();
}

class _NepaliDateFieldState extends State<FYNepaliDateField> {
  NepaliDateTime? _nepaliDate;

  @override
  void initState() {
    super.initState();
    _nepaliDate = widget.nepaliValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectNepaliDate,
      child: InputDecorator(
        decoration: InputDecoration(
            border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.0),
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                  _nepaliDate != null
                      ? NepaliDateFormat("y-MM-dd").format(_nepaliDate!)
                      : "मिति चयन गर्नुहोस्",
                  style: _nepaliDate == null
                      ? const TextStyle(
                          color: Colors.grey,
                        )
                      : null),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectNepaliDate() async {
    final NepaliDateTime? picked = await showMaterialDatePicker(
      context: context,
      firstDate: widget.nepaliFirstDate ??
          NepaliDateTime.now().subtract(Duration(days: 365)),
      lastDate: widget.nepaliLastDate ??
          NepaliDateTime.now().add(Duration(days: 365)),
      initialDate: _nepaliDate ?? NepaliDateTime.now(),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
    );

    if (picked != null && picked != _nepaliDate) {
      setState(() {
        _nepaliDate = picked;
      });
      widget.onNepaliChanged?.call(_nepaliDate);
    }
  }
}
