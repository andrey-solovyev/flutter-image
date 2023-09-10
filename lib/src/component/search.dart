import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_test/src/component/image_list.dart';
import 'package:images_test/src/component/search_widget.dart';
import 'package:images_test/src/redux/app_action.dart';

import '../redux/app_state.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          var store = StoreProvider.of<AppState>(context);
          if (state.images.isEmpty) {
            store.dispatch(fetchImages);
          }
          return ListView(
            shrinkWrap: true,
            children: [
              SearchWidget(),
              const SizedBox(height: 10),
              ImageList(state: state),
            ],
          );
        });
  }
}
