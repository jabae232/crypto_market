// To parse this JSON data, do
//
//     final dailyCryptoDto = dailyCryptoDtoFromJson(jsonString);

import 'dart:convert';

DailyCryptoDto dailyCryptoDtoFromJson(String str) => DailyCryptoDto.fromJson(json.decode(str));

String dailyCryptoDtoToJson(DailyCryptoDto data) => json.encode(data.toJson());

class DailyCryptoDto {
  String status;
  DateTime from;
  String symbol;
  double open;
  double high;
  double low;
  double close;
  double volume;
  double afterHours;
  double preMarket;

  DailyCryptoDto({
    required this.status,
    required this.from,
    required this.symbol,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.afterHours,
    required this.preMarket,
  });

  factory DailyCryptoDto.fromJson(Map<String, dynamic> json) => DailyCryptoDto(
    status: json["status"],
    from: DateTime.parse(json["from"]),
    symbol: json["symbol"],
    open: json["open"]?.toDouble(),
    high: json["high"]?.toDouble(),
    low: json["low"]?.toDouble(),
    close: json["close"]?.toDouble(),
    volume: json["volume"]?.toDouble(),
    afterHours: json["afterHours"]?.toDouble(),
    preMarket: json["preMarket"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "from": "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
    "symbol": symbol,
    "open": open,
    "high": high,
    "low": low,
    "close": close,
    "volume": volume,
    "afterHours": afterHours,
    "preMarket": preMarket,
  };
}
