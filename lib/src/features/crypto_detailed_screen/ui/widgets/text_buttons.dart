import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_styles.dart';

class TextButtons extends StatelessWidget {
  final Function func;
  final String date;
  final bool isSelected;
  const TextButtons(
      {Key? key,
      required this.func,
      required this.date,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                isSelected ? AppColors.chartGreen : Colors.transparent),
        onPressed: () => func.call(),
        child: Text(
          date,
          style: AppStyles.s10w600
              .copyWith(color: isSelected ? Colors.white : AppColors.textBlack),
        ));
  }
}
