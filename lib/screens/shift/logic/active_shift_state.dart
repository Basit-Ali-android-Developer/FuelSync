
import 'package:fuel_application/screens/shift/data/active_shift_model.dart';

abstract class ActiveShiftState {}

class ActiveShiftInitial extends ActiveShiftState {}

class ActiveShiftLoading extends ActiveShiftState {}

class ActiveShiftLoaded extends ActiveShiftState {
  final ActiveShift shift;
  ActiveShiftLoaded(this.shift);
}

class ActiveShiftError extends ActiveShiftState {
  final String message;
  ActiveShiftError(this.message);
}