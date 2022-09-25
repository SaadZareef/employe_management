import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:practice/Services/auth.dart';
import 'package:practice/model/user_data.dart';
import 'package:practice/pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: ScreenUtilInit(
        designSize: Size(1440, 3040),
        builder: (context, child) => MaterialApp(
          home: Wrapper(),
        ),
      ),
    );
  }
}
