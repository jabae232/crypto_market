import 'package:flutter/material.dart';

import '../../../../../constants/app_styles.dart';

class HighLowOpenClosed extends StatelessWidget {
  final String title;
  final String value;
  const HighLowOpenClosed({Key? key, required this.value, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppStyles.s14w400,
          ),
        ),
        Text(
          value,
          style: AppStyles.s14w600,
        ),
      ],
    );
  }
}
