import 'package:crypto_polygon/src/features/crypto_list_screen/data/dto/error_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dto/crypto_detailed_dto.dart';
import '../repo/repo.dart';
part 'crypto_detailed_event.dart';
part 'crypto_detailed_state.dart';

class CryptoDetailedBloc
    extends Bloc<CryptoDetailedEvent, CryptoDetailedState> {
  final RepoCryptoDetailed repo;
  CryptoDetailedBloc({required this.repo}) : super(CryptoDetailedInitial()) {
    on<GetDetailsEvent>(_onGetDetails);
  }
  _onGetDetails(
      GetDetailsEvent event, Emitter<CryptoDetailedState> emitter) async {
    emit(CryptoDetailedLoadingState());
    try {
      final results = await repo.fetch(
          event.dateFrom, event.dateTo, event.timespan, event.ticker);
      emit(CryptoDetailedLoadedState(cryptos: results));
    } catch (e) {
      if (e is DioException) { // обработка кейса ошибки с бэка
        final error = errorDtoFromJson(e.response.toString());
        emit(CryptoDetailedErrorState(error: error.error.toString()));
      }
      print(e);
    }
  }
}
