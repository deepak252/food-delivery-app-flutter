import 'package:flutter/material.dart';

class FieldValueWidget extends StatelessWidget {
  final String field;
  final String value;
  final bool bold;
  const FieldValueWidget({
    required this.field,
    required this.value,
    this.bold=false,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            field,
            style: TextStyle(
              fontWeight: bold? FontWeight.bold : null
            ),
          ),
        ),
        SizedBox(width: 8,),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold? FontWeight.bold : null
          ),
        ),
      ],
    );
  }
}