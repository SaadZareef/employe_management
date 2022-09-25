import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice/Services/auth.dart';
import 'package:practice/constants/mediaquery.dart';
import 'package:practice/widgets/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  Function toggleView;
  LoginPage({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  String error = '';
  String email = '';
  String password = '';
  bool loading = false;
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo,
              toolbarHeight: context.portrait ? 300.h : 390.h,
              centerTitle: true,
              title: Text(
                'Login to \nEmployee Management',
                textAlign: TextAlign.center,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding: context.portrait
                      ? EdgeInsets.only(left: 60.w, right: 60.w, top: 80.h)
                      : EdgeInsets.only(left: 100.w, right: 100.w, top: 80.h),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Image(
                          height: context.portrait ? 700.h : 1600.h,
                          image: AssetImage('assets/images/welcome1.png'),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter an Email' : null,
                          onChanged: (value) => setState(() {
                            email = value;
                          }),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.indigo,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(color: Colors.indigo),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.r),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90.h,
                        ),
                        TextFormField(
                          validator: (value) => value!.length < 8
                              ? 'Password should be atleast 8 characters.'
                              : null,
                          onChanged: (value) => setState(() {
                            password = value;
                          }),
                          obscureText: active ? false : true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.indigo,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() {
                                active = !active;
                              }),
                              icon: Icon(Icons.remove_red_eye),
                              color: active ? Colors.indigo : Colors.grey,
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(color: Colors.indigo),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(60.r),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 180.h,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = "Email and Password don't match.";
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              fixedSize: Size(950.w, 170.h),
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(13))),
                          child: Text('Login'),
                        ),
                        SizedBox(
                            height: 360.h,
                            child: Divider(
                              thickness: 3,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have any account yet!",
                              style: TextStyle(color: Colors.indigo),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.toggleView();
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
  }
}
