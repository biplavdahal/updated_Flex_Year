import 'package:flex_year_tablet/data_models/user_cleareance_data.dart';
import 'package:flex_year_tablet/data_models/user_exit_survey.data.dart';
import 'package:flex_year_tablet/data_models/user_resign.data.dart';

abstract class ExitProcess {
  //Get resignation letter
  Future<List<ResignData>> getResignData();

  //create resign letter
  Future<void> createResignRequest(Map<String, dynamic> resignData);

  //Update resign letter
  Future<void> updateResignRequest(Map<String, dynamic> resignData);

  //search clearance
  Future<List<Clearancedata>> getClearanceDetail();

  //get question
  Future<List<ExitSurveyData>> getQuestions();
}
