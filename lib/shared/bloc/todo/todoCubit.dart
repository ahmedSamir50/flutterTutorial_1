import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/modules/todoapp/archived.dart';
import 'package:untitled1/modules/todoapp/done.dart';
import 'package:untitled1/modules/todoapp/tasks.dart';
import 'package:untitled1/shared/bloc/todo/todostates.dart';
import 'package:untitled1/shared/netwok/local/sqlitedb/todo/db_handeler.dart';

class TODOAppCubit extends Cubit<TODOStateBase> {
  List<TODOModel> todosModelList = <TODOModel>[];
  late NewTasks _newTasksScreenRef;

  int currentPageIdx = 0;
  List<Widget> screens = [];
  bool bottomSheetOpen = false;
  IconData addingButtonIcon = Icons.edit;
  late final ToDoAppDbAHandler dbHandler ;

  TODOAppCubit() : super(TODOInitState()) {
    dbHandler = ToDoAppDbAHandler.instance;
    _newTasksScreenRef = NewTasks(todosModelList);
    screens = [_newTasksScreenRef, const DoneTasks(), const ArchivedTasks()];
  }

  static TODOAppCubit getCubitOfTodo(BuildContext context) =>BlocProvider.of(context);

  void changeCurrentViewIndex(int idx) {
    currentPageIdx = idx;
    emit(TodoChangeNaveBarState());
  }

  void insertNewTask(String title, String dt, String time) {
    dbHandler.InsertNewTask(title, dt, time).then((value) {
      emit(TodoInsertIntoDataBaseState());
    }).onError((error, stackTrace) {
      print({error , stackTrace.toString()});
    });
  }

  void getAllTodos() {
    print("gitting");
    dbHandler.GetAllTodos().then((List<TODOModel> value) {
      todosModelList = value;
      print("returned ------------");
      print(todosModelList);
      emit(TodoGetDataDataBaseState());
    }).onError((error, stackTrace) {
      print("****ERROR*****");
      print({error , stackTrace.toString()});
    });
  }

  void checkDbCreated(BuildContext context) {
    emit(TodoCreateDataBaseState());
  }

  void changingBottomSheetState({required bool isBottomSheetOpen}){
     bottomSheetOpen = isBottomSheetOpen;
     addingButtonIcon = !isBottomSheetOpen?Icons.edit:Icons.save;
     emit(TodoBottomSheetState());
  }
}
