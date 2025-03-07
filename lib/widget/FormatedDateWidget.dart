import 'package:intl/intl.dart';

class Formateddatewidget {
  static String formatedDate(String fdate) {
    try {
      List<String> parts = fdate.split("/");
      DateTime taskdate = DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      DateTime today = DateTime.now();
      return (taskdate.year == today.year &&
              taskdate.month == today.month &&
              taskdate.day == today.day)
          ? 'Today'
          : fdate;
    } catch (e) {
      return "Invalid Date";
    }
  }

  DateTime parseDate(String dateString) {
    try {
      // Check if the string contains only time (e.g., "12:59 AM")
      if (dateString.contains(":") &&
          (dateString.contains("AM") || dateString.contains("PM"))) {
        print("Skipping time-only value: $dateString");
        return DateTime.now(); // Return current date as fallback
      }

      return DateFormat("dd / MM / yyyy").parse(dateString);
    } catch (e) {
      print("Error parsing date: $dateString - $e");
      return DateTime.now(); // Return today's date as fallback
    }
  }
}
