class DashboardResponseModel {
  final double todayRevenuePkr;
  final double yesterdayRevenuePkr;
  final String revenueTrend;
  final double todayLitres;
  final double yesterdayLitres;
  final int activeDispenserCount;
  final int totalDispenserCount;
  final int openShifts;
  final double totalReceivablePkr;
  final double todayRecoveryPkr;
  final int totalCustomers;
  final double todayBorrowedFuelLitres;
  final double todayBorrowedAmountPkr;
  final double lastShiftRevenuePkr;
  final double lastShiftLitres;
  final String lastShiftLabel;
  final List<TankLevelModel> tankLevels;
  final List<RevenueGraphModel> revenueGraph;
  final List<RecentTransactionModel> recentTransactions;

  DashboardResponseModel({
    required this.todayRevenuePkr,
    required this.yesterdayRevenuePkr,
    required this.revenueTrend,
    required this.todayLitres,
    required this.yesterdayLitres,
    required this.activeDispenserCount,
    required this.totalDispenserCount,
    required this.openShifts,
    required this.totalReceivablePkr,
    required this.todayRecoveryPkr,
    required this.totalCustomers,
    required this.todayBorrowedFuelLitres,
    required this.todayBorrowedAmountPkr,
    required this.lastShiftRevenuePkr,
    required this.lastShiftLitres,
    required this.lastShiftLabel,
    required this.tankLevels,
    required this.revenueGraph,
    required this.recentTransactions,
  });

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(
      todayRevenuePkr: (json['todayRevenuePkr'] as num?)?.toDouble() ?? 0.0,
      yesterdayRevenuePkr: (json['yesterdayRevenuePkr'] as num?)?.toDouble() ?? 0.0,
      revenueTrend: json['revenueTrend'] ?? 'up',
      todayLitres: (json['todayLitres'] as num?)?.toDouble() ?? 0.0,
      yesterdayLitres: (json['yesterdayLitres'] as num?)?.toDouble() ?? 0.0,
      activeDispenserCount: json['activeDispenserCount'] ?? 0,
      totalDispenserCount: json['totalDispenserCount'] ?? 0,
      openShifts: json['openShifts'] ?? 0,
      totalReceivablePkr: (json['totalReceivablePkr'] as num?)?.toDouble() ?? 0.0,
      todayRecoveryPkr: (json['todayRecoveryPkr'] as num?)?.toDouble() ?? 0.0,
      totalCustomers: json['totalCustomers'] ?? 0,
      todayBorrowedFuelLitres: (json['todayBorrowedFuelLitres'] as num?)?.toDouble() ?? 0.0,
      todayBorrowedAmountPkr: (json['todayBorrowedAmountPkr'] as num?)?.toDouble() ?? 0.0,
      lastShiftRevenuePkr: (json['lastShiftRevenuePkr'] as num?)?.toDouble() ?? 0.0,
      lastShiftLitres: (json['lastShiftLitres'] as num?)?.toDouble() ?? 0.0,
      lastShiftLabel: json['lastShiftLabel'] ?? '',
      tankLevels: (json['tankLevels'] as List? ?? [])
          .map((e) => TankLevelModel.fromJson(e))
          .toList(),
      revenueGraph: (json['revenueGraph'] as List? ?? [])
          .map((e) => RevenueGraphModel.fromJson(e))
          .toList(),
      recentTransactions: (json['recentTransactions'] as List? ?? [])
          .map((e) => RecentTransactionModel.fromJson(e))
          .toList(),
    );
  }
}

class TankLevelModel {
  final int id;
  final String tankNumber;
  final String fuelTypeName;
  final double currentLevelLitres;
  final double capacityLitres;
  final double fillPercentage;
  final bool isBelowReorder;

  TankLevelModel({
    required this.id,
    required this.tankNumber,
    required this.fuelTypeName,
    required this.currentLevelLitres,
    required this.capacityLitres,
    required this.fillPercentage,
    required this.isBelowReorder,
  });

  factory TankLevelModel.fromJson(Map<String, dynamic> json) {
    return TankLevelModel(
      id: json['id'] ?? 0,
      tankNumber: json['tankNumber'] ?? '',
      fuelTypeName: json['fuelTypeName'] ?? '',
      currentLevelLitres: (json['currentLevelLitres'] as num?)?.toDouble() ?? 0.0,
      capacityLitres: (json['capacityLitres'] as num?)?.toDouble() ?? 0.0,
      fillPercentage: (json['fillPercentage'] as num?)?.toDouble() ?? 0.0,
      isBelowReorder: json['isBelowReorder'] ?? false,
    );
  }
}

class RevenueGraphModel {
  final String label;
  final double amount;
  final double litres;

  RevenueGraphModel({
    required this.label,
    required this.amount,
    required this.litres,
  });

  factory RevenueGraphModel.fromJson(Map<String, dynamic> json) {
    return RevenueGraphModel(
      label: json['label'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      litres: (json['litres'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class RecentTransactionModel {
  final int id;
  final String fuelGrade;
  final double volumeLitres;
  final double totalAmountPkr;
  final String recordedAt;
  final String source;

  RecentTransactionModel({
    required this.id,
    required this.fuelGrade,
    required this.volumeLitres,
    required this.totalAmountPkr,
    required this.recordedAt,
    required this.source,
  });

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json) {
    return RecentTransactionModel(
      id: json['id'] ?? 0,
      fuelGrade: json['fuelGrade'] ?? '',
      volumeLitres: (json['volumeLitres'] as num?)?.toDouble() ?? 0.0,
      totalAmountPkr: (json['totalAmountPkr'] as num?)?.toDouble() ?? 0.0,
      recordedAt: json['recordedAt'] ?? '',
      source: json['source'] ?? '',
    );
  }
}