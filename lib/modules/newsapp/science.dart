import 'package:flutter/material.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/build_news_screen.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/constants.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BuildNewsScreen(NewsCategories.Science);
  }
}
