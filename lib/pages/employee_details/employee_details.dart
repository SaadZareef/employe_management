import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:practice/model/employee_data.dart';

class EmployeeDetails extends StatefulWidget {
  Employee employee;
  EmployeeDetails({required this.employee});
  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Employee Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 212, 212, 212),
          height: 650,
          child: Column(
            children: [
              Container(
                height: 230,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.employee.image),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              details('Name:', widget.employee.name),
              details('Profession:', widget.employee.profession),
              details('Salary:', '\$${widget.employee.salary}'),
              details('Gender:', widget.employee.gender),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  lorem(paragraphs: 1, words: 30),
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 97, 97, 97),
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget details(String detailType, String detail) {
  return Container(
    padding: EdgeInsets.all(10),
    width: 180,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          detailType,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          detail,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    ),
  );
}
