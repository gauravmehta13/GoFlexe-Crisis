import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Order/Residential Move.dart';
import 'model/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'noti/notis/ab/abNoti.dart';
import 'noti/importNoti.dart';
import 'redux/reducers.dart';

Future<void> main() async {
  final _initialState = AppState(
      car: false,
      bike: false,
      warehousing: false,
      packingRequirement: false,
      pickupLift: true,
      dropLift: true);
  final Store<AppState> _store =
      Store<AppState>(reducer, initialState: _initialState);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp(store: _store));
}

class MyApp extends StatefulWidget {
  final Store<AppState> store;

  MyApp({this.store});
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Noti noti = AppNoti();

  @override
  void initState() {
    super.initState();
    Future(noti.init);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: MyApp.analytics),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Packers And Movers',
          theme: ThemeData(
              appBarTheme: Theme.of(context)
                  .appBarTheme
                  .copyWith(brightness: Brightness.light),
              textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme,
              ),
              selectedRowColor: Color(0xFF3f51b5),
              primaryColor: Color(0xFF3f51b5),
              accentColor: Color(0xFF3f51b5),
              backgroundColor: Color(0xFF3f51b5),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF3f51b5), // background
                  onPrimary: Colors.white, // foreground
                ),
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: Color(0xFF3f51b5),
              )),
          home: ResidentialMove()),
    );
  }
}
