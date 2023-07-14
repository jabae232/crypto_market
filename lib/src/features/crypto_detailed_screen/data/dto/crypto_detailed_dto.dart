// To parse this JSON data, do
//
//     final cryptoDetailedDto = cryptoDetailedDtoFromJson(jsonString);

import 'dart:convert';

CryptoDetailedDto cryptoDetailedDtoFromJson(String str) => CryptoDetailedDto.fromJson(json.decode(str));

class CryptoDetailedDto {
  final String ticker;
  final int queryCount;
  final int resultsCount;
  final bool adjusted;
  final List<Result> results;
  final String status;
  final String requestId;
  final int count;

  CryptoDetailedDto({
    required this.ticker,
    required this.queryCount,
    required this.resultsCount,
    required this.adjusted,
    required this.results,
    required this.status,
    required this.requestId,
    required this.count,
  });

  factory CryptoDetailedDto.fromJson(Map<String, dynamic> json) => CryptoDetailedDto(
    ticker: json["ticker"],
    queryCount: json["queryCount"],
    resultsCount: json["resultsCount"],
    adjusted: json["adjusted"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
    requestId: json["request_id"],
    count: json["count"],
  );
}

class Result {
  final double v;
  final double vw;
  final double o;
  final double c;
  final double h;
  final double l;
  final DateTime t;
  final int n;

  Result({
    required this.v,
    required this.vw,
    required this.o,
    required this.c,
    required this.h,
    required this.l,
    required this.t,
    required this.n,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    v: json["v"]?.toDouble(),
    vw: json["vw"]?.toDouble(),
    o: json["o"]?.toDouble(),
    c: json["c"]?.toDouble(),
    h: json["h"]?.toDouble(),
    l: json["l"]?.toDouble(),
    t: DateTime.fromMillisecondsSinceEpoch(json["t"]),
    n: json["n"],
  );

}
