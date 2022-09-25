import 'package:flutter/material.dart';
import 'package:practice/model/user_data.dart';
import 'package:practice/pages/authenticate/authenticate.dart';
import 'package:practice/pages/home/home_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
