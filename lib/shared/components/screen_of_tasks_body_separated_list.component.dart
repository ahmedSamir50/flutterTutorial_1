import 'package:flutter/material.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/shared/bloc/todo/todoCubit.dart';
import 'package:untitled1/shared/components/components.dart';

class ScreenOfTasksBodySeparatedList extends StatelessWidget {
  const ScreenOfTasksBodySeparatedList({
    Key? key,
    required this.listOfTasks,
    required this.cubit,
  }) : super(key: key);

  final List<TODOModel> listOfTasks;
  final TODOAppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, idx) {
          return todoModelWidgetBuilder(listOfTasks[idx] , cubit);
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