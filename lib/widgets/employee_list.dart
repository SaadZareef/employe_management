import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:practice/model/employee_data.dart';
import 'package:practice/pages/new_employe/new_employe_page.dart';

Widget buildEmploye(Employee employee) {
  return Container(
    height: 65,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 1.5,
          color: Color.fromARGB(255, 146, 159, 233),
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: ListTile(
      textColor: Colors.indigo,
      leading: CircleAvatar(
        backgroundColor: Colors.indigo,
        radius: 27,
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.white,
          // backgroundImage: AssetImage('assets/images/employee.png'),
          // backgroundImage: NetworkImage(url(employee)),
        ),
      ),
      minLeadingWidth: 60,
      title: Text(
        'Name: ${employee.name}\n',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        'Profes: ${employee.profession}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      trailing: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Gender: ${employee.gender}\n\n',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            TextSpan(
                text: 'Salary: \$ ${employee.salary}',
                style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          ],
        ),
      ),
    ),
  );
}
