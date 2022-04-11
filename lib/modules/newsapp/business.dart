import 'package:flutter/material.dart';
import 'package:untitled1/shared/components/build_news_screen.dart';
import 'package:untitled1/shared/components/constants.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BuildNewsScreen(NewsCategories.Business);
  }
}
