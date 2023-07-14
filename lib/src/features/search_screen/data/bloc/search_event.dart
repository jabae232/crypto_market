part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchForCryptoEvent extends SearchEvent {
  final String query;
  SearchForCryptoEvent({required this.query});
}
