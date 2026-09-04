import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/constants/request_status.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/branch/data/branch_model.dart';
import 'package:fuel_application/screens/branch/logic/branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  final AuthRepository _repository;

  BranchCubit(this._repository) : super(const BranchState());

  Future<void> fetchBranches() async {
    emit(state.copyWith(status: RequestStatus.loading));
    try {
      final branches = await _repository.getBranches();

      // Auto-select the first branch by default if available
      final initialSelection = branches.isNotEmpty ? branches.first : null;

      emit(
        state.copyWith(
          status: RequestStatus.success,
          branches: branches,
          selectedBranch: initialSelection,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void selectBranch(BranchModel branch) {
    emit(state.copyWith(selectedBranch: branch));
  }
}