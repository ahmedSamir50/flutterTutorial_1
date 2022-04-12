import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_flutter_tutorial_learn1/layout/news_app/news_app_layout.dart';
import 'package:my_flutter_tutorial_learn1/layout/todoapp_bottom_nav/todo_app_home_layout.dart';
import 'package:my_flutter_tutorial_learn1/modules/bmi/BMIApp.dart';
import 'package:my_flutter_tutorial_learn1/modules/login/LogInScreen.dart';
import 'package:my_flutter_tutorial_learn1/modules/messenger/MessengerHomeScreen.dart';
import 'package:my_flutter_tutorial_learn1/modules/shopping/onboarding.dart';
import 'package:my_flutter_tutorial_learn1/shared/dependency_injection.dart';

class ModulesSwitcher extends StatelessWidget {
  const ModulesSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "All Tutorial Apps Navigator 📰",
      home: Directionality(
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                getShoppingApp(context),
                getNewsApp(context),
                getTodoApp(context),
                getMessengerApp(context),
                getLoginExample(context),
                getBmiApp(context)
              ],
            ),
          );
        }),
        textDirection: TextDirection.ltr,
      ),
      theme: getThemeData(context),
      darkTheme: ThemeData(
        textTheme: const TextTheme(
            bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
        scaffoldBackgroundColor: HexColor('333739'),
        primarySwatch: Colors.deepOrange,
        backgroundColor: HexColor('333739'),
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white, size: 40),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
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
      ),
      themeMode: ThemeMode.dark,
    );
  }

  ThemeData getThemeData(BuildContext context) {
    return ThemeData(
      // used by Theme.of(context).textTheme.bodyText1
      textTheme: const TextTheme(
          bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87)),
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
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
    );
  }

  Widget getShoppingApp(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            DI().setup(DIApps.ShoppingApp);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OnBoardingScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Container(
              child: Row(
                children: const [
                  Text("Shopping App Example", style: TextStyle(fontSize: 22)),
                  SizedBox( width: 30),
                  Icon(Icons.shopping_cart)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: 80,
            )),
          )),
    );
  }

  Widget getNewsApp(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            DI().setup(DIApps.NewsApp);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewsAppLayout()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Container(
              child: Row(
                children: const [
                  Text("News App Example", style: TextStyle(fontSize: 22)),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(Icons.newspaper)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: 80,
            )),
          )),
    );
  }

  Widget getBmiApp(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const BMIApp()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Container(
              child: Row(
                children: const [
                  Text("BMI App Example", style: TextStyle(fontSize: 22)),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(Icons.accessibility)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: 80,
            )),
          )),
    );
  }

  Widget getLoginExample(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginScreenStateFul()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Container(
              child: Row(
                children: const [
                  Text("Login Screen Example", style: TextStyle(fontSize: 22)),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(Icons.login_rounded)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: 80,
            )),
          )),
    );
  }

  Widget getMessengerApp(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MessengerHomeScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Container(
              child: Row(
                children: const [
                  Text("Messenger App Example", style: TextStyle(fontSize: 22)),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(Icons.messenger)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: 80,
            )),
          )),
    );
  }

  Widget getTodoApp(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TodoHomeLayOut()));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Container(
              child: Row(
                children: const [
                  Text("TODO App Example", style: TextStyle(fontSize: 22)),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(Icons.task_sharp)
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              height: 80,
            )),
          )),
    );
  }
}
