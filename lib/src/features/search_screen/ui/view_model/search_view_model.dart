

import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  String? _controller;
  bool isTyped(){
    if(controller.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  String get controller => _controller ?? '';

  set controller(String value) {
    _controller = value;
    notifyListeners();
  }

}