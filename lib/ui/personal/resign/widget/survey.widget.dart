import 'package:bestfriend/di.dart';
import 'package:flex_year_tablet/data_models/user_exit_survey.data.dart';
import 'package:flex_year_tablet/services/exit_process.service.dart';
import 'package:flex_year_tablet/theme.dart';
import 'package:flutter/material.dart';

class CustomSurveyDialog extends StatefulWidget {
  final List<ExitSurveyData> surveyQuestions;

  final VoidCallback onCancel;

  CustomSurveyDialog({
    required this.onCancel,
    required this.surveyQuestions,
  });

  @override
  _CustomSurveyDialogState createState() => _CustomSurveyDialogState();
}

class _CustomSurveyDialogState extends State<CustomSurveyDialog> {
  final ExitProcess _exitProcess = locator<ExitProcess>();
  int currentQuestionIndex = 0;
  List<String> selectedOptions = [];
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    ExitSurveyData currentQuestion =
        widget.surveyQuestions[currentQuestionIndex];

    return AlertDialog(
      title: const Text(
        'Survey Questions:',
        style: TextStyle(color: AppColor.primary),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(currentQuestion.question.toString()),
          Column(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: currentQuestion.optionOne!,
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      handleRadioChange(value!);
                    },
                  ),
                  Text(currentQuestion.optionOne!),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: currentQuestion.optionTwo!,
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      handleRadioChange(value!);
                    },
                  ),
                  Text(currentQuestion.optionTwo!),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: currentQuestion.optionThree!,
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      handleRadioChange(value!);
                    },
                  ),
                  Text(currentQuestion.optionThree!),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: currentQuestion.optionFour!,
                    groupValue: selectedOption,
                    onChanged: (String? value) {
                      handleRadioChange(value!);
                    },
                  ),
                  Text(currentQuestion.optionFour!),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
                onPressed: () {
                  if (currentQuestionIndex <
                      widget.surveyQuestions.length - 1) {
                    setState(() {
                      currentQuestionIndex++;
                      selectedOptions.clear();
                    });
                  }
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.yellow),
                ),
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
                onPressed: (selectedOption != null)
                    ? () {
                        onSubmit();

                        if (currentQuestionIndex <
                            widget.surveyQuestions.length - 1) {
                          setState(() {
                            currentQuestionIndex++;
                            selectedOptions.clear();
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      }
                    : null,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    if (selectedOption != null) {
      await _exitProcess.submitAnswer(
        option: selectedOption.toString(),
        question:
            widget.surveyQuestions[currentQuestionIndex].question.toString(),
        questioID:
            widget.surveyQuestions[currentQuestionIndex].questionId.toString(),
      );
    }
  }

  void handleCheckboxChange(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
      selectedOption = selectedOptions.isNotEmpty ? selectedOptions[0] : null;
    });
  }

  void handleRadioChange(String? value) {
    setState(() {
      selectedOption = value;
    });
  }
}
