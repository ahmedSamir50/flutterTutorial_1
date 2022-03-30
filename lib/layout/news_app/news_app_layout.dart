import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled1/shared/bloc/newsapp/news_cubit.dart';
import 'package:untitled1/shared/bloc/newsapp/news_statuses.dart';

class NewsAppLayout extends StatelessWidget {
   NewsAppLayout({Key? key}) : super(key: key);
  var  darkThemeMainColor = HexColor('333739');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (createCtx) => NewsAppCubit(),
        child: BlocConsumer<NewsAppCubit, NewsBaseState>(
          builder: (ctx, state) {
            INewsAppCubit cubit = NewsAppCubit.getCubitInstance(ctx);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "News App 📰",
              home: Directionality(child: Builder(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    actions: [
                      IconButton(
                          onPressed: () {
                            cubit.isFirstCallMade = false;
                            cubit.getCurrentScreen();
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
              theme: ThemeData(
                // used by Theme.of(context).textTheme.bodyText1
                  textTheme: const TextTheme(
                      bodyText1:TextStyle(fontSize: 18 , fontWeight: FontWeight.w600 , color: Colors.black87)
                  ),
                  primarySwatch: Colors.deepOrange,
                  backgroundColor: Colors.white,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.black87, size: 40),
                      systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: Colors.black,
                          systemNavigationBarColor: Colors.black,
                          systemNavigationBarDividerColor: Colors.red),
                      backgroundColor: Colors.white70,
                      elevation: 0,
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                      elevation: 40,
                      showSelectedLabels: true,
                      selectedIconTheme: IconThemeData(color: Colors.deepOrange),
                      selectedItemColor: Colors.deepOrange,
                      showUnselectedLabels: true,
                      unselectedItemColor: Colors.white)),
              darkTheme: ThemeData(
                textTheme: const TextTheme(
                    bodyText1:TextStyle(fontSize: 18 , fontWeight: FontWeight.w600 , color: Colors.white)
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                backgroundColor: HexColor('333739'),
                appBarTheme:  AppBarTheme(
                    iconTheme: const IconThemeData(color: Colors.white, size: 40),
                    systemOverlayStyle:  SystemUiOverlayStyle(
                        statusBarColor: darkThemeMainColor,
                        statusBarIconBrightness: Brightness.light,
                        systemNavigationBarColor: Colors.white,
                        statusBarBrightness: Brightness.light,
                        systemNavigationBarDividerColor: Colors.red),
                    backgroundColor: Colors.black54,
                    elevation: 0,
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.black87,
                    elevation: 40,
                    showSelectedLabels: true,
                    selectedIconTheme: IconThemeData(color: Colors.deepOrange),
                    selectedItemColor: Colors.deepOrange,
                    showUnselectedLabels: true,
                    unselectedItemColor: Colors.white),
              ),
              themeMode: cubit.appThemeIsDark?ThemeMode.dark:ThemeMode.light,
            );
          },
          listener: (ctx, state) {},
        )
    );
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
              icon: Icon(Icons.settings),
              label: "SETTINGS",
              activeIcon: Icon(Icons.settings_applications)),
        ]);
  }


}
