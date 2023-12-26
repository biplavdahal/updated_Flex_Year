import 'package:flex_year_tablet/data_models/user_resign.data.dart';

abstract class ExitProcess {
  //Get resignation letter
  Future<List<ResignData>> getResignData();

  //create resign letter
  Future<void> createResignRequest(Map<String, dynamic> resignData);
}
