import 'package:bestfriend/bestfriend.dart';

class StaffDirectoryArgument extends Arguments {
  final Map<String, dynamic> searchParams;
  final int departID;

  StaffDirectoryArgument({required this.searchParams, required this.departID});
}
