import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/widget/date_picker_buttom_sheet.dart';
import 'package:shopping_app/src/widget/my_text_form_field.dart';
import 'package:shopping_app/utils/date_time_utils.dart';

class InputDatePicker extends StatefulWidget {
  final TextEditingController? textEditingController;
  final Function(DateTime?)? onChanged;
  const InputDatePicker(
      {super.key, this.textEditingController, this.onChanged});

  @override
  State<InputDatePicker> createState() => _InputDatePickerState();
}

class _InputDatePickerState extends State<InputDatePicker> {
  late DateTime initialDateTime;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.textEditingController != null) {
      var _initialDateTime = DateTimeUtils.parseStringToDate(
        widget.textEditingController!.text,
        DateTimeUtils.format_DD_MM_YYYY,
      );
      if (Get.context!.locale.languageCode == "th") {
        initialDateTime = DateTime(
          _initialDateTime.year + 543,
          _initialDateTime.month,
          _initialDateTime.day,
        );
        if (!DateTimeUtils.isToday(_initialDateTime)) {
          _controller.text = DateTimeUtils.parseDateToString(
              initialDateTime, DateTimeUtils.format_DD_MM_YYYY);
        }
      } else {
        initialDateTime = _initialDateTime;
        if (!DateTimeUtils.isToday(_initialDateTime)) {
          _controller.text = DateTimeUtils.parseDateToString(
              initialDateTime, DateTimeUtils.format_DD_MM_YYYY);
        }
      }
    }
  }

  void onOpenDatePicker() async {
    var _initialDateTime = initialDateTime;
    if (Get.context!.locale.languageCode == "th") {
      _initialDateTime = DateTime(
        initialDateTime.year - 543,
        initialDateTime.month,
        initialDateTime.day,
      );
    }
    final DateTime? result = await DatePickerButtomSheet(context)
        .open(initialDateTime: _initialDateTime);
    if (result == null) return;
    if (widget.onChanged != null) widget.onChanged!(result);
    if (Get.context!.locale.languageCode == "th") {
      initialDateTime = DateTime(
        result.year + 543,
        result.month,
        result.day,
      );
    } else {
      initialDateTime = result;
    }
    final String dateResult = DateTimeUtils.parseDateToString(
        result, DateTimeUtils.format_DD_MM_YYYY);
    _controller.text = DateTimeUtils.parseDateToString(
        initialDateTime, DateTimeUtils.format_DD_MM_YYYY); // this for display
    widget.textEditingController?.text = dateResult; // use this return result
  }

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      textEditingController: _controller,
      hintText: "DD-MM-YYYY",
      readOnly: true,
      suffixIcon: suffixIcon(),
    );
  }

  Widget suffixIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: onOpenDatePicker,
        child: SvgPicture.asset('assets/svg/ic_calendar.svg',
            width: 24, height: 24),
      ),
    );
  }
}
