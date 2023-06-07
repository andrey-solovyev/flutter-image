import 'package:flutter/material.dart';
import 'package:images_test/src/component/Home.dart';

// void main() => runApp(AskInput());

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MaterialApp(home: Home()));
}

// class MyApp extends StatelessWidget {
//
//   static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//   static FirebaseAnalyticsObserver observer = new FirebaseAnalyticsObserver(analytics: analytics);
//
//   static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
//
//   @override
//   Widget build(BuildContext context) {
//
//     // GetMaterialApp
//     return GetMaterialApp(
//       title: 'Crowtor',
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       initialRoute: "/",
//       routes: {
//         '/': (context) => Home(),
//         // '/feed': (context) => Home(),
//         // '/createTweet': (context) => AddNewTweetScreen(initialText: "",),
//       },
//       navigatorObservers: [
//         observer,
//       ],
//       // navigatorKey: navigatorKey,
//     );
//   }
// }
