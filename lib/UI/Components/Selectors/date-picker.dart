import 'package:flutter/material.dart';
import 'package:vodda_providers/Logic/Controllers/main-controller.dart';
import 'package:vodda_providers/UI/Components/Selectors/select-box.dart';

class DatePicker extends StatefulWidget {
  Function? onSelect;
  int? day;
  int? month;
  int? year;
  DatePicker({Key? key, this.onSelect, this.year, this.month, this.day})
    : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int day = 1;
  int month = 1;
  int year = MainController.years.keys.elementAt(0);
  int dayCount = 31;

  setString() {
    return '${year}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    day = widget.day ?? 1;
    month = widget.month ?? 1;
    year = widget.year ?? MainController.years.keys.elementAt(0);
    if (month == 12 && !MainController.years[year]!) {
      dayCount = 29;
    } else if (month > 6) {
      dayCount = 30;
    } else
      dayCount = 31;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectBox(
          text: 'روز',
          width: 90,
          options: {for (int i = 1; i <= dayCount; i++) '${i}': i},
          onSelect: (val) {
            day = val;
            if (widget.onSelect != null) widget.onSelect!(setString());
          },
          value: day,
        ),
        SelectBox(
          value: month,
          text: ' ماه',
          width: 125,
          options: {
            'فروردین': 1,
            'اردیبهشت': 2,
            'خرداد': 3,
            'تیر': 4,
            'مرداد': 5,
            'شهریور': 6,
            'مهر': 7,
            'آبان': 8,
            'آذر': 9,
            'دی': 10,
            'بهمن': 11,
            'اسفند': 12,
          },
          onSelect: (val) {
            month = val;

            if (month == 12 && !MainController.years[year]!) {
              dayCount = 29;
              if (day > 29) day = 29;
            } else if (month > 6) {
              dayCount = 30;
              if (day == 31) day = 30;
            } else
              dayCount = 31;
            setState(() {});

            if (widget.onSelect != null) widget.onSelect!(setString());
          },
        ),
        SelectBox(
          value: year,
          text: 'سال',
          width: 90,
          options: {for (int year in MainController.years.keys) year: year},
          onSelect: (val) {
            year = val;
            if (month == 12 && !MainController.years[year]!) {
              dayCount = 29;
              if (day > 29) day = 29;
            } else if (month > 6)
              dayCount = 30;
            else
              dayCount = 31;
            setState(() {});
            if (widget.onSelect != null) widget.onSelect!(setString());
            // newHoliday.day=val;
          },
        ),
      ],
    );
  }
}
