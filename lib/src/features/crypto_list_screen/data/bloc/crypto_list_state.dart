part of 'crypto_list_bloc.dart';

abstract class CryptoListState {}

class CryptoListInitial extends CryptoListState {}

class CryptoListLoadingState extends CryptoListState {}

class CryptoListLoadedState extends CryptoListState {
  final DailyBars cryptosUpToDate;
  final DailyBars cryptosDateBefore;
  CryptoListLoadedState({required this.cryptosUpToDate,required this.cryptosDateBefore});
}

class CryptoListErrorState extends CryptoListState {
  final String message;
  CryptoListErrorState({
    required this.message
});
}
