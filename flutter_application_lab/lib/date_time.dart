import 'package:date_range_form_field/date_range_form_field.dart';
import 'package:flutter/material.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({Key? key}) : super(key: key);

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

GlobalKey<FormState> myFormKey = GlobalKey();

class _DateRangePickerState extends State<DateRangePicker> {

  DateTimeRange? myDateRange;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Form(
          key: myFormKey,
          child: Column(
            children: [
              SafeArea(
                child: DateRangeField(
                  enabled: true,
                  initialValue: DateTimeRange(
                      start: DateTime.now(),
                      end: DateTime.now().add(const Duration(days: 5))),
                  decoration: const InputDecoration(
                    labelText: 'Date Range',
                    prefixIcon: Icon(Icons.date_range),
                    hintText: 'Please select a start and end date',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.start.isBefore(DateTime.now())) {
                      return 'Please enter a later start date';
                    }
                    return value.toString();
                  },
                  onSaved: (value) {
                    setState(() {
                      myDateRange = value!;
                    });
                  }),
              ),           
            ],
          ),
        ),
      ]
    );
  }
}
