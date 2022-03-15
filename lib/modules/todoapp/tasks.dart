import 'package:flutter/material.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';

class NewTasks extends StatelessWidget {
  List<TODOModel> listOfTasks = [];

  NewTasks(this.listOfTasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listOfTasks.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Text("No Tasks Added yet ...."),
        ),
      );
    }
    listOfTasks = listOfTasks.where((element) => element.state == TODOAPPTASKStatuses.CREATED).toList();
    return ListView.separated(
        itemBuilder: (ctx, idx) {
          return todoModelWidgetBuilder(listOfTasks[idx]);
        },
        separatorBuilder: (ctx, idx) {
          return Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[500],
          );
        },
        itemCount: listOfTasks.length);
  }
}
