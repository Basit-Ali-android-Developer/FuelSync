import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'stock_state.dart';

class StockCubit extends Cubit<StockState> {
  final AuthRepository repository;

  StockCubit(this.repository) : super(StockInitial());

  Future<void> fetchStockData(int branchId) async {
    emit(StockLoading());
    try {
      final data = await repository.getStockData(branchId);
      emit(StockLoaded(data));
    } catch (e) {
      emit(StockError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}