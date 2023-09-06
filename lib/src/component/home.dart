import 'package:flutter/material.dart';
import 'package:images_test/src/component/search.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/resources/text.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../redux/app_action.dart';
import '../redux/app_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final store = Store(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              UIText.applicationTitle,
              style: optionStyle,
            ),
          ),
          body: const Search(),
        ));
  }
}
