import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todoCubit.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/todo/todostates.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/components.dart';

class TodoHomeLayOut extends StatelessWidget {
  TodoHomeLayOut({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var newFrmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return BlocProvider(
          create: (BuildContext context) => TODOAppCubit(),
          child: BlocConsumer<TODOAppCubit, TODOStateBase>(
            builder: (context, state) {
              //printOnyOnDebugMode([state]);
              TODOAppCubit cubitState = TODOAppCubit.getCubitOfTodo(context);
              return Scaffold(
                key: scaffoldKey,
                body: !cubitState.loadingData
                    ? cubitState.screens[cubitState.currentPageIdx]
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.blue)),
                appBar: AppBar(
                  title: Text(getScreenRuntimeTypeName(cubitState)),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    if (!cubitState.bottomSheetOpen) {
                      cubitState.changingBottomSheetState(
                          isBottomSheetOpen: true);
                      if (scaffoldKey.currentState != null) {
                        scaffoldKey.currentState!
                            .showBottomSheet((context) => Container(
                                  color: Colors.greenAccent,
                                  height: 200,
                                  padding: const EdgeInsets.all(10),
                                  child: buildNewTaskForm(context, cubitState),
                                ))
                            .closed
                            .then((closed) {
                          cubitState.changingBottomSheetState(
                              isBottomSheetOpen: false);
                        });
                      }
                    } else {
                      if (newFrmKey.currentState != null &&
                          newFrmKey.currentState!.validate()) {
                        insertNewTaskAndSetState(context, cubitState);
                      }
                    }
                  },
                  child: Icon(cubitState.addingButtonIcon),
                ),
                bottomNavigationBar: buildBottomNavigationBar(cubitState),
              );
            },
            listener: (BuildContext context, state) => {
              //printOnyOnDebugMode([state])
            },
          ),
        );
      }),
    );
  }

  String getScreenRuntimeTypeName(TODOAppCubit cubitState) =>
      (cubitState.screens[cubitState.currentPageIdx].runtimeType).toString();

  Widget buildNewTaskForm(BuildContext context, TODOAppCubit cubitState) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Form(
              key: newFrmKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //#region text
                  buildDefaultTextInputForTodoTitle(cubitState),
                  //#endregion
                  const SizedBox(height: 15),
                  //TIME
                  Row(
                    children: [
                      Expanded(
                          child: buildDefaultTextInputForTodoDateField(
                              context, cubitState)),
                      Expanded(
                          child: buildDefaultTextInputForTaskTime(
                              context, cubitState))
                    ],
                  )
                ],
              ))),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(TODOAppCubit cubitState) {
    return BottomNavigationBar(
      onTap: (pageIdx) {
        cubitState.changeCurrentViewIndex(idx: pageIdx);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black54,
      showSelectedLabels: true,
      currentIndex: cubitState.currentPageIdx,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.checklist), label: "Tasks"),
        BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done"),
        BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive")
      ],
    );
  }

  void insertNewTaskAndSetState(BuildContext context, TODOAppCubit cubitState) {
    cubitState.insertNewTask();
    Navigator.of(context).pop();
    cubitState.changingBottomSheetState(isBottomSheetOpen: false);
  }

  Widget buildDefaultTextInputForTaskTime(
      BuildContext context, TODOAppCubit cubitState) {
    return defaultTextInput(
        fromController: cubitState.todoFormController.newTaskTimeController,
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
          cubitState.todoFormController.newTaskTimeController.text = val;
        },
        prefixIcon: Icons.alarm,
        onTap: () {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((TimeOfDay? value) {
            cubitState.todoFormController.newTaskTimeController.text =
                value!.format(context).toString();
          });
        });
  }

  Widget buildDefaultTextInputForTodoDateField(
      BuildContext context, TODOAppCubit cubitState) {
    return defaultTextInput(
        fromController: cubitState.todoFormController.newTaskDateController,
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
          cubitState.todoFormController.newTaskDateController.text = val;
        },
        prefixIcon: Icons.calendar_month,
        onTap: () {
          showADatePickerForNewTodo(context, cubitState);
        });
  }

  Widget buildDefaultTextInputForTodoTitle(TODOAppCubit cubitState) {
    return defaultTextInput(
        fromController: cubitState.todoFormController.newTaskTitleController,
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
          cubitState.todoFormController.newTaskTitleController.text = val;
        });
  }

  Future showADatePickerForNewTodo(
      BuildContext context, TODOAppCubit cubitState) {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)))
        .then((DateTime? value) {
      cubitState.todoFormController.newTaskDateController.text =
          DateFormat("dd/MM/yyyy").format(value!);
    });
  }
}
