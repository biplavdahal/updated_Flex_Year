import 'package:bestfriend/model/arguments.model.dart';
import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_arguments.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/fy_date_time_field.widget.dart';

class WriteResignRequestView extends StatefulWidget {
  static String tag = 'write-resign-request-view';

  final Arguments? arguments;

  const WriteResignRequestView(this.arguments, {Key? key}) : super(key: key);

  @override
  State<WriteResignRequestView> createState() => _WriteResignRequestViewState();
}

class _WriteResignRequestViewState extends State<WriteResignRequestView> {
  @override
  Widget build(BuildContext context) {
    return FrontView<ResignViewModel>(
      onModelReady: (model) =>
          model.init(widget.arguments as ResighViewArguments?),
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.arguments != null
                ? 'Update Resign Request'
                : 'Create Resign Request'),
          ),
          body: Container(
            padding: const EdgeInsets.all(13),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: model.formKey,
                child: Column(
                  children: [
                    FYDateField(
                      title: 'Effective Date : ',
                      value: model.resignDate,
                      onChanged: (value) => model.resignDate = value,
                    ),
                    const SizedBox(height: 16),
                    DropdownButton(
                      hint: const Text('Select Reason'),
                      value: model.selecteditems,
                      onChanged: (Value) {
                        setState(() {
                          model.selecteditems = Value! as String;
                        });
                      },
                      items: model.items.map((location) {
                        return DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                        maxLines: 7,
                        decoration: const InputDecoration(
                          labelText: 'Reason for Resignation',
                          hintText: 'Dear HR...',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter a reason for resigning';
                          }
                          return null;
                        },
                        initialValue: model.resignLetterController.text,
                        onChanged: (value) {
                          final modifiedValue = value
                              .replaceAll(' ', '\t')
                              .replaceAll('\n', '\n');
                          model.resignLetterController.text = modifiedValue;
                        }),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 20,
                    ),
                    FYPrimaryButton(
                      label: widget.arguments != null
                          ? 'Update Resignation'
                          : 'Submit resignation',
                      onPressed: () {
                        if (model.formKey.currentState?.validate() ?? false) {
                          model.onSubmitResignData();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    if (widget.arguments == null)
                      const Text(
                          'Note : Once you submit resign letter it cannot be deteted !',
                          style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
