import 'package:flutter/cupertino.dart';

class NavigateProvider with ChangeNotifier {
  int pageIdx = 0;
  final controller = PageController(initialPage: 0);
}
