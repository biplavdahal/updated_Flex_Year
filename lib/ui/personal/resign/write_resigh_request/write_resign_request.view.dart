import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/ui/personal/resign/resign_viewmodel.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/fy_date_time_field.widget.dart';

class WriteResignRequestView extends StatelessWidget {
  static String tag = 'write-resign-request-view';

  const WriteResignRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<ResignViewModel>(
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Resign Letter'),
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
                      title: 'Date',
                      value: model.resignDate,
                      onChanged: (value) => model.resignDate = value,
                    ),
                    const SizedBox(height: 16),
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
                        onChanged: (value) {
                          final modifiedValue = value
                              .replaceAll(' ', '\t')
                              .replaceAll('\n', '\n');
                          model.resignLetterController.text = modifiedValue;
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Feedback',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Feedback';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          model.resignFeedbackController.text = value,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (model.formKey.currentState?.validate() ?? false) {
                          model.onSubmitResignData();
                        }
                      },
                      child: const Text('Submit Resignation'),
                    ),
                    const SizedBox(height: 20),
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
