part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchForCryptoEvent extends SearchEvent {
  final String query;
  SearchForCryptoEvent({required this.query});
}
