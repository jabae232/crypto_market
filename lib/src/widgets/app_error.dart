import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  const AppErrorWidget({
    Key? key,
    required this.message,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(message),
        ElevatedButton(onPressed: onTap, child: const Text('Try again'))
      ],
    );
  }
}