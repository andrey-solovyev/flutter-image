import 'dart:async';
import 'dart:html';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_test/src/ImageModel.dart';
import 'package:images_test/src/component/ImageWidget.dart';
import 'package:images_test/src/component/UpdateStreamEvent.dart';
import 'package:images_test/src/redux/model_action.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../redux/app_action.dart';
import '../redux/app_state.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textController = TextEditingController();
  bool isSearched = false;
  final PagingController<int, ImageModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      var store = StoreProvider.of<AppState>(context);
      store.dispatch(fetchImages);
      _pagingController.appendPage(store.state.images, store.state.page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return ListView(
            children: [
              Form(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: TextFormField(
                        controller: textController,
                        // controller: emailController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Поиск",
                            hintText: "Введите интересующий вас запрос"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите запрос';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Text("Найти фотографии"),
                            onPressed: () {
                              var store = StoreProvider.of<AppState>(context);
                              store.dispatch(FetchImagesAction(
                                  [], 1, textController.text));
                              store.dispatch(fetchImages);
                              isSearched = true;
                            },
                            style: ElevatedButton.styleFrom(),
                          )),
                    ),
                  ],
                ),
              ),
              isSearched ? build_two(context, state) : const Text(""),
            ],
          );
        });
  }

  Widget buildTweets(BuildContext context) {
    return PagedListView<int, ImageModel>(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<ImageModel>(
        itemBuilder: (context, item, index) => ImageWidget(
          imageModel: item,
        ),
      ),
    );
  }

  Widget build_two(BuildContext context, AppState state) {
    return new ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: state.images.length,
        itemBuilder: (context, i) {
          print(i);
          if (state.images.length - 2 == i) {
            var store = StoreProvider.of<AppState>(context);
            store.dispatch(fetchImages);
          }
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: ImageWidget(
              imageModel: state.images[i],
            ),
          );
        });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
