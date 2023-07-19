import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_styles.dart';
import '../view_model/search_view_model.dart';

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({
    super.key,
    required this.vm,
  });

  final SearchViewModel vm;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Text(
        'Отмена',
        style: AppStyles.s16w600.copyWith(
            color: vm.isTyped() ? AppColors.defaultGreen : AppColors.textBlack),
      ),
    );
  }
}
