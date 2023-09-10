import 'package:flutter/material.dart';
import 'package:images_test/src/component/search.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/resources/styles.dart';
import 'package:images_test/src/resources/text.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../redux/app_action.dart';
import '../redux/app_state.dart';
import '../resources/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final store = Store(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: Scaffold(
          backgroundColor: UIColors.background,
          appBar: AppBar(
            backgroundColor: UIColors.appBarBackground,
            title: const Text(
              UIText.applicationTitle,
              style: UIStyles.optionStyle,
            ),
          ),
          body: const Search(),
        ));
  }
}
