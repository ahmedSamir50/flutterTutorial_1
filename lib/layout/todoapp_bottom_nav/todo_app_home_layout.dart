import 'package:flutter/material.dart';
import 'package:untitled1/modules/todoapp/archived.dart';
import 'package:untitled1/modules/todoapp/done.dart';
import 'package:untitled1/modules/todoapp/tasks.dart';
import 'package:untitled1/shared/netwok/local/sqlitedb/todo/db_handeler.dart';

class TodoHomeLayOut extends StatefulWidget {
  const TodoHomeLayOut({Key? key}) : super(key: key);

  @override
  State<TodoHomeLayOut> createState() => _TodoHomeLayOutState();
}

class _TodoHomeLayOutState extends State<TodoHomeLayOut> {

  int currentPageIdx = 0;
  List<Widget> screens = [ NewTasks(),DoneTasks(), ArchivedTasks()];
  @override
  void initState() {
    // TODO: implement initState
     ToDoAppDbAHandler.CreateToDoDB(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens[currentPageIdx],
        appBar: AppBar(
          title: Text((screens[currentPageIdx].runtimeType).toString()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()async => {
            ToDoAppDbAHandler.InsertNewTask("Demo Task 1 ")
          },
          child: Icon(Icons.add),
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
      ),
    );
  }
}
