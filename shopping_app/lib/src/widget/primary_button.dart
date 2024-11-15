import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final double? width;
  const PrimaryButton({super.key, required this.title, this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 48),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title ?? tr('primaryButtonNext'),
            style: Get.textTheme.headlineLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
