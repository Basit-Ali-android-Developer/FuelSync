import 'package:flutter/material.dart';
import 'package:fuel_application/screens/home/data/dashboard_response_model.dart';



class TankInventoryCard extends StatelessWidget {
  final TankLevelModel tank;

  const TankInventoryCard({super.key, required this.tank});

  @override
  Widget build(BuildContext context) {
    final isAlert = tank.isBelowReorder;
    final primaryColor = isAlert ? const Color(0xFFDC2626) : const Color(0xFF15803D);
    final bgColor = isAlert ? const Color(0xFFFEE2E2) : const Color(0xFFE0F2FE);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (isAlert)
                    const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 20),
                    ),
                  Text(
                    "${tank.tankNumber} ${tank.fuelTypeName}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isAlert ? const Color(0xFF991B1B) : const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              Text(
                "${tank.currentLevelLitres.toStringAsFixed(0)} / ${tank.capacityLitres.toStringAsFixed(0)} L",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isAlert ? const Color(0xFF991B1B) : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (tank.fillPercentage / 100).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: isAlert ? const Color(0xFFFCA5A5) : const Color(0xFFBAE6FD),
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}