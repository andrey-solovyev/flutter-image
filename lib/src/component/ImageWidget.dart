import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_test/src/ImageModel.dart';

import '../photodetail.dart';

class ImageWidget extends StatefulWidget {
  ImageWidget({Key? key, required this.imageModel}) : super(key: key);

  final ImageModel imageModel;

  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<ImageWidget> {
  late String description;
  late Media media;

  @override
  void initState() {
    super.initState();
    description = widget.imageModel.description;
    media = widget.imageModel.media;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildImage(context, widget.imageModel);
  }

  Widget buildImage(context, ImageModel im) {
    return TextButton(
      child: Container(
        child: Column(
          children: <Widget>[
            Image.network(im.media.m),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
            ),
            Text(im.title)
          ],
        ),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
      ),
      onPressed: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => PhotoDetails(im)));
      },
    );
  }
}
