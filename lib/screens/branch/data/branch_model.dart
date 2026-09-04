class BranchModel {
  final int branchId;
  final String branchName;
  final String address;
  final bool isShiftOpen;

  BranchModel({
    required this.branchId,
    required this.branchName,
    required this.address,
    required this.isShiftOpen,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      branchId: json['branchId'] ?? 0,
      branchName: json['branchName'] ?? '',
      address: json['address'] ?? '',
      isShiftOpen: json['isShiftOpen'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'branchName': branchName,
      'address': address,
      'isShiftOpen': isShiftOpen,
    };
  }
}