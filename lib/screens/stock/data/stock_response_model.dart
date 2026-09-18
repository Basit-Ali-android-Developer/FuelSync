class StockResponseModel {
  final TotalInventory totalInventory;
  final List<TankInventoryItem> tanks;
  final List<RecentDelivery> recentDeliveries;

  StockResponseModel({
    required this.totalInventory,
    required this.tanks,
    required this.recentDeliveries,
  });

  factory StockResponseModel.fromJson(Map<String, dynamic> json) {
    return StockResponseModel(
      totalInventory: TotalInventory.fromJson(json['totalInventory'] ?? {}),
      tanks: (json['tanks'] as List? ?? [])
          .map((e) => TankInventoryItem.fromJson(e))
          .toList(),
      recentDeliveries: (json['recentDeliveries'] as List? ?? [])
          .map((e) => RecentDelivery.fromJson(e))
          .toList(),
    );
  }
}

class TotalInventory {
  final double currentLitres;
  final double totalCapacity;
  final double fillPercentage;
  final int tankAlertCount;
  final double superPetrolLitres;
  final double dieselLitres;
  final double ullageLitres;

  TotalInventory({
    required this.currentLitres,
    required this.totalCapacity,
    required this.fillPercentage,
    required this.tankAlertCount,
    required this.superPetrolLitres,
    required this.dieselLitres,
    required this.ullageLitres,
  });

  factory TotalInventory.fromJson(Map<String, dynamic> json) {
    return TotalInventory(
      currentLitres: (json['currentLitres'] as num?)?.toDouble() ?? 0.0,
      totalCapacity: (json['totalCapacity'] as num?)?.toDouble() ?? 0.0,
      fillPercentage: (json['fillPercentage'] as num?)?.toDouble() ?? 0.0,
      tankAlertCount: json['tankAlertCount'] ?? 0,
      superPetrolLitres: (json['superPetrolLitres'] as num?)?.toDouble() ?? 0.0,
      dieselLitres: (json['dieselLitres'] as num?)?.toDouble() ?? 0.0,
      ullageLitres: (json['ullageLitres'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class TankInventoryItem {
  final String tankNumber;
  final String fuelTypeName;
  final String status; // 'ATG Online', 'Low Stock Alert', 'Manual Dip Only'
  final String tankType;
  final double currentLevelLitres;
  final double capacityLitres;
  final double fillPercentage;
  final double systemLevel;
  final double lastManualDip;
  final double manualDipDiff;
  final String lastDipTime;
  final double reorderThreshold;
  final String? alertMessage;

  TankInventoryItem({
    required this.tankNumber,
    required this.fuelTypeName,
    required this.status,
    required this.tankType,
    required this.currentLevelLitres,
    required this.capacityLitres,
    required this.fillPercentage,
    required this.systemLevel,
    required this.lastManualDip,
    required this.manualDipDiff,
    required this.lastDipTime,
    required this.reorderThreshold,
    this.alertMessage,
  });

  factory TankInventoryItem.fromJson(Map<String, dynamic> json) {
    return TankInventoryItem(
      tankNumber: json['tankNumber'] ?? '',
      fuelTypeName: json['fuelTypeName'] ?? '',
      status: json['status'] ?? 'ATG Online',
      tankType: json['tankType'] ?? '',
      currentLevelLitres: (json['currentLevelLitres'] as num?)?.toDouble() ?? 0.0,
      capacityLitres: (json['capacityLitres'] as num?)?.toDouble() ?? 0.0,
      fillPercentage: (json['fillPercentage'] as num?)?.toDouble() ?? 0.0,
      systemLevel: (json['systemLevel'] as num?)?.toDouble() ?? 0.0,
      lastManualDip: (json['lastManualDip'] as num?)?.toDouble() ?? 0.0,
      manualDipDiff: (json['manualDipDiff'] as num?)?.toDouble() ?? 0.0,
      lastDipTime: json['lastDipTime'] ?? '',
      reorderThreshold: (json['reorderThreshold'] as num?)?.toDouble() ?? 0.0,
      alertMessage: json['alertMessage'],
    );
  }
}

class RecentDelivery {
  final String fuelType;
  final String tankNumber;
  final String tankerInfo;
  final String status;
  final double volumeDischarged;
  final double varianceLitres;
  final double baseRate;
  final double totalAmountPkr;
  final String timeStamp;
  final String verifiedBy;

  RecentDelivery({
    required this.fuelType,
    required this.tankNumber,
    required this.tankerInfo,
    required this.status,
    required this.volumeDischarged,
    required this.varianceLitres,
    required this.baseRate,
    required this.totalAmountPkr,
    required this.timeStamp,
    required this.verifiedBy,
  });

  factory RecentDelivery.fromJson(Map<String, dynamic> json) {
    return RecentDelivery(
      fuelType: json['fuelType'] ?? '',
      tankNumber: json['tankNumber'] ?? '',
      tankerInfo: json['tankerInfo'] ?? '',
      status: json['status'] ?? 'Completed',
      volumeDischarged: (json['volumeDischarged'] as num?)?.toDouble() ?? 0.0,
      varianceLitres: (json['varianceLitres'] as num?)?.toDouble() ?? 0.0,
      baseRate: (json['baseRate'] as num?)?.toDouble() ?? 0.0,
      totalAmountPkr: (json['totalAmountPkr'] as num?)?.toDouble() ?? 0.0,
      timeStamp: json['timeStamp'] ?? '',
      verifiedBy: json['verifiedBy'] ?? '',
    );
  }
}