import 'package:flutter/material.dart';
import 'package:practice/model/employee_data.dart';
import 'package:practice/pages/employee_details/employee_details.dart';

class buildEmploye extends StatelessWidget {
  Employee employee;
  buildEmploye({required this.employee});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => EmployeeDetails(
                    employee: employee,
                  ))),
      child: Container(
        height: 65,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 4,
              color: Color.fromARGB(255, 146, 159, 233),
              offset: Offset(1.8, 1.8),
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
              backgroundImage: NetworkImage(employee.image),
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
      ),
    );
  }
}
