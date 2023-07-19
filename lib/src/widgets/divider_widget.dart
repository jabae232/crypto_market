import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }
}
