import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final double height;
  final Widget child;
  final Color? color;
  const CardWidget(
      {super.key, required this.child, this.color, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(3, 3),
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: child);
  }
}
