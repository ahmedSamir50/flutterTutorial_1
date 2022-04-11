import 'package:flutter/material.dart';
import 'package:untitled1/shared/components/build_news_screen.dart';
import 'package:untitled1/shared/components/constants.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return const BuildNewsScreen(NewsCategories.Sports);
  }
}
