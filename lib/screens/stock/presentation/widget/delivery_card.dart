import 'package:flutter/material.dart';
import 'package:fuel_application/screens/stock/data/stock_response_model.dart';

class DeliveryCard extends StatelessWidget {
  final RecentDelivery delivery;

  const DeliveryCard({Key? key, required this.delivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                  children: [
                    TextSpan(
                      text: '${delivery.fuelType} ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: 'to '),
                    TextSpan(
                      text: delivery.tankNumber,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E7FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  delivery.status,
                  style: const TextStyle(color: Color(0xFF3730A3), fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 2),
          Text(delivery.tankerInfo, style: const TextStyle(color: Colors.black54, fontSize: 11)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Volume Discharged', style: TextStyle(color: Colors.black54, fontSize: 10)),
                  Text(
                    '${delivery.volumeDischarged.toStringAsFixed(0)} L (${delivery.varianceLitres.toStringAsFixed(0)} L)',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Base: PKR ${delivery.baseRate}', style: const TextStyle(color: Colors.black54, fontSize: 10)),
                  Text(
                    'PKR ${delivery.totalAmountPkr.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(delivery.timeStamp, style: const TextStyle(color: Colors.black54, fontSize: 10)),
              Text('Verified by ${delivery.verifiedBy}', style: const TextStyle(color: Colors.black54, fontSize: 10)),
            ],
          )
        ],
      ),
    );
  }
}