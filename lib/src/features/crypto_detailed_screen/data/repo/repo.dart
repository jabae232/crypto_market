import 'dart:convert';
import 'package:crypto_polygon/src/features/crypto_detailed_screen/data/dto/crypto_detailed_dto.dart';
import '../../../../../api/api.dart';


class RepoCryptoDetailed {
  final Api api;
  RepoCryptoDetailed({
    required this.api
});
  Future<CryptoDetailedDto> fetch(String dateFrom,String dateTo, String timespan,String ticker) async {
    final result = await api.dio.get(
      '/v2/aggs/ticker/$ticker/range/1/$timespan/$dateFrom/$dateTo?adjusted=true&sort=asc&limit=120',
    );
    final cryptos = cryptoDetailedDtoFromJson(json.encode(result.data));
    return cryptos;
  }
}