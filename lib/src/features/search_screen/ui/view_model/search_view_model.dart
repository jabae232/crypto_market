

import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  String? _controller;
  final _textController = TextEditingController();
  bool isTyped(){
    if(controller.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  String get controller => _controller ?? '';

  TextEditingController get textController => _textController;


  set controller(String value) {
    _controller = value;
    notifyListeners();
  }

}