import 'package:flutter/material.dart';
import 'package:untitled1/modules/todoapp/archived.dart';
import 'package:untitled1/modules/todoapp/done.dart';
import 'package:untitled1/modules/todoapp/tasks.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/netwok/local/sqlitedb/todo/db_handeler.dart';
import 'package:intl/intl.dart';
class TodoHomeLayOut extends StatefulWidget {
  const TodoHomeLayOut({Key? key}) : super(key: key);

  @override
  State<TodoHomeLayOut> createState() => _TodoHomeLayOutState();
}

class _TodoHomeLayOutState extends State<TodoHomeLayOut> {
  int currentPageIdx = 0;
  List<Widget> screens = const [NewTasks(), DoneTasks(), ArchivedTasks()];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var newFrmKey = GlobalKey<FormState>();
  bool bottomSheetOpen = false;
  IconData addingButtonIcon = Icons.edit;
  var newTaskController = TextEditingController();
  var newTaskDateController = TextEditingController();
  var newTaskTimeController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    ToDoAppDbAHandler.CreateToDoDB(context);
    ToDoAppDbAHandler.GetAllTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Builder(builder:(context)=>  Scaffold(
        key: scaffoldKey,
        body: screens[currentPageIdx],
        appBar: AppBar(
          title: Text((screens[currentPageIdx].runtimeType).toString()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()  {
            if (!bottomSheetOpen) {
              setState(() {
                addingButtonIcon = Icons.save;
                bottomSheetOpen = true;
              });
              //ToDoAppDbAHandler.InsertNewTask("Demo Task 1 ");
              if(scaffoldKey.currentState !=null) {
                scaffoldKey.currentState!.showBottomSheet(
                        (context) =>
                        Container(
                          color: Colors.greenAccent,
                          height: 200,
                          padding:  const EdgeInsets.all(10),
                          child: Form(
                            key: newFrmKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //#region text
                                defaultTextInput(fromController: newTaskController,
                                    keyboardType: TextInputType.text,
                                    hint: "New TODO Task",
                                    label: "Adding New TODO Task",
                                    validationCallBack: (String? val){
                                      if(val == null ||val.isEmpty){
                                        return "Please add task title";
                                      }
                                      return null;
                                    },
                                    onFieldSubmit: (String val){
                                      newTaskController.text = val;
                                    }
                                ),
                                //#endregion
                                const SizedBox(height:  15),
                                //TIME
                               Row(
                                 children: [
                                   Expanded(child:                                    defaultTextInput(fromController: newTaskDateController,
                                       keyboardType: TextInputType.none,
                                       hint: "TODO Task Time",
                                       label: "New TODO Task Time",
                                       validationCallBack: (String? val){
                                         if(val == null ||val.isEmpty){
                                           return "Please add task Date";
                                         }
                                         return null;
                                       },
                                       onFieldSubmit: (String val){
                                         newTaskController.text = val;
                                       },
                                       prefixIcon: Icons.calendar_month,
                                       onTap: (){
                                         showDatePicker(context: context,
                                             initialDate: DateTime.now(),
                                             firstDate: DateTime.now(),
                                             lastDate: DateTime.now()
                                                 .add(const Duration(days: 365))
                                         ).then(( DateTime? value){
                                           print("D"+DateFormat("dd/MM/yyyy").format(value!));
                                           newTaskDateController.text =
                                               DateFormat("dd/MM/yyyy").format(value);
                                         });
                                       }
                                   )),
                                   Expanded(child: defaultTextInput(fromController: newTaskTimeController,
                                       keyboardType: TextInputType.none,
                                       hint: "TODO Task Time",
                                       label: "New TODO Task Time",
                                       validationCallBack: (String? val){
                                         if(val == null ||val.isEmpty){
                                           return "Please add task Time";
                                         }
                                         return null;
                                       },
                                       onFieldSubmit: (String val){
                                         newTaskController.text = val;
                                       },
                                       prefixIcon: Icons.alarm,
                                       onTap: (){
                                         showTimePicker(context: context,
                                           initialTime: TimeOfDay.now(),
                                         ).then(( TimeOfDay? value){
                                           print(value);
                                           newTaskTimeController.text =value!.format(context).toString();
                                         });
                                       }
                                   ))
                                 ],
                               )
                              ],
                            ),
                          ),
                        )).closed.then((closed)=>{
                          setState(() {
                              addingButtonIcon = Icons.edit;
                              bottomSheetOpen = false;
                }
                )}
                );
              }
            } else {
              if(newFrmKey.currentState!=null && newFrmKey.currentState!.validate()){
                ToDoAppDbAHandler.InsertNewTask(newTaskController.text,
                                                 newTaskDateController.text,
                    newTaskTimeController.text).then((value) =>
                    print("Inserted : "+(value.toString()))
                );
                Navigator.of(context).pop();
                setState(() {
                  addingButtonIcon = Icons.edit;
                  bottomSheetOpen = false;
                });
              }
            }
          },
          child: Icon(addingButtonIcon),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (pageIdx) => {
            setState(() {
              currentPageIdx = pageIdx;
            })
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black54,
          showSelectedLabels: true,
          currentIndex: currentPageIdx,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.checklist), label: "Tasks"),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done"),
            BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive")
          ],
        ),
      )),
    );
  }
}
