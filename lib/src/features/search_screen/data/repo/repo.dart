

import 'dart:convert';

import '../../../../../api/api.dart';
import '../dto/search_results_dto.dart';

class RepoSearch {
  final Api api;
  RepoSearch({
    required this.api
});
  Future<SearchCryptoDto> fetch(String query) async {
    final result = await api.dio.get(
      '/v3/reference/tickers?search=$query',
    );
    final cryptos = searchCryptoDtoFromJson(json.encode(result.data));
    return cryptos;
  }
}