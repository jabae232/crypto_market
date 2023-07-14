import 'package:flutter/material.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_styles.dart';

class OneSearchTile extends StatefulWidget {
  final String cryptoName;
  final String query;
  final String companyName;
  const OneSearchTile(
      {Key? key,
      required this.companyName,
      required this.cryptoName,
      required this.query})
      : super(key: key);

  @override
  State<OneSearchTile> createState() => _OneSearchTileState();
}

class _OneSearchTileState extends State<OneSearchTile> {
  final List<int> indexInText = [];
  @override
  void initState() {
    indexOfPattern();
    super.initState();
  }

  void indexOfPattern() {
    if (widget.cryptoName.contains(widget.query)) {
      indexInText.addAll([
        widget.cryptoName.indexOf(widget.query),
        widget.cryptoName.indexOf(widget.query) + widget.query.length,
      ]);
    } else {
      indexInText.addAll([0, 0]);
    }
    if (widget.companyName.contains(widget.query)) {
      indexInText.addAll([
        widget.companyName.indexOf(widget.query),
        widget.companyName.indexOf(widget.query) + widget.query.length,
      ]);
    } else {
      indexInText.addAll([0, 0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: AppStyles.s16w600,
                children: <TextSpan>[
                  TextSpan(
                    text: widget.cryptoName.substring(
                      0,
                      indexInText[0],
                    ),
                  ),
                  TextSpan(
                    text: widget.cryptoName.substring(
                      indexInText[0],
                      indexInText[1],
                    ),
                    style: AppStyles.s16w600
                        .copyWith(color: AppColors.defaultGreen),
                  ),
                  TextSpan(
                    text: widget.cryptoName.substring(
                      indexInText[1],
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                  style: AppStyles.s10w400.copyWith(fontSize: 12),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.companyName.substring(0, indexInText[2]),
                    ),
                    TextSpan(
                      text: widget.companyName.substring(
                        indexInText[2],
                        indexInText[3],
                      ),
                      style: AppStyles.s10w400.copyWith(
                          color: AppColors.defaultGreen, fontSize: 12,fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: widget.companyName.substring(
                        indexInText[3],
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
