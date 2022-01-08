import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:visual_notes_app/layout/visualNotesHome/cubit/app_cubit.dart';
import 'package:visual_notes_app/layout/visualNotesHome/homeLayout.dart';
import 'package:visual_notes_app/shared/blocobcerver.dart';
import 'package:visual_notes_app/shared/styles/colors.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getNotes('notes'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          textTheme: const TextTheme(
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
          primarySwatch: Colors.green,
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
      ),
    );
  }
}

