import 'package:evently/common/enums/categories_enum.dart';
import 'package:flutter/material.dart';

class NewEventProvider extends ChangeNotifier {
  DateTime? eventSelectedDate;
  TimeOfDay? eventSelectedTime;
  CategoriesEnum selectedCategory = CategoriesEnum.birthDays;
  bool isLoading = false;
  void updateLading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }

  void changeDate(DateTime date) {
    eventSelectedDate = date;
    notifyListeners();
  }

  void changeTime(TimeOfDay time) {
    eventSelectedTime = time;
    notifyListeners();
  }

  void changeCategory(CategoriesEnum category) {
    selectedCategory = category;
    notifyListeners();
  }

  int getFormattedDateTime() {
    if (eventSelectedDate == null || eventSelectedTime == null) return 0;
    DateTime date = DateTime(
      eventSelectedDate!.year,
      eventSelectedDate!.month,
      eventSelectedDate!.day,
      eventSelectedTime!.hour,
      eventSelectedTime!.minute,
    );

    return date.microsecondsSinceEpoch;
  }
}
