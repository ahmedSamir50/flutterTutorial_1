import 'package:flutter/material.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TODOModel> models = [TODOModel(0,"title","02:00 PM",TODOAPPTASKStatuses.DONE,DateTime.now().toString())];
    return ListView.separated(itemBuilder: (ctx,idx)=>todoModelWidgetBuilder(models[0]),
        separatorBuilder: (ctx,idx){return Container();},
        itemCount: 10);
  }
}
