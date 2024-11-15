// ignore_for_file: constant_identifier_names
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:shopping_app/service/app_unity.dart';
import 'package:shopping_app/src/widget/my_num_pad.dart';

enum NumpadScreenType { PIN, OTP }

class NumpadScreen extends StatefulWidget {
  final NumpadScreenType type;
  final String? title;
  final Function(String)? onCompleted;
  final Stream<bool>? shouldTriggerVerification;
  final int limit;
  const NumpadScreen({
    super.key,
    required this.type,
    this.title,
    this.onCompleted,
    this.shouldTriggerVerification,
    this.limit = 6,
  });

  @override
  State<NumpadScreen> createState() => _NumpadScreenState();
}

class _NumpadScreenState extends State<NumpadScreen> {
  late StreamSubscription<bool> streamSubscription;
  final TextEditingController passcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.shouldTriggerVerification != null) {
      streamSubscription = widget.shouldTriggerVerification!
          .listen((isValid) => onValidation(isValid));
    }
  }

  void onPressPad(String text) {
    if (passcodeController.text.length >= widget.limit) {
      return;
    }
    setState(() {
      passcodeController.text = passcodeController.text + text;
    });

    if (passcodeController.text.length == widget.limit) {
      widget.onCompleted?.call(passcodeController.text);
    }
  }

  void onBackspace() {
    if (passcodeController.text.isEmpty) {
      return;
    }
    setState(() {
      passcodeController.text = passcodeController.text
          .substring(0, passcodeController.text.length - 1);
    });
  }

  void onValidation(bool isValid) {
    if ((mounted) && !isValid) {
      setState(() {
        passcodeController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.type == NumpadScreenType.PIN) _buildDisplayPIN(),
        if (widget.type == NumpadScreenType.OTP) _buildDisplayOTP(),
        AppUnity.mySizedBox(size: 32, type: TypeSizedBod.high),
        _buildPad(),
      ],
    );
  }

  Widget _buildDisplayPIN() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            widget.title ?? tr('pleaseSetPass6digit'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AppUnity.mySizedBox(size: 24, type: TypeSizedBod.high),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: List.generate(
              widget.limit,
              (index) {
                final bool isFill = index < passcodeController.text.length;
                return Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    if (index != (widget.limit - 1))
                      AppUnity.mySizedBox(size: 24, type: TypeSizedBod.width),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplayOTP() {
    final defaultPinTheme = PinTheme(
      width: 44.6,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFB7BABD)),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
          fontSize: 32, fontWeight: FontWeight.normal, color: Colors.black),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 8,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 16,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          AppUnity.mySizedBox(size: 12, type: TypeSizedBod.high),
          Text(
            widget.title ?? tr('pleaseEnterOtpCode'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          AppUnity.mySizedBox(size: 8, type: TypeSizedBod.high),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Pinput(
                  controller: passcodeController,
                  length: widget.limit,
                  useNativeKeyboard: false,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyDecorationWith(
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0,
                        blurRadius: 4,
                        blurStyle: BlurStyle.outer,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  submittedPinTheme: defaultPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                ),
              ),
            ],
          ),
          AppUnity.mySizedBox(size: 24, type: TypeSizedBod.high),
        ],
      ),
    );
  }

  _buildPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NumpadButton(
              label: "1",
              onPressed: () => onPressPad('1'),
            ),
            NumpadButton(
              label: "2",
              onPressed: () => onPressPad('2'),
            ),
            NumpadButton(
              label: "3",
              onPressed: () => onPressPad('3'),
            ),
          ],
        ),
        AppUnity.mySizedBox(size: 16, type: TypeSizedBod.high),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NumpadButton(
              label: "4",
              onPressed: () => onPressPad('4'),
            ),
            NumpadButton(
              label: "5",
              onPressed: () => onPressPad('5'),
            ),
            NumpadButton(
              label: "6",
              onPressed: () => onPressPad('6'),
            ),
          ],
        ),
        AppUnity.mySizedBox(size: 16, type: TypeSizedBod.high),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            NumpadButton(
              label: "7",
              onPressed: () => onPressPad('7'),
            ),
            NumpadButton(
              label: "8",
              onPressed: () => onPressPad('8'),
            ),
            NumpadButton(
              label: "9",
              onPressed: () => onPressPad('9'),
            ),
          ],
        ),
        AppUnity.mySizedBox(size: 16, type: TypeSizedBod.high),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const NumpadButton(
              isHidden: true,
            ),
            NumpadButton(
              label: "0",
              onPressed: () => onPressPad('0'),
            ),
            NumpadButton(
              icon: SvgPicture.asset('assets/svg/ic_backspace.svg'),
              onPressed: () => onBackspace(),
            ),
          ],
        ),
      ],
    );
  }
}
