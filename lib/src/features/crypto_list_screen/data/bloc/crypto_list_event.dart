part of 'crypto_list_bloc.dart';

abstract class CryptoListEvent {}
class GetCryptosEvent extends CryptoListEvent {
  final String upToDate;
  final String dateBefore;
  GetCryptosEvent({
    required this.dateBefore,
    required this.upToDate,
});
}