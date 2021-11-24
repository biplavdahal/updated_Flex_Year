import 'package:bestfriend/ui/view.dart';
import 'package:flex_year_tablet/data_models/leave_type.data.dart';
import 'package:flex_year_tablet/ui/create_leave_request/create_leave_request.model.dart';
import 'package:flex_year_tablet/widgets/fy_button.widget.dart';
import 'package:flex_year_tablet/widgets/fy_checkbox.widget.dart';
import 'package:flex_year_tablet/widgets/fy_date_time_field.widget.dart';
import 'package:flex_year_tablet/widgets/fy_dropdown.widget.dart';
import 'package:flex_year_tablet/widgets/fy_input_field.widget.dart';
import 'package:flutter/material.dart';

class CreateLeaveRequestView extends StatelessWidget {
  static String tag = 'create-leave-request-view';

  const CreateLeaveRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return View<CreateLeaveRequestModel>(
      onModelReady: (model) => model.init(),
      enableTouchRepeal: true,
      builder: (ctx, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Leave Request'),
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FYDropdown<LeaveTypeData>(
                      title: "Select leave type",
                      onChanged: model.onLeaveTypeChanged,
                      items: model.leaveTypes,
                      labels: model.leaveTypeLabels,
                      value: model.selectedLeaveTypeLabel!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FYDateField(
                      title: 'Leave date from',
                      value: model.leaveDateFrom,
                      onChanged: (value) => model.leaveDateFrom = value,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FYDateField(
                      title: 'Leave date upto',
                      value: model.leaveDateUpto,
                      onChanged: (value) => model.leaveDateUpto = value,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FYCheckbox(
                      value: model.isHalfDayLeave,
                      onChanged: (value) => model.isHalfDayLeave = value!,
                      label: "Do you need half leave?",
                    ),
                    if (model.isHalfDayLeave) ...[
                      const SizedBox(
                        height: 16,
                      ),
                      FYTimeField(
                        title: 'Leave time from',
                        value: model.leaveTimeFrom,
                        onChanged: (value) => model.leaveTimeFrom = value,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FYTimeField(
                        title: 'Leave time upto',
                        value: model.leaveTimeUpto,
                        onChanged: (value) => model.leaveTimeUpto = value,
                      ),
                    ],
                    const SizedBox(
                      height: 16,
                    ),
                    FYInputField(
                      label: "Leave description",
                      controller: model.leaveDescriptionController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FYPrimaryButton(
                      label: "Submit request",
                      onPressed: model.onSubmitRequestPressed,
                    ),
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
