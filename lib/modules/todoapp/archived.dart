import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todoCubit.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todostates.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/components.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/constants.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/helpers.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  static bool firstCallMade = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TODOAppCubit, TODOStateBase>(
        builder: (context, state) {
          var cubit = TODOAppCubit.getCubitOfTodo(context);
          if (!firstCallMade) {
            cubit.getAllTodos();
            firstCallMade = true;
            printOnyOnDebugMode(["Called : ", firstCallMade]);
          }
          var listOfTasks = cubit.todosModelList;
          printOnyOnDebugMode([cubit.todosModelList]);
          listOfTasks = listOfTasks
              .where((element) => element.state == TODOAPPTASKStatuses.ARCHIVED)
              .toList();
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
                return todoModelWidgetBuilder(listOfTasks[idx], cubit);
              },
              separatorBuilder: (ctx, idx) {
                return Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey[500],
                );
              },
              itemCount: listOfTasks.length);
        },
        listener: (context, state) => {});
  }
}
