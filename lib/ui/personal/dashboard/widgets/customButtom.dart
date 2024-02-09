import 'package:flutter/material.dart';

class AttendanceButtonWithDropdown extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> dropdownItems;
  final ValueChanged<String?> onPressed;

  const AttendanceButtonWithDropdown({
    required this.title,
    required this.icon,
    required this.color,
    required this.dropdownItems,
    required this.onPressed,
  });

  @override
  _AttendanceButtonWithDropdownState createState() =>
      _AttendanceButtonWithDropdownState();
}

class _AttendanceButtonWithDropdownState
    extends State<AttendanceButtonWithDropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: widget.onPressed != null ? () {} : null,
          icon: Icon(widget.icon),
          label: Text(widget.title),
          style: ElevatedButton.styleFrom(
            primary: widget.color,
          ),
        ),
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return widget.dropdownItems
                .map((String item) => PopupMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList();
          },
          onSelected: (String value) {
            setState(() {
              _selectedItem = value;
              widget.onPressed(value);
            });
          },
        ),
      ],
    );
  }
}
