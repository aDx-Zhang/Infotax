import 'package:intl/intl.dart';

equalsIgnoreCase(String string1) {
  return string1.toLowerCase();
}

formatDate(date) {
  var dateTime = DateTime.parse("$date");
  var stdTime = DateFormat('MMM d, yy hh:mm a').format(dateTime).toString();
  return stdTime;
}

formatDate2(date) {
  print(date);
  if (date == "00-00-0000 00:00:00") {
    return "";
  } else {
    var dateTime = DateTime.parse("$date");
    var stdDate = DateFormat("MMM d, yy hh:mm a").format(dateTime).toString();
    print(stdDate);
    return stdDate;
  }
}
