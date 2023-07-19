import 'package:crypto_polygon/src/features/search_screen/data/dto/crypto_data.dart';
import 'package:flutter/material.dart';

import 'helper_high_closed.dart';

class GraphInfoWidget extends StatelessWidget {
  final CryptoData cryptodata;
  const GraphInfoWidget({
    super.key,
    required this.cryptodata
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: HighLowOpenClosed(
                      title: "HIGH:",
                      value: "${cryptodata.high}",
                    )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: HighLowOpenClosed(
                      title: "OPEN:",
                      value: "${cryptodata.open}",
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: HighLowOpenClosed(
                      title: "LOW:",
                      value: "${cryptodata.low}",
                    )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: HighLowOpenClosed(
                      title: "CLOSE:",
                      value: "${cryptodata.close}",
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}