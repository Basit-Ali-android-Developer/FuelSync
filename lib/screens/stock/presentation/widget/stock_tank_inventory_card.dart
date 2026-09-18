import 'package:flutter/material.dart';
import 'package:fuel_application/screens/stock/data/stock_response_model.dart';

class StockTankInventoryCard extends StatelessWidget {
  final TankInventoryItem tank;

  const StockTankInventoryCard({Key? key, required this.tank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLowStock = tank.status == 'Low Stock Alert';
    final isManual = tank.status == 'Manual Dip Only';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isLowStock ? const Color(0xFFFFFBEB) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isLowStock ? const Color(0xFFFCD34D) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black87, fontSize: 16),
                        children: [
                          TextSpan(
                            text: '${tank.tankNumber} • ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: tank.fuelTypeName),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Capacity: ${tank.capacityLitres.toStringAsFixed(0)} L • Tank Type: ${tank.tankType}',
                      style: const TextStyle(color: Colors.black54, fontSize: 11),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(tank.status),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '${tank.currentLevelLitres.toStringAsFixed(0)} ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isLowStock ? const Color(0xFFD97706) : Colors.black87,
                ),
              ),
              Text(
                '/ ${tank.capacityLitres.toStringAsFixed(0)} L',
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              const Spacer(),
              Text(
                '${tank.fillPercentage}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLowStock ? const Color(0xFFD97706) : const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: tank.fillPercentage / 100,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: AlwaysStoppedAnimation<Color>(
                isLowStock ? const Color(0xFFF59E0B) : const Color(0xFF10B981),
              ),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildDetailColumn(
                    isManual ? 'System Estimated Level' : 'System ATG Level',
                    '${tank.systemLevel.toStringAsFixed(0)} L',
                  ),
                ),
                Expanded(
                  child: _buildDetailColumn(
                    'Last Manual Dip',
                    '${tank.lastManualDip.toStringAsFixed(0)} L (${tank.manualDipDiff > 0 ? '+' : ''}${tank.manualDipDiff.toStringAsFixed(0)} L)',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // OVERFLOW FIX HERE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Last Dip Verified: ${tank.lastDipTime}',
                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Reorder Threshold: ${tank.reorderThreshold.toStringAsFixed(0)} L',
                  style: const TextStyle(color: Colors.black54, fontSize: 11),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),

          if (tank.alertMessage != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_shipping_outlined, size: 14, color: Color(0xFFD97706)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      tank.alertMessage!,
                      style: const TextStyle(color: Color(0xFF92400E), fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (tank.tankNumber == 'T-01') ...[
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.assignment_outlined, size: 16),
              label: const Text('Record Manual Dip Reading'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F172A),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg = const Color(0xFFDCFCE7);
    Color text = const Color(0xFF15803D);

    if (status == 'Low Stock Alert') {
      bg = const Color(0xFFFEF3C7);
      text = const Color(0xFFB45309);
    } else if (status == 'Manual Dip Only') {
      bg = const Color(0xFFE0E7FF);
      text = const Color(0xFF4338CA);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(
        status,
        style: TextStyle(color: text, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailColumn(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.black54, fontSize: 10)),
        const SizedBox(height: 2),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}