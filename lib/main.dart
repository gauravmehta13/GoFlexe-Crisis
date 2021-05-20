import 'package:crisis/Auth/resgister.dart';
import 'package:crisis/Constants.dart';
import 'package:crisis/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:firebase_core/firebase_core.dart';
import 'redux/reducers.dart';

bool skippedLogin;
Future<void> main() async {
  final _initialState = AppState();
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  skippedLogin = prefs.getBool("skippedLogin");
  print('Skipped Login $skippedLogin');
  runApp(MyApp(store: _store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Crisis GoFlexe',
          theme: ThemeData(
              appBarTheme: Theme.of(context)
                  .appBarTheme
                  .copyWith(brightness: Brightness.light),
              textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme,
              ),
              selectedRowColor: primaryColor,
              primaryColor: primaryColor,
              accentColor: primaryColor,
              backgroundColor: primaryColor,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor, // background
                  onPrimary: Colors.white, // foreground
                ),
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: primaryColor,
              )),
          home: skippedLogin ? HomePage() : RegisterScreen()),
    );
  }
}
