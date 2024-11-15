import 'package:flutter/material.dart';
import 'package:shopping_app/service/app_unity.dart';
import 'package:shopping_app/src/widget/primary_button.dart';

class FooterPrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Widget? content;
  const FooterPrimaryButton(
      {super.key, this.title, this.onPressed, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x34495514).withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            color: const Color(0x34495514).withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 16,
            offset: const Offset(0, -4),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppUnity.mySizedBox(size: 8, type: TypeSizedBod.high),
          if (content != null) content!,
          if (content != null)
            AppUnity.mySizedBox(size: 8, type: TypeSizedBod.high),
          PrimaryButton(
            title: title,
            onPressed: onPressed,
            width: double.infinity,
          ),
          AppUnity.mySizedBox(size: 24, type: TypeSizedBod.high),
        ],
      ),
    );
  }
}
