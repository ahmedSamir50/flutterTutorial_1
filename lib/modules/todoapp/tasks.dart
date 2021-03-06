import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todoCubit.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todostates.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/NoTasksAddYetComponent.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/components.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/constants.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/helpers.dart';

class NewTasks extends StatelessWidget {
  static bool firstCallMade = false;

  const NewTasks({Key? key}) : super(key: key);

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
          listOfTasks = listOfTasks
              .where((element) => element.state == TODOAPPTASKStatuses.CREATED)
              .toList();
          if (listOfTasks.isEmpty) {
            return const NoTasksAddYetComponent();
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
