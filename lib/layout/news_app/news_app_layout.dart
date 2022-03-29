import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/shared/bloc/newsapp/news_cubit.dart';
import 'package:untitled1/shared/bloc/newsapp/news_statuses.dart';

class NewsAppLayout extends StatelessWidget {
  const NewsAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App 📰",
      home: Builder(builder: (context) {
        return BlocProvider(
          create: (createCtx) => NewsAppCubit(),
          child: BlocConsumer<NewsAppCubit, NewsBaseState>(
            builder: (ctx, state) {
              INewsAppCubit cubit = NewsAppCubit.getCubitInstance(ctx);
              return Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  actions: [
                    IconButton(onPressed: (){

                    }, icon: const Icon(Icons.search_rounded))
                  ],
                  // TODO
                  title:  AnimatedOpacity(
                    duration: const Duration( milliseconds: 2000), child: Text(cubit.appTitle) ,
                    opacity:cubit.appIsLoading?0:1.0 ,
                  ) ,
                ),
                bottomNavigationBar: getNewsNavBar(ctx, cubit),
                body:  cubit.getCurrentScreen(),
                floatingActionButton: FloatingActionButton(
                  onPressed: ()=>{
                    cubit.getNews()
                  },
                  child: const Icon(Icons.refresh),
                ),
              );
            },
            listener: (ctx, state) {},
          ),
        );
      }),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black87,size: 40),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarDividerColor: Colors.red
          ),
          backgroundColor: Colors.white70 ,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black , fontWeight: FontWeight.bold ,fontSize: 20)
        ) ,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 40,
          showSelectedLabels: true,
          selectedIconTheme: IconThemeData(
            color: Colors.deepOrange
          ),
          selectedItemColor:Colors.deepOrange,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white
        )
      ),
    );
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
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "BUSINESS" ,activeIcon: Icon(Icons.business_center)),
          BottomNavigationBarItem(icon: Icon(Icons.sports_volleyball_sharp), label: "SPORTS",activeIcon: Icon(Icons.sports)),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: "SCIENCE",activeIcon: Icon(Icons.science_outlined)),
          BottomNavigationBarItem( icon: Icon(Icons.settings), label: "SETTINGS" ,activeIcon: Icon(Icons.settings_applications)),
        ]);
  }
}
