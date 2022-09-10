import 'package:intl/intl.dart';

String dateTimeNow(String format) {
  var datetimenow = DateTime.now();
  var datetimeformatter = DateFormat(format);
  var datetimeformatted = datetimeformatter.format(DateTime.now());
  return datetimeformatted;
}
