import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Appbar {
  static AppBar getAppBar(
    BuildContext context, {
    String? title,
    VoidCallback? onPressed,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: _title(title),
      leading: _iconButton(onPressed ?? () => Get.back()),
      centerTitle: false,
      titleSpacing: 0,
    );
  }

  static _title(String? title) {
    return Text(title ?? '', style: Get.textTheme.headlineLarge);
  }

  static _iconButton(VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset('assets/svg/ic_chevron_left.svg', width: 24, height: 24),
    );
  }
}
