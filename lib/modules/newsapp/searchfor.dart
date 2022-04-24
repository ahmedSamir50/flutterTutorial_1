import 'package:flutter/material.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/components.dart';

class SearchForScreen extends StatelessWidget {
  const SearchForScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchFieldController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        defaultTextInput(
            fromController: searchFieldController,
            hint: "Search for news ...",
            keyboardType: TextInputType.text,
            isObscureText: false,
            prefixIcon: Icons.search_sharp,
            onFieldSubmit: (String value) {}),
      ]),
    );
  }
}
