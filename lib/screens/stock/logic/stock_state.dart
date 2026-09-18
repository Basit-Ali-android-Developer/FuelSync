import '../data/stock_response_model.dart';

abstract class StockState {}

class StockInitial extends StockState {}

class StockLoading extends StockState {}

class StockLoaded extends StockState {
  final StockResponseModel stockData;
  StockLoaded(this.stockData);
}

class StockError extends StockState {
  final String message;
  StockError(this.message);
}