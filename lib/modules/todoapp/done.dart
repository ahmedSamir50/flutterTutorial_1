import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todoCubit.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todostates.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/NoTasksAddYetComponent.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/constants.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/screen_of_tasks_body_separated_list.component.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/helpers.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

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
              .where((element) => element.state == TODOAPPTASKStatuses.DONE)
              .toList();
          if (listOfTasks.isEmpty) {
            return const NoTasksAddYetComponent();
          }
          return ScreenOfTasksBodySeparatedList(
              listOfTasks: listOfTasks, cubit: cubit);
        },
        listener: (context, state) => {});
  }
}
