import 'dart:async';

import 'package:images_test/src/api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_test/src/ImageModel.dart';
import 'package:images_test/src/component/ImageWidget.dart';
import 'package:images_test/src/component/UpdateStreamEvent.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textController = TextEditingController();
  ApiService apiService = ApiService();
  List<Widget> images = [];
  int currentPage = 1;
  bool isSearched = false;
  String searchText = "";
  final PagingController<int, ImageModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getImages(UpdateStreamEvent(
          tag: searchText, page: currentPage, isRefresh: false));
    });
    super.initState();
  }

  void _setFirstSearch(UpdateStreamEvent event) {
    setState(() {
      isSearched = true;
      searchText = event.tag;
    });
    _pagingController.refresh();
    getImages(event);
  }

  Future getImages(UpdateStreamEvent event) async {
    try {
      final newItems = await apiService.getPhotoByTag(event.tag, currentPage);
      final isLastPage = currentPage < ApiService.MAX_PER_PAGE;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.items.toList());
      } else {
        currentPage += 1;
        final nextPageKey = currentPage;
        _pagingController.appendPage(newItems.items.toList(), nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
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
                padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
              ),
              Padding(
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text("Найти фотографии"),
                      onPressed: () {
                        _setFirstSearch(UpdateStreamEvent(
                            tag: textController.text,
                            page: 1,
                            isRefresh: true));
                      },
                      style: ElevatedButton.styleFrom(),
                    )),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              ),
            ],
          ),
        ),
        isSearched ? buildTweets(context, searchText, true) : const Text(""),
      ],
    );
  }

  Widget buildTweets(BuildContext context, String text, bool refresh) {
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
