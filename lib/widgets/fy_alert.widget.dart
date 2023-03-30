import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/material.dart';

class FYAlertWidget extends StatefulWidget {
  final String? message;
  final String? title;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  const FYAlertWidget(
      {Key? key, this.controller, this.onTap, this.title, this.message})
      : super(key: key);

  @override
  State<FYAlertWidget> createState() => _FYAlertWidgetState();
}

class _FYAlertWidgetState extends State<FYAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Request Review'),
      content: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Status',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Please Select Time"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Request message'),
              )
            ],
          ),
        ),
      ),
      actions: [
        FYPrimaryButton(
          label: "Submit",
        )
      ],
    );
  }
}
