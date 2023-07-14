// To parse this JSON data, do
//
//     final dailyBars = dailyBarsFromJson(jsonString);

import 'dart:convert';

DailyBars dailyBarsFromJson(String str) => DailyBars.fromJson(json.decode(str));

class DailyBars {
  int queryCount;
  int resultsCount;
  bool adjusted;
  List<Result> results;
  String status;
  String requestId;
  int count;
  DailyBars({
    required this.queryCount,
    required this.resultsCount,
    required this.adjusted,
    required this.results,
    required this.status,
    required this.requestId,
    required this.count,
  });

  factory DailyBars.fromJson(Map<String, dynamic> json) => DailyBars(
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
  String t;
  double? prevPrice;
  double? differ;
  double v;
  double? vw;
  double o;
  double c;
  double h;
  double l;
  int resultT;
  int n;

  Result({
    required this.t,
    required this.v,
    this.prevPrice,
    this.vw,
    required this.o,
    required this.c,
    required this.h,
    required this.l,
    required this.resultT,
    required this.n,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    t: json["T"],
    v: json["v"]?.toDouble(),
    vw: json["vw"]?.toDouble(),
    o: json["o"]?.toDouble(),
    c: json["c"]?.toDouble(),
    h: json["h"]?.toDouble(),
    l: json["l"]?.toDouble(),
    resultT: json["t"],
    n: json["n"],
  );
}
