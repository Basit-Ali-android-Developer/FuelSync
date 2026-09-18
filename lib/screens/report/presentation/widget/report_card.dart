import 'package:flutter/material.dart';
import 'package:fuel_application/screens/report/data/report_model.dart';


class ReportCard extends StatelessWidget {
  final ReportItem report;
  final VoidCallback onTap;

  const ReportCard({
    Key? key,
    required this.report,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPending = report.status.toLowerCase().contains('pending');

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPending ? const Color(0xFFFCD34D) : const Color(0xFFE2E8F0),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _getIconBgColor(report.iconType),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconData(report.iconType),
                      color: _getIconColor(report.iconType),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          report.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFE2E8F0)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isPending ? Icons.error_outline : Icons.schedule,
                        size: 14,
                        color: isPending ? const Color(0xFFD97706) : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        report.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isPending ? const Color(0xFFD97706) : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'View Report',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: Color(0xFF0F172A),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String type) {
    switch (type) {
      case 'analytics':
        return Icons.insert_chart_outlined;
      case 'tax':
        return Icons.receipt_long_outlined;
      case 'inventory':
        return Icons.local_gas_station_outlined;
      default:
        return Icons.assignment_outlined;
    }
  }

  Color _getIconBgColor(String type) {
    switch (type) {
      case 'analytics':
        return const Color(0xFFEFF6FF);
      case 'tax':
        return const Color(0xFFFEF3C7);
      case 'inventory':
        return const Color(0xFFECFDF5);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'analytics':
        return const Color(0xFF2563EB);
      case 'tax':
        return const Color(0xFFD97706);
      case 'inventory':
        return const Color(0xFF059669);
      default:
        return const Color(0xFF475569);
    }
  }
}