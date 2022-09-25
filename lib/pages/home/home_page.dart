import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice/Services/auth.dart';
import 'package:practice/constants/mediaquery.dart';
import 'package:practice/model/employee_data.dart';
import 'package:practice/pages/new_employe/new_employe_page.dart';
import 'package:practice/widgets/employee_list.dart';
import 'package:provider/provider.dart';
import '../../model/user_data.dart';

class Home extends StatefulWidget with ChangeNotifier {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _auth = AuthService();

  // Fucntion to read data from firebase

  Stream<List<Employee>> readEmployee() => FirebaseFirestore.instance
      .collection('employee')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => Employee.fromJson(doc.data())).toList());

  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text('Employees'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: context.portrait ? 110.sp : 60.sp,
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Employee>>(
        stream: readEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot);
            return Text('Something Went Wrong');
          } else if (snapshot.hasData) {
            final employees = snapshot.data;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: ListView(
                children: employees!
                    .map((employe) => buildEmploye(
                          employee: employe,
                        ))
                    .toList(),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          fixedSize:
              context.portrait ? Size(1000.w, 150.h) : Size(700.w, 150.h),
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (user!.uid == 'lHMMUgPNJXWhrq6dw60HQH7cGc53') {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (_) => NewEmployee(),
              ),
            )
                .then((value) {
              setState(() {});
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  actionsPadding: EdgeInsets.zero,
                  content: Text(
                    'You are loged from a local account.\nOnly admin can make changes.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Text('New Employee'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
