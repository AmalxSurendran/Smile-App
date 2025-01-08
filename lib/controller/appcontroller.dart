import 'package:get/get.dart';

class AppointmentController extends GetxController {
  Rx<DateTime> selectedDay = DateTime.now().obs;

  // Method to update the selected day
  void updateSelectedDay(DateTime day) {
    selectedDay.value = day;
  }

  String _getWeekDayName(DateTime day) {
    List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekDays[day.weekday % 7];
  }

  // Public method to access _getWeekDayName
  String getWeekDayNamePublic(DateTime day) {
    return _getWeekDayName(day);
  }
}
