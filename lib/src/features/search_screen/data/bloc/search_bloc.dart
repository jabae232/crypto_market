import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../crypto_list_screen/data/dto/error_dto.dart';
import '../dto/search_results_dto.dart';
import '../repo/repo.dart';

part 'search_event.dart';
part 'search_state.dart';

EventTransformer<E> debounceSequential<E>(Duration duration) {
  return (events, mapper) {
    return sequential<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RepoSearch repo;
  SearchBloc({required this.repo})
      : super(
          SearchInitial(),
        ) {
    on<SearchForCryptoEvent>(
      _onSearchEvent,
      transformer: debounceSequential(
        const Duration(milliseconds: 1500),
      ),
    );
  }
  _onSearchEvent(SearchForCryptoEvent event, Emitter<SearchState> emit) async {
    emit(
      SearchLoadingState(),
    );
    try {
      final results = await repo.fetch(event.query);
      emit(
        SearchLoadedState(results: results),
      );
    } catch (e) {
      if (e is DioException) {
        final error = errorDtoFromJson(
          e.response.toString(),
        );
        emit(
          SearchErrorState(
            message: error.error.toString(),
          ),
        );
      }
    }
  }
}
