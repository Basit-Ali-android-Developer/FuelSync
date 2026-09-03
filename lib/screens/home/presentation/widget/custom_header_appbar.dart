import 'package:flutter/material.dart';
import 'package:fuel_application/core/constants/app_colors.dart';

class CustomHeaderAppBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onVoiceSearchPressed;
  final VoidCallback? onCameraSearchPressed;

  const CustomHeaderAppBar({
    super.key,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onSearchChanged,
    this.onVoiceSearchPressed,
    this.onCameraSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.menu,
                  size: 28,
                  color: AppColors.primary, // Matches your brand blue
                ),
                onPressed: onMenuPressed,
              ),


              Text(
                'E-Commerce',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary, // Matches your brand blue
                  letterSpacing: 1.2,
                ),
              ),


              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  size: 28,
                  color: AppColors.primary,
                ),
                onPressed: onNotificationPressed,
              ),
            ],
          ),

          const SizedBox(height: 16),

          //  Search Bar -------------------------------------------------------
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search luxury collections...',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 24,
              ),

              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic_none_outlined),
                    color: AppColors.primary,
                    iconSize: 22,
                    onPressed: onVoiceSearchPressed,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    color: AppColors.primary,
                    iconSize: 22,
                    onPressed: onCameraSearchPressed,
                  ),
                  const SizedBox(width: 4), // Small padding at the end
                ],
              ),
              // Visual styling matching the screenshot
              filled: true,
              fillColor: const Color(0xFFF5F6F9), // Light tinted background
              contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.primary.withOpacity(0.15),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),


          const SizedBox(height: 8),
        ],
      ),
    );
  }
}