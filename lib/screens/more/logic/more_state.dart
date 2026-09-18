abstract class MoreState {}

class MoreInitial extends MoreState {}

class MoreLoading extends MoreState {}

class MoreLoaded extends MoreState {
  final String name;
  final String email;
 // final String role;
  final String activeBranch;
  final String branchAddress;
  final bool isShiftOpen;

  MoreLoaded({
    required this.name,
    required this.email,
  //  required this.role,
    required this.activeBranch,
    required this.branchAddress,
    required this.isShiftOpen,
  });
}

class MoreError extends MoreState {
  final String message;
  MoreError(this.message);
}

class MoreLoggedOut extends MoreState {}