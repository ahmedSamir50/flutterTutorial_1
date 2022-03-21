import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/shared/bloc/todo/todoCubit.dart';
import 'package:untitled1/shared/bloc/todo/todostates.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/helpers/helpers.dart';

class NewTasks extends StatelessWidget {

  NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TODOAppCubit , TODOStateBase>(builder: (context , state){
      var cubit = TODOAppCubit.getCubitOfTodo(context);
      var listOfTasks = cubit.todosModelList;
      listOfTasks = listOfTasks.where((element) => element.state == TODOAPPTASKStatuses.CREATED).toList();
      printOnyOnDebugMode([" from tasks screen "]);
      printOnyOnDebugMode(listOfTasks);
      if (listOfTasks.isEmpty) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Text("No Tasks Added yet ...."),
          ),
        );
      }
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
    }, listener: (context , state)=>{});
  }
}
