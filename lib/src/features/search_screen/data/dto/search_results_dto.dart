// To parse this JSON data, do
//
//     final searchCryptoDto = searchCryptoDtoFromJson(jsonString);

import 'dart:convert';

SearchCryptoDto searchCryptoDtoFromJson(String str) => SearchCryptoDto.fromJson(json.decode(str));

String searchCryptoDtoToJson(SearchCryptoDto data) => json.encode(data.toJson());

class SearchCryptoDto {
  final List<Result> results;
  final String status;
  final String requestId;
  final int? count;
  final String? nextUrl;

  SearchCryptoDto({
    required this.results,
    required this.status,
    required this.requestId,
    required this.count,
    required this.nextUrl,
  });

  factory SearchCryptoDto.fromJson(Map<String, dynamic> json) => SearchCryptoDto(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
    requestId: json["request_id"],
    count: json["count"],
    nextUrl: json["next_url"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status,
    "request_id": requestId,
    "count": count,
    "next_url": nextUrl,
  };
}

class Result {
  final String ticker;
  final String name;
  final String market;
  final String locale;
  final String? primaryExchange;
  final String? type;
  final bool active;
  final String currencyName;
  final String? cik;
  final String? compositeFigi;
  final String? shareClassFigi;
  final String? lastUpdatedUtc;

  Result({
    required this.ticker,
    required this.name,
    required this.market,
    required this.locale,
    this.primaryExchange,
    required this.type,
    required this.active,
    required this.currencyName,
    this.cik,
    this.compositeFigi,
    this.shareClassFigi,
    required this.lastUpdatedUtc,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    ticker: json["ticker"],
    name: json["name"],
    market: json["market"] ?? '',
    locale: json["locale"] ?? '',
    primaryExchange: json["primary_exchange"] ?? '',
    type: json["type"] ?? '',
    active: json["active"],
    currencyName: json["currency_name"] ?? '',
    cik: json["cik"],
    compositeFigi: json["composite_figi"],
    shareClassFigi: json["share_class_figi"],
    lastUpdatedUtc: json["last_updated_utc"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "ticker": ticker,
    "name": name,
    "market": market,
    "locale": locale,
    "primary_exchange": primaryExchange,
    "type": type,
    "active": active,
    "currency_name": currencyName,
    "cik": cik,
    "composite_figi": compositeFigi,
    "share_class_figi": shareClassFigi,
    "last_updated_utc": lastUpdatedUtc,
  };
}




