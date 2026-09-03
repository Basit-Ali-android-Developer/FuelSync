import 'package:fuel_application/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onViewAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = const Color(0xFF9E6514),
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Side: Icon & Title
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 26,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          // Right Side: "View All" Button
          GestureDetector(
            onTap: onViewAllPressed,
            behavior: HitTestBehavior.opaque,
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.primary, // Your blue brand color
              ),
            ),
          ),
        ],
      ),
    );
  }
}