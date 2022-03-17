import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/models/todo_model.dart';
import 'package:untitled1/modules/todoapp/archived.dart';
import 'package:untitled1/modules/todoapp/done.dart';
import 'package:untitled1/modules/todoapp/tasks.dart';
import 'package:untitled1/shared/bloc/todo/todoCubit.dart';
import 'package:untitled1/shared/bloc/todo/todostates.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/netwok/local/sqlitedb/todo/db_handeler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TodoHomeLayOut extends StatelessWidget {
  TodoHomeLayOut({Key? key}) : super(key: key);
  static List<TODOModel> todosModelList = [];
  static NewTasks _newTasksScreenRef = NewTasks(todosModelList);
  int currentPageIdx = 0;
  List<Widget> screens = [_newTasksScreenRef, DoneTasks(), ArchivedTasks()];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var newFrmKey = GlobalKey<FormState>();
  bool bottomSheetOpen = false;
  IconData addingButtonIcon = Icons.edit;
  var newTaskController = TextEditingController();
  var newTaskDateController = TextEditingController();
  var newTaskTimeController = TextEditingController();



  /*
  @override
  void initState() {
    // TODO: implement initState
    ToDoAppDbAHandler.CreateToDoDB(context);
    super.initState();
    ToDoAppDbAHandler.GetAllTodos().then((value) => setState(() {
          todosModelList = value;
          _newTasksScreenRef = NewTasks(todosModelList);
          screens[0] = _newTasksScreenRef;
        }));
  }
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Builder(
          builder: (context) => BlocProvider(
                 create: (BuildContext context) => TODOAppCubit(),
                  child: BlocConsumer<TODOAppCubit , TODOStateBase>(
                    builder: (context, state) => Scaffold(
                      key: scaffoldKey,
                      body: todosModelList.isNotEmpty
                          ? screens[currentPageIdx]
                          : const Center(
                          child: CircularProgressIndicator(color: Colors.blue)),
                      appBar: AppBar(
                        title: Text((screens[currentPageIdx].runtimeType).toString()),
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          if (!bottomSheetOpen) {
                            /*
                      setState(() {
                        addingButtonIcon = Icons.save;
                        bottomSheetOpen = true;
                      });
                       */
                            //ToDoAppDbAHandler.InsertNewTask("Demo Task 1 ");
                            if (scaffoldKey.currentState != null) {
                              scaffoldKey.currentState!
                                  .showBottomSheet((context) => Container(
                                color: Colors.greenAccent,
                                height: 200,
                                padding: const EdgeInsets.all(10),
                                child: buildNewTaskForm(context),
                              ))
                                  .closed
                                  .then((closed) => {
                                /*
                                  setState(() {
                                    addingButtonIcon = Icons.edit;
                                    bottomSheetOpen = false;
                                  })
                               */
                              });
                            }
                          } else {
                            if (newFrmKey.currentState != null && newFrmKey.currentState!.validate()) {
                              insertNewTaskAndSetState(context);
                            }
                          }
                        },
                        child: Icon(addingButtonIcon),
                      ),
                      bottomNavigationBar: buildBottomNavigationBar(),
                    ),
                    listener: (BuildContext context , state)=>{},
                  ),
          )
      ),
    );
  }

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

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
                onTap: (pageIdx) => {
                  /*
                  setState(() {
                    currentPageIdx = pageIdx;
                  })
                   */
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black54,
                showSelectedLabels: true,
                currentIndex: currentPageIdx,
                items: const [
                  BottomNavigationBarItem( icon: Icon(Icons.checklist), label: "Tasks"),
                  BottomNavigationBarItem( icon: Icon(Icons.done), label: "Done"),
                  BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive")
                ],
              );
  }

  void insertNewTaskAndSetState(BuildContext context) {
    ToDoAppDbAHandler.InsertNewTask(
            newTaskController.text,
            newTaskDateController.text,
            newTaskTimeController.text)
        .then((value) =>
            print("Inserted : " + (value.toString())));
    Navigator.of(context).pop();
    ToDoAppDbAHandler.GetAllTodos().then((returnedList) {
      /*
      setState(() {
        addingButtonIcon = Icons.edit;
        bottomSheetOpen = false;
        todosModelList = returnedList;
        _newTasksScreenRef = NewTasks(todosModelList);
         currentPageIdx = 0;
        screens = [_newTasksScreenRef, DoneTasks(), ArchivedTasks()];
      });

       */
    });

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
            print(value);
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
