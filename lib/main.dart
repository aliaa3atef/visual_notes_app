import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:visual_notes_app/layout/visualNotesHome/homeLayout.dart';
import 'package:visual_notes_app/shared/styles/colors.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          dividerTheme: DividerThemeData(
            color: colorApp,
            thickness: 1,
          ),
          primarySwatch: colorApp,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme (
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: colorApp,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              elevation: 50,
              backgroundColor: Colors.white)),
      darkTheme: ThemeData(
        textTheme:  TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: colorApp,
          thickness: 1,
        ),
        primarySwatch: colorApp,
        scaffoldBackgroundColor: HexColor('33312b'),
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor('33312b'),
          elevation: 0,
          actionsIconTheme: IconThemeData(color: colorApp),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
          backwardsCompatibility: false,
          systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor: HexColor('33312b'),
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: colorApp,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 50,
          backgroundColor: HexColor('33312b'),
        ),
      ),
      themeMode: ThemeMode.dark,
      home:  HomeLayout(),
    );
  }
}

