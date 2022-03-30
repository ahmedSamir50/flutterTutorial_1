import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/modules/todoapp/archived.dart';
import 'package:untitled1/modules/todoapp/done.dart';
import 'package:untitled1/modules/todoapp/tasks.dart';
import 'package:untitled1/shared/bloc/todo/todostates.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/helpers/helpers.dart';
import 'package:untitled1/shared/netwok/local/sqlitedb/todo/db_handeler.dart';

class TODOAppCubit extends Cubit<TODOStateBase> {
  List<TODOModel> todosModelList = <TODOModel>[];
  NewTodoControllerModel todoFormController = NewTodoControllerModel();
  int currentPageIdx = 0;
  List<Widget> screens = [];
  bool bottomSheetOpen = false;
  IconData addingButtonIcon = Icons.edit;
  late final ToDoAppDbAHandler dbHandler ;
  bool loadingData = false;
  static bool isFirstGetCallMade = false;
  TODOAppCubit() : super(TODOInitState()) {
    dbHandler = ToDoAppDbAHandler.instance;
    screens = [ NewTasks(), const DoneTasks(), const ArchivedTasks()];
  }

  static TODOAppCubit getCubitOfTodo(BuildContext context) =>BlocProvider.of(context);

  void changeCurrentViewIndex({int idx = 0}) {
    currentPageIdx = idx;
    emit(TodoChangeNaveBarState());
  }

  void insertNewTask() {
    appIsLoading();
    dbHandler.InsertNewTask(todoFormController.newTaskTitleController.text,
        todoFormController.newTaskDateController.text ,
        todoFormController.newTaskTimeController.text).then((value) {
      emit(TodoInsertIntoDataBaseState());
      getAllTodos();
      todoFormController = NewTodoControllerModel();
      appIsLoading();
    }).onError((error, stackTrace) {
      print({error , stackTrace.toString()});
      appIsLoading();
    });
  }

  void getAllTodos() {
    appIsLoading();
    dbHandler.GetAllTodos().then((List<TODOModel> value) {
      todosModelList = value;
      emit(TodoGetDataDataBaseState());
      appIsLoading();
      if(!isFirstGetCallMade){
        isFirstGetCallMade = true;
      }
    }).onError((error, stackTrace) {
      printOnyOnDebugMode(["****ERROR*****"]);
      printOnyOnDebugMode([{error , stackTrace.toString()}]);
      appIsLoading();
    });
  }

  void checkDbCreated(BuildContext context) {
    emit(TodoCreateDataBaseState());
  }

  void changingBottomSheetState({required bool isBottomSheetOpen}){
     bottomSheetOpen = isBottomSheetOpen;
     addingButtonIcon = !isBottomSheetOpen?Icons.edit:Icons.save;
     emit(TodoBottomSheetState());
     print(bottomSheetOpen);
  }

  void appIsLoading(){
    loadingData = !loadingData;
    emit(TodoAppLoadingState());
  }

  void setTaskAsDoneOrAnyOtherState(int id , {TODOAPPTASKStatuses taskNewState = TODOAPPTASKStatuses.DONE} ){
    dbHandler.UpdateTaskStatus(id,taskNewState: taskNewState);
    if(taskNewState == TODOAPPTASKStatuses.ARCHIVED) {
      emit(TodoSetAsArchivedState());
    }
    if(taskNewState == TODOAPPTASKStatuses.DELETED) {
      emit(TodoSetAsDeletedState());
    }
    else
      {
        emit(TodoSetAsDoneState());
      }
    getAllTodos();
  }
  

}
