import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/model/employee_data.dart';
import 'package:practice/model/user_data.dart';
import 'package:practice/pages/home/home_page.dart';
import 'package:practice/pages/new_employe/new_employe_page.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  Future creatUser(String name, String profession, String salary, String gender,
      String image) async {
    var data = FirebaseFirestore.instance.collection('employee').doc();
    var id;
    final employee = Employee(
        id: data.id,
        image: image,
        name: name,
        profession: profession,
        salary: salary,
        gender: gender);
    final json = employee.toJson();
    await data.set(json);
  }
}
