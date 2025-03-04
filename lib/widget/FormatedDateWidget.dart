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
}
