import 'package:flutter/material.dart';

class NumpadButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isHidden;
  const NumpadButton({
    super.key,
    this.icon,
    this.label,
    this.onPressed,
    this.isHidden = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        height: 72,
        width: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
              width: 2,
              color: isHidden ? Colors.transparent : Color(0xFFE7E8E9)),
        ),
        child: icon ??
            Text(
              label ?? '',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w400),
            ),
      ),
    );
  }
}
