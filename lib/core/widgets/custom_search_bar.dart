import 'package:flutter/material.dart';
import 'package:fuel_application/core/constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  //final VoidCallback? onVoicePressed;
  //final VoidCallback? onCameraPressed;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search ...', // Default placeholder
    this.onChanged,
    this.controller,
    //this.onVoicePressed,
    //this.onCameraPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
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

        // suffixIcon: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     if (onVoicePressed != null)
        //       IconButton(
        //         icon: const Icon(Icons.mic_none_outlined),
        //         color: AppColors.primary,
        //         iconSize: 22,
        //         onPressed: onVoicePressed,
        //       ),
        //     if (onCameraPressed != null)
        //       IconButton(
        //         icon: const Icon(Icons.camera_alt_outlined),
        //         color: AppColors.primary,
        //         iconSize: 22,
        //         onPressed: onCameraPressed,
        //       ),
        //     const SizedBox(width: 4),
        //   ],
        // ),
        filled: true,
        fillColor: const Color(0xFFF5F6F9),
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
    );
  }
}