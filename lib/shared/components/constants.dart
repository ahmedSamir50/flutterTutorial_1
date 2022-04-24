import 'package:intl/intl.dart';

enum TODOAPPTASKStatuses {
  // ignore: constant_identifier_names
  CREATED,
  DONE,
  ARCHIVED,
  DELETED,
  UNKNOWN
}
enum NewsCategories { Business, Sports, Social, Science, Any }

formatDateToTimeOnly(DateTime dateTime) {
  DateFormat dateFormat = DateFormat.Hm();
  return dateFormat.format(dateTime);
}

formatDateToFormatedDate(DateTime dateTime) {
  DateFormat dateFormat = DateFormat.yMMMd();
  return dateFormat.format(dateTime);
}

const tasksTableCreationStatement = '''
         CREATE TABLE IF NOT EXISTS Tasks
          (id INTEGER PRIMARY KEY, title TEXT, 
          timeOfCreation TEXT, LastStateTime TEXT ,
          state INTEGER)
          ''';
