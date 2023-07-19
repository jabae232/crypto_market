import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/app_assets.dart';
import '../../../search_screen/ui/search_screen.dart';

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SearchScreen())),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SvgPicture.asset(
          AppAssets.svg.magnGlass,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}