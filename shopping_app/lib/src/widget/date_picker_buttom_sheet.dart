import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerButtomSheet {
  BuildContext context;
  DatePickerButtomSheet(this.context);

  Future<DateTime?> open({DateTime? initialDateTime}) {
    return showModalBottomSheet<DateTime>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(),
      builder: (BuildContext context) {
        return CustomCupertinoDatePicker(
            initialDateTime: initialDateTime,
            languageCode: context.locale.languageCode);
      },
    );
  }
}

class CustomCupertinoDatePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final String languageCode;
  const CustomCupertinoDatePicker(
      {super.key, this.initialDateTime, this.languageCode = 'en'});

  @override
  State<CustomCupertinoDatePicker> createState() =>
      _CustomCupertinoDatePickerState();
}

class _CustomCupertinoDatePickerState extends State<CustomCupertinoDatePicker> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.languageCode == 'th') {
      if (widget.initialDateTime != null) {
        _selectedDate = DateTime(
          widget.initialDateTime!.year + 543,
          widget.initialDateTime!.month,
          widget.initialDateTime!.day,
        );
      } else {
        var now = DateTime.now();
        _selectedDate = DateTime(now.year + 543, now.month, now.day);
      }
    } else {
      _selectedDate = widget.initialDateTime ?? DateTime.now();
    }
  }

  void onChanged(DateTime newDateTime) {
    setState(() {
      _selectedDate = newDateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).copyWith().size.height * 0.4,
      child: Column(
        children: [
          _buildHeader(),
          _buildCupertinoDatePicker(),
        ],
      ),
    );
  }

  Widget _buildCupertinoDatePicker() {
    int minimumYear = 1920;
    int maximumYear = DateTime.now().year;
    if (widget.languageCode == 'th') {
      minimumYear = minimumYear + 543;
      maximumYear = maximumYear + 543;
    }

    return Expanded(
      child: CupertinoDatePicker(
        initialDateTime: _selectedDate,
        mode: CupertinoDatePickerMode.date,
        dateOrder: DatePickerDateOrder.dmy,
        onDateTimeChanged: onChanged,
        minimumYear: minimumYear,
        maximumYear: maximumYear,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBtn(
                text: tr('cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              _buildBtn(
                text: tr('done'),
                onPressed: () {
                  if (widget.languageCode == 'th') {
                    Navigator.pop(
                        context,
                        DateTime(
                          _selectedDate.year - 543,
                          _selectedDate.month,
                          _selectedDate.day,
                        ));
                  } else {
                    Navigator.pop(context, _selectedDate);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBtn(
      {VoidCallback? onPressed, required String text, Color? color}) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: Get.textTheme.headlineMedium
            ?.copyWith(color: color ?? Colors.grey[700]),
      ),
    );
  }
}
