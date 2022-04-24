import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/newsapp/news_cubit.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/newsapp/news_statuses.dart';
import 'package:my_flutter_tutorial_learn1/shared/themes/newsapp_themes.dart';

class NewsAppLayout extends StatelessWidget {
  NewsAppLayout({Key? key}) : super(key: key);
  var darkThemeMainColor = HexColor('333739');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return NewsAppCubit();
          }),
          BlocProvider(create: (context) {
            return NewsAppCubit();
          })
        ],
        child: BlocConsumer<NewsAppCubit, NewsBaseState>(
          builder: (ctx, state) {
            INewsAppCubit cubit = NewsAppCubit.getCubitInstance(ctx);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "News App 📰",
              home: Directionality(
                child: Builder(builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      elevation: 0.0,
                      actions: [
                        IconButton(
                            onPressed: () {
                              cubit.isFirstCallMade = false;
                              cubit.changeCurrentViewIndex(idx: 3);
                            },
                            icon: const Icon(Icons.search_rounded)),
                        IconButton(
                            onPressed: () {
                              cubit.toggleAppTheme();
                            },
                            icon: const Icon(Icons.brightness_4_sharp))
                      ],
                      // TODO
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 2000),
                        child: Text(cubit.appTitle),
                        opacity: cubit.appIsLoading ? 0 : 1.0,
                      ),
                    ),
                    bottomNavigationBar: getNewsNavBar(ctx, cubit),
                    body: getGeneratedBody(cubit),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () => {cubit.getCurrentScreen()},
                      child: const Icon(Icons.refresh),
                    ),
                  );
                }),
                textDirection: TextDirection.ltr,
              ),
              theme: getAppNormalTheme(),
              darkTheme: getAppDarkThem(),
              themeMode:
                  cubit.appThemeIsDark ? ThemeMode.dark : ThemeMode.light,
            );
          },
          listener: (ctx, state) {},
        ));
  }

  Widget getGeneratedBody(INewsAppCubit cubit) {
    return !cubit.appHasError
        ? cubit.appIsLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.red,
              ))
            : cubit.getCurrentScreen()
        : Center(
            child: SingleChildScrollView(
            child: Text(
              cubit.appErrorString,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w800),
            ),
          ));
  }

  Widget getNewsNavBar(BuildContext ctx, INewsAppCubit cubit) {
    return BottomNavigationBar(
        // for mor than 3 items
        type: BottomNavigationBarType.fixed,
        currentIndex: cubit.currentAppScreenIdx,
        elevation: 20,
        backgroundColor: Colors.black,
        onTap: (idx) {
          cubit.changeCurrentViewIndex(idx: idx);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: "BUSINESS",
              activeIcon: Icon(Icons.business_center)),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_volleyball_sharp),
              label: "SPORTS",
              activeIcon: Icon(Icons.sports)),
          BottomNavigationBarItem(
              icon: Icon(Icons.science),
              label: "SCIENCE",
              activeIcon: Icon(Icons.science_outlined)),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_off),
              label: "Search",
              activeIcon: Icon(Icons.search_off_sharp)),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "SETTINGS",
              activeIcon: Icon(Icons.settings_applications)),
        ]);
  }
}
