import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/bloc/newsapp/news_cubit.dart';
import 'package:untitled1/shared/bloc/newsapp/news_statuses.dart';
import 'package:untitled1/shared/components/components.dart';
import 'package:untitled1/shared/components/constants.dart';

@immutable
class BuildNewsScreen extends StatelessWidget {
  final NewsCategories category;

  const BuildNewsScreen(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsAppCubit, NewsBaseState>(
        builder: (context, state) {
          var cubit = NewsAppCubit.getCubitInstance(context);
          var listOfScreenNews = getNews(cubit);
          if (listOfScreenNews.isEmpty) {
            if (category == NewsCategories.Any) {
              return Column(
                children: [
                  defaultTextInput(
                      fromController: searchController,
                      keyboardType: TextInputType.text,
                      hint: "Search",
                      onChange: (String? valu) {
                        print("Text : " + (valu ?? ""));
                      },
                      prefixIcon: Icons.search,
                      suffixIcon: Icons.newspaper,
                      onFieldSubmit: (String? valu) {
                        if (valu != null && valu.length > 3) {
                          cubit.getNewsForSearch(valu);
                        }
                      },
                      label: "Searching.....",
                      validationCallBack: (String? val) {
                        if (val == null || val.length < 3) {
                          return "Please add more characters";
                        }
                        return null;
                      }),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text("Try Searching For ...."),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text("No News for Today...."),
                ),
              );
            }
          }
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (ctx, idx) {
                return newsModelWidgetBuilder(
                    listOfScreenNews[idx], cubit, context);
              },
              separatorBuilder: (ctx, idx) {
                return Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.blue[900],
                );
              },
              itemCount: listOfScreenNews.length);
        },
        listener: (context, state) => {});
  }

  List getNews(NewsAppCubit cubit) {
    return category == NewsCategories.Business
        ? cubit.businessNewsResults?.articles ?? []
        : category == NewsCategories.Science
            ? cubit.scienceNewsResults?.articles ?? []
            : category == NewsCategories.Sports
                ? cubit.sportsNewsResults?.articles ?? []
                : cubit.searchNewsResults?.articles ?? [];
  }
}
