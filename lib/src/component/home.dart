import 'package:flutter/material.dart';
import 'package:images_test/src/component/search.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../redux/app_action.dart';
import '../redux/app_state.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Search(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final store = Store(reducer,
      initialState: AppState.initialState(), middleware: [thunkMiddleware]);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Crowtor"),
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, '/createTweet'),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Лента',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Поиск',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.red,
            onTap: _onItemTapped,
          ),
        ));
  }
}
