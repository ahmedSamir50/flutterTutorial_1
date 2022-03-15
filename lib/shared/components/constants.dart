import 'package:intl/intl.dart';

enum TODOAPPTASKStatuses{
  // ignore: constant_identifier_names
  CREATED , DONE ,ARCHIVED , DELETED , UNKNOWN
}

formatDateToTimeOnly(DateTime dateTime){
  DateFormat dateFormat = DateFormat.Hm();
  return dateFormat.format(dateTime);
}

formatDateToFormatedDate(DateTime dateTime){
  DateFormat dateFormat = DateFormat.yMMMd();
  return dateFormat.format(dateTime);
}