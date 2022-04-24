import 'package:flutter/material.dart';

class NoTasksAddYetComponent extends StatelessWidget {
  const NoTasksAddYetComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(Icons.menu, color: Colors.blueGrey[500], size: 80),
          const Text("No Tasks Added yet ....")
        ],
      ),
    ));
  }
}
