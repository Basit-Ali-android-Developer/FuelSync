import 'package:fuel_application/core/constants/request_status.dart';
import 'package:fuel_application/screens/branch/data/branch_model.dart';

class BranchState {
  final RequestStatus status;
  final List<BranchModel> branches;
  final List<String> permissions;
  final BranchModel? selectedBranch;
  final String? errorMessage;

  const BranchState({
    this.status = RequestStatus.initial,
    this.branches = const [],
    this.permissions = const [],
    this.selectedBranch,
    this.errorMessage,
  });

  BranchState copyWith({
    RequestStatus? status,
    List<BranchModel>? branches,
    List<String>? permissions,
    BranchModel? selectedBranch,
    String? errorMessage,
  }) {
    return BranchState(
      status: status ?? this.status,
      branches: branches ?? this.branches,
      permissions: permissions ?? this.permissions,
      selectedBranch: selectedBranch ?? this.selectedBranch,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}