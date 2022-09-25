import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practice/widgets/button.dart';
import 'package:practice/widgets/textfield.dart';

class NewEmployee extends StatefulWidget {
  NewEmployee({
    Key? key,
  }) : super(key: key);
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
      print(image.runtimeType);
      print(image.name);
      print(image.path);
      print(image);
      setState(() {
        _imagePath = image.path;
        _imageName = image.name;
      });
      print(_imageName);
      print(_imagePath);
    } on PlatformException catch (e) {
      print('Failed to pick image');
    }
  }

  Future uploadFile() async {
    File file = File(_imagePath);
    final ref =
        await FirebaseStorage.instance.ref('files/$_imageName').putFile(file);
    print('Upload file:  $ref');
  }

  Future<String> downloadFileURL() async {
    Reference reference = FirebaseStorage.instance.ref('files/$_imageName');
    final TaskSnapshot snapshot = await reference.putFile(File(_imagePath));
    final downloadURL = await snapshot.ref.getDownloadURL();
    // final downloadURL =
    // await FirebaseStorage.instance
    //     .ref('files/$_imageName')
    //     .getDownloadURL();
    // await FirebaseStorage.instance
    // .ref('files/$_imageName')
    // .putFile(File(_imagePath));

    print('Download file:   $downloadURL');
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
      body: Container(
        color: Color.fromARGB(255, 224, 224, 224),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/employee.png')),
            SizedBox(
              child: Divider(
                color: Colors.indigo,
                thickness: 2,
              ),
              height: 30,
            ),
            TextFields(
              field: 'Employee Name',
              ctrl: username,
              type: TextInputType.name,
              icon: Icons.person,
              obscure: false,
            ),
            SizedBox(
              height: 20,
            ),
            TextFields(
              field: 'Employee Profession',
              ctrl: profession,
              type: TextInputType.name,
              icon: Icons.work,
              obscure: false,
            ),
            SizedBox(
              height: 20,
            ),
            TextFields(
              field: 'Employee Salary',
              ctrl: salary,
              type: TextInputType.number,
              icon: Icons.attach_money,
              obscure: false,
            ),
            SizedBox(
              height: 10,
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
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 90,
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
                  width: 10,
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
              height: 29,
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
                      fixedSize: Size(200, 30),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Add Employee',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
