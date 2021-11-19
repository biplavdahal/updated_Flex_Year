import 'package:dio/dio.dart';

String apiError(Object e) {
  if (e is DioError) {
    if (e.response != null) {
      if (e.response!.data is Map<String, dynamic>) {
        return e.response!.data['response'];
      }
    }
  } else if (e is String) {
    return e;
  }

  return "Something unexpected occured!";
}
