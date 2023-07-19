import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../constants/app_assets.dart';
import '../../../../../constants/app_colors.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SvgPicture.asset(AppAssets.svg.arrowBack,color: AppColors.defaultBlack,),
      ),
    );
  }
}
