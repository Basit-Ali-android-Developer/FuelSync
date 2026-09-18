import 'package:flutter/material.dart';
import 'package:fuel_application/screens/shift/data/active_shift_model.dart';

class ShiftHeaderCard extends StatelessWidget {
  final ActiveShift shift;

  const ShiftHeaderCard({
    Key? key,
    required this.shift,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EFFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SHIFT #${shift.id}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF064E3B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.circle, color: Color(0xFF10B981), size: 8),
                    SizedBox(width: 6),
                    Text(
                      'Active',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            shift.templateName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ShiftInfoItem(
                  icon: Icons.access_time,
                  title: 'Started',
                  value: shift.openedAt,
                ),
              ),
              Expanded(
                child: _ShiftInfoItem(
                  icon: Icons.timer_outlined,
                  title: 'Elapsed',
                  value: shift.elapsedTime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ShiftInfoItem(
                  icon: Icons.badge_outlined,
                  title: 'Supervisor',
                  value: shift.supervisor,
                ),
              ),
              Expanded(
                child: _ShiftInfoItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Float',
                  value: 'PKR ${shift.openingFloat.toStringAsFixed(0)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShiftInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ShiftInfoItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        )
      ],
    );
  }
}