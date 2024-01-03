import 'package:flex_year_tablet/data_models/user_exit_survey.data.dart';
import 'package:flutter/material.dart';

class SurveyItem extends StatefulWidget {
  final ExitSurveyData survey;
  final int index;

  const SurveyItem({
    Key? key,
    required this.survey,
    required this.index,
  }) : super(key: key);

  @override
  State<SurveyItem> createState() => _SurveyItemState();
}

bool isChecked = false;
String selectedOption = '';

class _SurveyItemState extends State<SurveyItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text((widget.index + 1).toString() + '.  '),
            Expanded(
              child: Text(
                widget.survey.question.toString(),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Checkbox(
              value:
                  selectedOption.contains(widget.survey.optionOne.toString()),
              onChanged: (bool? value) {
                handleCheckboxChange(widget.survey.optionOne.toString());
              },
            ),
            Text(widget.survey.optionOne.toString()),
            const SizedBox(width: 20),
            Checkbox(
              value:
                  selectedOption.contains(widget.survey.optionTwo.toString()),
              onChanged: (bool? value) {
                handleCheckboxChange(widget.survey.optionTwo.toString());
              },
            ),
            Text(widget.survey.optionTwo.toString()),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Checkbox(
              value:
                  selectedOption.contains(widget.survey.optionThree.toString()),
              onChanged: (bool? value) {
                handleCheckboxChange(widget.survey.optionThree.toString());
              },
            ),
            Text(widget.survey.optionThree.toString()),
            const SizedBox(width: 20),
            Checkbox(
              value:
                  selectedOption.contains(widget.survey.optionFour.toString()),
              onChanged: (bool? value) {
                handleCheckboxChange(widget.survey.optionFour.toString());
              },
            ),
            Text(widget.survey.optionFour.toString()),
          ],
        ),
      ],
    );
  }

  void handleCheckboxChange(String option) {
    setState(() {
      if (selectedOption == option) {
        selectedOption = '';
      } else {
        selectedOption = option;
      }
    });
  }
}
