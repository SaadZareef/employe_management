import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice/Services/firestore.dart';
import 'package:practice/constants/mediaquery.dart';

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
    return ElevatedButton(
      onPressed: () async {
        DatabaseService().creatUser(
            widget.username.text,
            widget.profession.text,
            widget.salary.text,
            widget.gender,
            await widget.downloadFileURL());
        Navigator.pop(context);
        widget.uploadFile();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        fixedSize: Size(900.w, 180.h),
        shape: BeveledRectangleBorder(
            borderRadius:
                BorderRadius.circular(context.portrait ? 60.r : 100.r)),
      ),
      child: Text('Add Employee',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}
