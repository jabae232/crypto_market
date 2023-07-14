import 'dart:convert';
import '../../../../../api/api.dart';
import '../dto/daily_bars_dto.dart';

class RepoCryptoList {
  final Api api;
  RepoCryptoList({required this.api});
  Future<DailyBars> fetch(String date) async {
      final result = await api.dio.get(
        '/v2/aggs/grouped/locale/global/market/crypto/$date',
      );
     final cryptos = dailyBarsFromJson(json.encode(result.data));
    return cryptos;
  }
}
