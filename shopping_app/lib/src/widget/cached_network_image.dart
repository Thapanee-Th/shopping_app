import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget? errorWidget;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.errorWidget,
    this.fit,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        height: height ?? 112,
        width: width ?? 112,
        child: Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Image.asset('assets/image/logo.png', height: height, width: width),
      errorListener: (value) =>
          errorWidget ??
          Image.asset('assets/image/logo.png', height: height, width: width),
    );
  }
}
