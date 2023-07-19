part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoadingState extends SearchState {}
class SearchLoadedState extends SearchState {
  final SearchCryptoDto results;
  SearchLoadedState({
    required this.results
});
}
class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState({
    required this.message
});
}
