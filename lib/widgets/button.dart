import 'package:flutter/material.dart';
import 'package:practice/Services/firestore.dart';
import 'package:practice/model/employee_data.dart';
import 'package:practice/pages/new_employe/new_employe_page.dart';

String url2 = '';

class Button extends StatefulWidget {
  String btn;
  TextEditingController username;
  TextEditingController profession;
  TextEditingController salary;
  String gender;
  Function uploadFile;
  Function downloadFileURL;
  Button({
    Key? key,
    required this.uploadFile,
    required this.downloadFileURL,
    required this.btn,
    required this.username,
    required this.profession,
    required this.salary,
    required this.gender,
  }) : super(key: key);
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    String url1;
    return ElevatedButton(
      onPressed: () async {
        DatabaseService().creatUser(widget.username.text,
            widget.profession.text, widget.salary.text, widget.gender);
        Navigator.pop(context);
        widget.uploadFile();
        url1 = await widget.downloadFileURL();
        url2 = url1;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        fixedSize: Size(200, 30),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text('Add Employee',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}
