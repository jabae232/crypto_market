import 'package:bloc/bloc.dart';
import 'package:crypto_polygon/src/features/crypto_list_screen/data/dto/error_dto.dart';
import 'package:dio/dio.dart';
import '../dto/daily_bars_dto.dart';
import '../repo/repo.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final RepoCryptoList repo;
  CryptoListBloc({required this.repo}) : super(CryptoListInitial()) {
    on<GetCryptosEvent>(_onGetAccount);
  }
  _onGetAccount(GetCryptosEvent event, Emitter<CryptoListState> emit) async {
    emit(CryptoListLoadingState());
    try {
      final cryptosUpToDate = await repo.fetch(event.upToDate);
      final cryptosDayBefore = await repo.fetch(event.dateBefore);
      emit(CryptoListLoadedState(
          cryptosUpToDate: cryptosUpToDate,
          cryptosDateBefore: cryptosDayBefore));
    } catch(e) {
      if(e is DioException) {
        final error = errorDtoFromJson(e.response.toString());
        emit(CryptoListErrorState(message: error.error.toString()));
      }
    }
  }
}
