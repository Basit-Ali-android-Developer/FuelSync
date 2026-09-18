class ActiveShift {
  final int id;
  final int branchId;
  final String branchName;
  final String templateName;
  final String openedAt;
  final double openingFloat;
  final String supervisor;
  final String elapsedTime;
  final List<Worker> workers;
  final List<NozzleAssignment> nozzleAssignments;

  ActiveShift({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.templateName,
    required this.openedAt,
    required this.openingFloat,
    required this.supervisor,
    required this.elapsedTime,
    required this.workers,
    required this.nozzleAssignments,
  });

  factory ActiveShift.fromJson(Map<String, dynamic> json) {
    return ActiveShift(
      id: json['id'] ?? 0,
      branchId: json['branchId'] ?? 0,
      branchName: json['branchName'] ?? '',
      templateName: json['templateName'] ?? 'Shift',
      openedAt: json['openedAt'] ?? '',
      openingFloat: (json['openingFloat'] as num?)?.toDouble() ?? 0.0,
      supervisor: json['supervisor'] ?? 'Ali Khan',
      elapsedTime: json['elapsedTime'] ?? '4h 42m',
      workers: (json['workers'] as List? ?? [])
          .map((w) => Worker.fromJson(w))
          .toList(),
      nozzleAssignments: (json['nozzleAssignments'] as List? ?? [])
          .map((n) => NozzleAssignment.fromJson(n))
          .toList(),
    );
  }
}

class Worker {
  final String name;
  final String role;
  final String assignmentDetails;

  Worker({
    required this.name,
    required this.role,
    required this.assignmentDetails,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      assignmentDetails: json['assignmentDetails'] ?? '',
    );
  }
}

class NozzleAssignment {
  final String nozzleCode;
  final String dispenserCode;
  final String fuelType;
  final String assignedTo;
  final double rate;
  final double openingReading;

  NozzleAssignment({
    required this.nozzleCode,
    required this.dispenserCode,
    required this.fuelType,
    required this.assignedTo,
    required this.rate,
    required this.openingReading,
  });

  factory NozzleAssignment.fromJson(Map<String, dynamic> json) {
    return NozzleAssignment(
      nozzleCode: json['nozzleCode'] ?? '',
      dispenserCode: json['dispenserCode'] ?? '',
      fuelType: json['fuelType'] ?? '',
      assignedTo: json['assignedTo'] ?? '',
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
      openingReading: (json['openingReading'] as num?)?.toDouble() ?? 0.0,
    );
  }
}