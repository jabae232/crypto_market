part of 'crypto_detailed_bloc.dart';

abstract class CryptoDetailedState {}

class CryptoDetailedInitial extends CryptoDetailedState {}

class CryptoDetailedLoadingState extends CryptoDetailedState {}

class CryptoDetailedLoadedState extends CryptoDetailedState {
  final CryptoDetailedDto cryptos;
  CryptoDetailedLoadedState({required this.cryptos});
}

class CryptoDetailedErrorState extends CryptoDetailedState {
  final String error;
  CryptoDetailedErrorState({required this.error});
}
