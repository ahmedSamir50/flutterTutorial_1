


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/bloc/newsapp/news_cubit.dart';
import 'package:untitled1/shared/bloc/newsapp/news_statuses.dart';
import 'package:untitled1/shared/components/components.dart';

class BusinessScreen extends StatelessWidget{
   const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  BlocConsumer<NewsAppCubit , NewsBaseState>(builder: (context , state){
      var cubit = NewsAppCubit.getCubitInstance(context);
      var listOfScreenNews = cubit.newsResults?.articles??[];

      //listOfScreenNews = listOfScreenNews.where((element) => element. == TODOAPPTASKStatuses.ARCHIVED).toList();
      if (listOfScreenNews.isEmpty) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Text("No News Added yet...."),
          ),
        );
      }
      return ListView.separated(
          itemBuilder: (ctx, idx) {
            return newsModelWidgetBuilder(listOfScreenNews[idx] , cubit);
          },
          separatorBuilder: (ctx, idx) {
            return Container(
              height: 1,
              width: double.infinity,
              color: Colors.blue[900],
            );
          },
          itemCount: listOfScreenNews.length);
    }, listener: (context , state)=>{});
  }

}