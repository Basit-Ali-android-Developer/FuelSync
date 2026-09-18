import 'branch_model.dart';

class BranchResponseModel {
  final List<BranchModel> branches;
  final List<String> permissions;

  BranchResponseModel({
    required this.branches,
    required this.permissions,
  });

  factory BranchResponseModel.fromJson(Map<String, dynamic> json) {
    return BranchResponseModel(
      branches: json['branches'] != null
          ? (json['branches'] as List)
          .map((e) => BranchModel.fromJson(e as Map<String, dynamic>))
          .toList()
          : [],
      permissions: json['permissions'] != null
          ? List<String>.from(json['permissions'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branches': branches.map((e) => e.toJson()).toList(),
      'permissions': permissions,
    };
  }
}