import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/constants.dart';

class TODOModel {
  late int id;
  late String title;
  late DateTime timeOfCreation;
  late DateTime lastStateTime;
  late TODOAPPTASKStatuses state;

  TODOModel(
      this.id, this.title, this.timeOfCreation, this.state, this.lastStateTime);

  TODOModel.fromMap(Map<dynamic, dynamic> mapObj) {
    print(mapObj);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm");
    id = int.parse((mapObj['id'] ?? 0).toString());
    title = (mapObj['title'] ?? "").toString();
    timeOfCreation =
        dateFormat.parse((mapObj['timeOfCreation'] ?? "").toString());
    lastStateTime =
        dateFormat.parse((mapObj['LastStateTime'] ?? "").toString());
    state = (mapObj['state'] ?? TODOAPPTASKStatuses.UNKNOWN).toString() ==
            "TODOAPPTASKStatuses.CREATED"
        ? TODOAPPTASKStatuses.CREATED
        : (mapObj['state'] ?? TODOAPPTASKStatuses.UNKNOWN).toString() ==
                "TODOAPPTASKStatuses.ARCHIVED"
            ? TODOAPPTASKStatuses.ARCHIVED
            : TODOAPPTASKStatuses.DONE;
  }
}

class NewTodoControllerModel {
  TextEditingController newTaskTitleController = TextEditingController();
  TextEditingController newTaskDateController = TextEditingController();
  TextEditingController newTaskTimeController = TextEditingController();
}
