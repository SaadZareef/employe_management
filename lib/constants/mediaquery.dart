import 'package:flutter/cupertino.dart';

extension MediaQueryValues on BuildContext {
  bool get portrait => MediaQuery.of(this).orientation == Orientation.portrait;
}
