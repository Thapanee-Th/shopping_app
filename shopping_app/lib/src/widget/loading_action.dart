import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class LoadingAction extends StatelessWidget {
  final double opacity;
  const LoadingAction({super.key, this.opacity = 0.3});

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('LoadingAction'),
      alignment: Alignment.center,
      children: [
        const ModalBarrier(
          dismissible: false,
        ),
        Positioned(
          child: Image.asset(cupertinoActivityIndicator, scale: 6),
        ),
      ],
    );
  }
}
