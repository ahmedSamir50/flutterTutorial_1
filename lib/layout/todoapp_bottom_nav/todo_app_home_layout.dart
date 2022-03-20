import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/shared/bloc/todo/todoCubit.dart';
import 'package:untitled1/shared/bloc/todo/todostates.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/netwok/local/sqlitedb/todo/db_handeler.dart';


class TodoHomeLayOut extends StatelessWidget {
  TodoHomeLayOut({Key? key}) : super(key: key);


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var newFrmKey = GlobalKey<FormState>();

  var newTaskController = TextEditingController();
  var newTaskDateController = TextEditingController();
  var newTaskTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
          builder: (context) => BlocProvider(
                 create: (BuildContext context) => TODOAppCubit(),
                  child: BlocConsumer<TODOAppCubit , TODOStateBase>(
                    builder: (context, state) {
                      TODOAppCubit cubitState = TODOAppCubit.getCubitOfTodo(context);
                      cubitState.getAllTodos();
                      return Scaffold(
                        key: scaffoldKey,
                        body: cubitState.todosModelList.isNotEmpty
                            ? cubitState.screens[cubitState.currentPageIdx]
                            : const Center(
                            child: CircularProgressIndicator(color: Colors.blue)),
                        appBar: AppBar(
                          title: Text(getScreenRuntimeTypeName(cubitState)),
                        ),
                        floatingActionButton: FloatingActionButton(
                          onPressed: () {
                            if (!cubitState.bottomSheetOpen) {
                              cubitState.changingBottomSheetState(isBottomSheetOpen:  true);
                              if (scaffoldKey.currentState != null) {
                                scaffoldKey.currentState!
                                    .showBottomSheet((context) => Container(
                                  color: Colors.greenAccent,
                                  height: 200,
                                  padding: const EdgeInsets.all(10),
                                  child: buildNewTaskForm(context),
                                )).closed
                                    .then((closed) {
                                  cubitState.changingBottomSheetState(isBottomSheetOpen:  false);
                                });
                              }
                            } else {
                              if (newFrmKey.currentState != null && newFrmKey.currentState!.validate()) {
                                insertNewTaskAndSetState(context , cubitState);
                              }
                            }
                          },
                          child: Icon(cubitState.addingButtonIcon),
                        ),
                        bottomNavigationBar: buildBottomNavigationBar(cubitState),
                      );
                    },
                    listener: (BuildContext context , state)=>{
                      print(state)
                    },
                  ),
          )
      ),
    );
  }

  String getScreenRuntimeTypeName(TODOAppCubit cubitState) =>
      (cubitState.screens[cubitState.currentPageIdx].runtimeType).toString();

  Form buildNewTaskForm(BuildContext context) {
    return Form(key: newFrmKey, child: Column(
                 mainAxisSize: MainAxisSize.min,
                  children: [
                    //#region text
                    buildDefaultTextInputForTodoTitle(),
                    //#endregion
                    const SizedBox(height: 15),
                    //TIME
                    Row(
                      children: [
                        Expanded(
                            child:
                            buildDefaultTextInputForTodoDateField(
                                context)),
                        Expanded(
                            child:
                            buildDefaultTextInputForTaskTime(
                                context))
                      ],
                    )
                  ],
                ));
  }

  BottomNavigationBar buildBottomNavigationBar(TODOAppCubit cubitState) {
    return BottomNavigationBar(
                onTap: (pageIdx) {
                 cubitState.changeCurrentViewIndex(pageIdx);
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black54,
                showSelectedLabels: true,
                currentIndex: cubitState.currentPageIdx,
                items: const [
                  BottomNavigationBarItem( icon: Icon(Icons.checklist), label: "Tasks"),
                  BottomNavigationBarItem( icon: Icon(Icons.done), label: "Done"),
                  BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive")
                ],
              );
  }

  void insertNewTaskAndSetState(BuildContext context , TODOAppCubit cubitState) {
    cubitState.insertNewTask(newTaskController.text,
        newTaskDateController.text,
        newTaskTimeController.text);

    Navigator.of(context).pop();
    cubitState.getAllTodos();
    cubitState.changingBottomSheetState(isBottomSheetOpen:  false);

  }

  Widget buildDefaultTextInputForTaskTime(BuildContext context) {
    return defaultTextInput(
        fromController: newTaskTimeController,
        keyboardType: TextInputType.none,
        hint: "TODO Task Time",
        label: "New TODO Task Time",
        validationCallBack: (String? val) {
          if (val == null || val.isEmpty) {
            return "Please add task Time";
          }
          return null;
        },
        onFieldSubmit: (String val) {
          newTaskController.text = val;
        },
        prefixIcon: Icons.alarm,
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((TimeOfDay? value) {
            if (kDebugMode) {
              print(value);
            }
            newTaskTimeController.text = value!.format(context).toString();
          });
        });
  }

  Widget buildDefaultTextInputForTodoDateField(BuildContext context) {
    return defaultTextInput(
        fromController: newTaskDateController,
        keyboardType: TextInputType.none,
        hint: "TODO Task Time",
        label: "New TODO Task Time",
        validationCallBack: (String? val) {
          if (val == null || val.isEmpty) {
            return "Please add task Date";
          }
          return null;
        },
        onFieldSubmit: (String val) {
          newTaskController.text = val;
        },
        prefixIcon: Icons.calendar_month,
        onTap: () {
          showADatePickerForNewTodo(context);
        });
  }

  Widget buildDefaultTextInputForTodoTitle() {
    return defaultTextInput(
        fromController: newTaskController,
        keyboardType: TextInputType.text,
        hint: "New TODO Task",
        label: "Adding New TODO Task",
        validationCallBack: (String? val) {
          if (val == null || val.isEmpty) {
            return "Please add task title";
          }
          return null;
        },
        onFieldSubmit: (String val) {
          newTaskController.text = val;
        });
  }

  Future showADatePickerForNewTodo(BuildContext context) {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)))
        .then((DateTime? value) {
      if (kDebugMode) {
        print("D" + DateFormat("dd/MM/yyyy").format(value!));
      }
      newTaskDateController.text = DateFormat("dd/MM/yyyy").format(value!);
    });
  }
}
