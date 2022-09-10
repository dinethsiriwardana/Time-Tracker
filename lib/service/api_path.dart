import 'package:timetracker/service/model/datetimemodel.dart';

String year = dateTimeNow("yyyy");

class APIPath {
  static String wdatapath(String date, String userID) =>
      '/users/$userID/$year/$date';
  static String rdatapath(String userID) => '/users/$userID/$year/';
}
