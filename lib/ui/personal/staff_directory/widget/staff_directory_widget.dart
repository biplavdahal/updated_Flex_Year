import 'dart:convert';
import 'dart:typed_data';
import 'package:flex_year_tablet/data_models/department_list.data.dart';
import 'package:flutter/material.dart';
import '../../../../theme.dart';

class StaffDirectoryItem extends StatelessWidget {
  final DepartmentListdata directory;
  final VoidCallback onClick;
  const StaffDirectoryItem(
      {Key? key, required this.directory, required this.onClick})
      : super(key: key);

  Uint8List decodeBase64Image(String base64String) {
    const dataPrefix = 'base64,';
    final base64 = base64String.split(dataPrefix).last;
    return base64Decode(base64);
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes;
    if (directory.icon != null) {
      final base64Image = directory.icon!
          .replaceAll(RegExp(r'^<imgsrc=\"data:image/png;base64,'), '')
          .replaceAll('\">', '');

      // Decode Base64 image data
      imageBytes = decodeBase64Image(base64Image);
    }

    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Image.memory(
                      imageBytes as Uint8List,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      directory.departmentName.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: AppColor.primary),
                    ),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    directory.description != null
                        ? directory.description.toString()
                        : '-----',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: 70,
                height: 80,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: onClick,
                  child: const Icon(
                    Icons.arrow_forward_sharp,
                    size: 17,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
