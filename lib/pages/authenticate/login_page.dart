import 'package:flutter/material.dart';
import 'package:practice/Services/auth.dart';
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
              toolbarHeight: 70,
              centerTitle: true,
              title: Text(
                'Login to \nEmployee Management',
                textAlign: TextAlign.center,
              ),
            ),
            body: Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Image(
                        height: 150,
                        image: AssetImage('assets/images/welcome1.png'),
                      ),
                      SizedBox(
                        height: 10,
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
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
                            fixedSize: Size(250, 45),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(13))),
                        child: Text('Login'),
                      ),
                      SizedBox(
                          height: 80,
                          child: Divider(
                            thickness: 2,
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
          );
  }
}
