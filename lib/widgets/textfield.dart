import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  String field;
  TextEditingController ctrl;
  TextInputType type;
  IconData icon;
  bool obscure;
  TextFields(
      {Key? key,
      required this.field,
      required this.ctrl,
      required this.type,
      required this.icon,
      required this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.indigo,
        ),
        label: Text(field),
        labelStyle: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
