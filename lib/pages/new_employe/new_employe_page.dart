import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/constants/mediaquery.dart';
import 'package:practice/widgets/button.dart';
import 'package:practice/widgets/textfield.dart';

class NewEmployee extends StatefulWidget {
  @override
  State<NewEmployee> createState() => _NewEmployeeState();
}

class _NewEmployeeState extends State<NewEmployee> {
  TextEditingController username = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController salary = TextEditingController();
  String gender = '';
  bool bt1 = false;
  bool bt2 = false;
  List<bool> activebtn(bool bool) {
    if (bool == true) {
      return [bt1 = !bt1, bt2 = false];
    } else {
      return [bt1 = false, bt2 = !bt2];
    }
  }

  var _imagePath;
  var _imageName;
  final imagePicker = ImagePicker();
  Future getImage() async {
    try {
      final image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image == null) {
        print('image null');
        return;
      }
      setState(() {
        _imagePath = image.path;
        _imageName = image.name;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }

  Future uploadFile() async {
    File file = File(_imagePath);
    final ref =
        await FirebaseStorage.instance.ref('files/$_imageName').putFile(file);
  }

  Future<String> downloadFileURL() async {
    Reference reference = FirebaseStorage.instance.ref('files/$_imageName');
    final TaskSnapshot snapshot = await reference.putFile(File(_imagePath));
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Employee.'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: context.portrait ? 2700.h : 4400.h,
          color: Color.fromARGB(255, 224, 224, 224),
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/employee.png')),
              SizedBox(
                child: Divider(
                  color: Colors.indigo,
                  thickness: 2,
                ),
                height: 160.h,
              ),
              TextFields(
                field: 'Employee Name',
                ctrl: username,
                type: TextInputType.name,
                icon: Icons.person,
                obscure: false,
              ),
              SizedBox(
                height: 80.h,
              ),
              TextFields(
                field: 'Employee Profession',
                ctrl: profession,
                type: TextInputType.name,
                icon: Icons.work,
                obscure: false,
              ),
              SizedBox(
                height: 80.h,
              ),
              TextFields(
                field: 'Employee Salary',
                ctrl: salary,
                type: TextInputType.number,
                icon: Icons.attach_money,
                obscure: false,
              ),
              SizedBox(
                height: context.portrait ? 30.h : 10.h,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      getImage();
                    },
                    icon: Icon(
                      Icons.camera,
                      color: Colors.indigo,
                      size: context.portrait ? 140.sp : 80.sp,
                    ),
                  ),
                  SizedBox(
                    width: context.portrait ? 370.w : 700.w,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        activebtn(true);
                        gender = 'Male';
                      });
                    },
                    child: Text('Male'),
                    style: ButtonStyle(
                        backgroundColor: bt1
                            ? MaterialStateProperty.all(Colors.indigo)
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor: bt1
                            ? MaterialStateProperty.all(Colors.white)
                            : MaterialStateProperty.all(Colors.indigo)),
                  ),
                  SizedBox(
                    width: 70.w,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        activebtn(false);
                        gender = 'Female';
                      });
                    },
                    child: Text('Female'),
                    style: ButtonStyle(
                        backgroundColor: bt2
                            ? MaterialStateProperty.all(Colors.indigo)
                            : MaterialStateProperty.all(Colors.white),
                        foregroundColor: bt2
                            ? MaterialStateProperty.all(Colors.white)
                            : MaterialStateProperty.all(Colors.indigo)),
                  ),
                ],
              ),
              SizedBox(
                height: 120.h,
              ),
              username != '' && profession != '' && salary != '' && gender != ''
                  ? Button(
                      downloadFileURL: downloadFileURL,
                      uploadFile: uploadFile,
                      btn: 'Add Employee',
                      username: username,
                      profession: profession,
                      salary: salary,
                      gender: gender,
                    )
                  : ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        fixedSize: Size(900.w, 170.h),
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                context.portrait ? 60.r : 100.r)),
                      ),
                      child: Text(
                        'Add Employee',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
