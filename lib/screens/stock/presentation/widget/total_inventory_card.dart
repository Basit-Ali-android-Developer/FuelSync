import 'package:flutter/material.dart';
import 'package:fuel_application/screens/stock/data/stock_response_model.dart';

class TotalInventoryCard extends StatelessWidget {
  final TotalInventory total;

  const TotalInventoryCard({Key? key, required this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate proportions relative to total capacity
    final superRatio = (total.superPetrolLitres / total.totalCapacity).clamp(0.0, 1.0);
    final dieselRatio = (total.dieselLitres / total.totalCapacity).clamp(0.0, 1.0);
    final ullageRatio = (total.ullageLitres / total.totalCapacity).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL BULK INVENTORY',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C2D12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '• ${total.tankAlertCount} Tank Alert',
                  style: const TextStyle(
                    color: Color(0xFFFDBA74),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${total.currentLitres.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('L', style: TextStyle(color: Colors.white, fontSize: 16)),
              const Spacer(),
              Text(
                'Cap: ${total.totalCapacity.toStringAsFixed(0)} L (${total.fillPercentage}%)',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildFuelDot(
                  const Color(0xFF10B981),
                  'Super Petrol (${total.superPetrolLitres.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} L)'
              ),
              const SizedBox(width: 12),
              _buildFuelDot(
                  const Color(0xFFFDE047),
                  'Diesel HSD (${total.dieselLitres.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} L)'
              ),
            ],
          ),
          const SizedBox(height: 8),

          // MULTI-COLOR SEGMENTED PROGRESS BAR
          Container(
            height: 8,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFF334155),
            ),
            child: Row(
              children: [
                if (superRatio > 0)
                  Expanded(
                    flex: (superRatio * 1000).toInt(),
                    child: Container(
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                if (dieselRatio > 0)
                  Expanded(
                    flex: (dieselRatio * 1000).toInt(),
                    child: Container(
                      margin: const EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE047),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                if (ullageRatio > 0)
                  Expanded(
                    flex: (ullageRatio * 1000).toInt(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Fill: ${total.fillPercentage}%',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
              Text(
                'Ullage: ${total.ullageLitres.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} L available',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFuelDot(Color color, String text) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 11)),
      ],
    );
  }
}