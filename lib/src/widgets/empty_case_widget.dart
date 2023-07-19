import 'package:flutter/material.dart';

class EmptyCaseWidget extends StatelessWidget {
  const EmptyCaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Пусто'),
    );
  }
}
