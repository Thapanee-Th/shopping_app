import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/service/app_unity.dart';
import 'package:shopping_app/src/widget/input_date_picker.dart';
import 'package:shopping_app/src/widget/input_radio_button.dart';
import 'package:shopping_app/src/widget/my_text_form_field.dart';

class FormFieldTitle extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool isRequire;
  final bool disable;
  final FormFieldTitleType type;
  final List<String>? option;

  const FormFieldTitle({
    super.key,
    required this.controller,
    required this.title,
    this.isRequire = false,
    this.disable = false,
    this.type = FormFieldTitleType.text,
    this.option,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleRequired(title, isRequire: isRequire),
        AppUnity.mySizedBox(size: 4, type: TypeSizedBod.high),
        if (type == FormFieldTitleType.text)
          MyTextFormField(disable: disable, textEditingController: controller),
        if (type == FormFieldTitleType.phoneNumber)
          MyTextFormFieldNumber(
              disable: disable, textEditingController: controller),
        if (type == FormFieldTitleType.calendar)
          InputDatePicker(textEditingController: controller),
        if (type == FormFieldTitleType.option)
          InputRadioButton(
              textEditingController: controller, options: option ?? []),
      ],
    );
  }

  Widget _titleRequired(String title, {isRequire = false}) {
    return Row(
      children: [
        Text(title, style: Get.textTheme.headlineMedium),
        if (isRequire)
          Row(
            children: [
              AppUnity.mySizedBox(size: 4, type: TypeSizedBod.width),
              const Text('*', style: TextStyle(color: Colors.red)),
            ],
          ),
      ],
    );
  }
}

enum FormFieldTitleType {
  text,
  phoneNumber,
  calendar,
  option,
}
