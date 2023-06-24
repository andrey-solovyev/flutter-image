import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/redux/app_state.dart';
import 'package:images_test/src/redux/model_action.dart';
import '../ImageModel.dart';
import '../redux/app_action.dart';
import '../redux/app_state.dart';
import 'package:redux/redux.dart';

const List<Widget> icons = <Widget>[
  Icon(Icons.favorite_outline),
  Icon(Icons.sentiment_very_dissatisfied_outlined),
];

class PhotoDetails extends StatefulWidget {
  ImageModel image;
  Store<AppState> store;

  PhotoDetails(this.image, this.store);

  PhotoDetail createState() => PhotoDetail(image, store);
}

class PhotoDetail extends State<PhotoDetails> {
  ImageModel image;
  Store<AppState> store;
  late final List<bool> _likedState = <bool>[image.isLiked, image.isDisliked];

  PhotoDetail(this.image, this.store);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              child: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          title: Text("Details"),
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, int index) {
              return Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  children: <Widget>[
                    Text(image.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic)),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                    ),
                    Image.network(
                      image.media.m.replaceFirst("_m.", "_b."),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                    ),
                    Text("Date ${image.date_taken}",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic)),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                    ),
                    Text("Link ${image.link}",
                        style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontStyle: FontStyle.italic)),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                    ),
                    ToggleButtons(
                      onPressed: (int index) {
                        setState(() {
                          // The button that is tapped is set to true, and the others to false.
                          for (int i = 0; i < _likedState.length; i++) {
                            _likedState[i] = i == index;
                            if (i == 0) {
                              store.dispatch(LikeImageAction(image));
                            }
                            if (i == 1) {
                              store.dispatch(DislikeImageAction(image));
                            }
                          }
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Colors.blue[700],
                      selectedColor: Colors.white,
                      fillColor: Colors.blue[200],
                      color: Colors.blue[400],
                      isSelected: _likedState,
                      children: icons,
                    ),
                    Text("Author ${image.author}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic))
                  ],
                ),
              );
            }),
      ),
    );
  }

// Widget buildWidget(){}
}
