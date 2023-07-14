import 'package:crypto_polygon/constants/app_styles.dart';
import 'package:crypto_polygon/src/features/crypto_detailed_screen/ui/crypto_detailed_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';

class OneTile extends StatelessWidget {
  final String name;
  final double priceToDay;
  final double priceBefore;
  const OneTile(
      {Key? key,
      required this.name,
      required this.priceToDay,
      required this.priceBefore})
      : super(key: key);
  String nameFormatter(String a) {
    var b = a.split(':');
    var from = b[1].substring(0, b[1].length - 3);
    var to = b[1].substring(b[1].length - 3, b[1].length);
    return '$from / $to';
  }

  String computeGrows(double before, double today) {
    if (today > before) {
      return '+${((today - before) / today * 100).toStringAsFixed(2)}%/+${(today - before).toStringAsFixed(3)}';
    } else if (today < before) {
      return '${((today - before) / today * 100).toStringAsFixed(2)}%/${(today - before).toStringAsFixed(3)}';
    }
    return '~0%/~0.00';
  }

  @override
  Widget build(BuildContext context) {
    final compuite = computeGrows(priceBefore, priceToDay).split('/');
    final String percentage = compuite[0];
    final String number = compuite[1];
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CryptoDetailedScreen(
            ticker: name,
            tickerFormatted: nameFormatter(name),
            priceToDay: priceToDay.toString(),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Text(
              nameFormatter(name),
              style: AppStyles.s14w600,
            ),
            const Spacer(),
            Text(
              '$priceToDay',
              style: AppStyles.s14w600,
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  percentage,
                  style: AppStyles.s14w600.copyWith(
                      color: percentage.contains('-')
                          ? AppColors.defaultRed
                          : AppColors.defaultGreen),
                ),
                Text(
                  number,
                  style: AppStyles.s10w400,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
