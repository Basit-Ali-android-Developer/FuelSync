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
      final response = await _repository.getBranches();

      final initialSelection =
      response.branches.isNotEmpty ? response.branches.first : null;

      emit(
        state.copyWith(
          status: RequestStatus.success,
          branches: response.branches,
          permissions: response.permissions,
          selectedBranch: initialSelection,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  void selectBranch(BranchModel branch) {
    emit(state.copyWith(selectedBranch: branch));
  }
}