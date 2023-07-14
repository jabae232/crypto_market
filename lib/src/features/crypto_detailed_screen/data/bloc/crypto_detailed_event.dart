part of 'crypto_detailed_bloc.dart';

abstract class CryptoDetailedEvent {}

class GetDetailsEvent extends CryptoDetailedEvent {
  final String dateFrom;
  final String dateTo;
  final String timespan;
  final String ticker;
  GetDetailsEvent(
      {required this.dateFrom,
      required this.dateTo,
      required this.timespan,
      required this.ticker});
}
