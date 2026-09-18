abstract class MoreState {}

class MoreInitial extends MoreState {}

class MoreLoading extends MoreState {}

class MoreLoaded extends MoreState {
  final String name;
  final String email;
  final String role;
  final String activeBranch;

  MoreLoaded({
    required this.name,
    required this.email,
    required this.role,
    required this.activeBranch,
  });
}

class MoreLoggedOut extends MoreState {}

class MoreError extends MoreState {
  final String message;
  MoreError(this.message);
}