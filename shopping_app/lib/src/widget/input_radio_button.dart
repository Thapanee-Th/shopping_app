import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/service/app_unity.dart';

class InputRadioButton extends StatefulWidget {
  final TextEditingController textEditingController;
  final List<String> options;
  final double spaceGap;
  const InputRadioButton(
      {super.key,
      required this.textEditingController,
      required this.options,
      this.spaceGap = 24});

  @override
  State<InputRadioButton> createState() => _InputRadioButtonState();
}

class _InputRadioButtonState extends State<InputRadioButton> {
  late List<String> _options;

  @override
  void initState() {
    super.initState();

    _options = widget.options;
  }

  void onRadioChanged(String? value) {
    if (value != null) {
      setState(() {
        widget.textEditingController.text = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildRadioButtonList(),
    );
  }

  List<Widget> _buildRadioButtonList() {
    return _options
        .asMap()
        .map((index, value) {
          return MapEntry(
            index,
            _buildRadio(value, index),
          );
        })
        .values
        .toList();
  }

  Widget _buildRadio(String value, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Radio<String>(
            value: value,
            groupValue: widget.textEditingController.text,
            onChanged: onRadioChanged,
          ),
        ),
        AppUnity.mySizedBox(size: 8, type: TypeSizedBod.width),
        GestureDetector(
          onTap: () => onRadioChanged(value),
          child: Text(value, style: Get.textTheme.titleMedium),
        ),
        if (index != _options.length - 1)
          AppUnity.mySizedBox(size: widget.spaceGap, type: TypeSizedBod.width),
      ],
    );
  }
}
