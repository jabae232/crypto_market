import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/app_assets.dart';
import '../../../../../constants/app_styles.dart';
import '../view_model/crypto_list_view_model.dart';

class HeaderListWidget extends StatelessWidget {
  const HeaderListWidget({
    super.key,
    required this.vm,
  });

  final CryptoViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.svg.ticker),
          const SizedBox(
            width: 3,
          ),
          const Text(
            'Тикер / Название',
            style: AppStyles.s10w400,
          ),
          const Expanded(child: SizedBox.shrink()),
          GestureDetector(
            onTap: () {
              vm.filterList(true);
            },
            child: const Text(
              'Цена',
              style: AppStyles.s10w400,
            ),
          ),
          SvgPicture.asset(AppAssets.svg.sort),
          const SizedBox(
            width: 24,
          ),
          GestureDetector(
            onTap: () {
              vm.filterList(false);
            },
            child: const Text(
              'Изм. % / \$',
              style: AppStyles.s10w400,
            ),
          ),
          SvgPicture.asset(AppAssets.svg.sort),
        ],
      ),
    );
  }
}