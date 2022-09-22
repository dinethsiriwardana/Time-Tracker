// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

String dateTimeNow(String format) {
  var datetimeformatter = DateFormat(format);
  var datetimeformatted = datetimeformatter.format(DateTime.now());
  return datetimeformatted;
}
