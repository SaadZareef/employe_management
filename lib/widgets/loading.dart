import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 211, 211, 211),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.indigo,
          size: 50,
        ),
      ),
    );
  }
}
