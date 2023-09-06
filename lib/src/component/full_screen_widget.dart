import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:images_test/src/ImageModel.dart';

class FullScreenImageWidget extends StatelessWidget {
  final ImageModel imageModel;

  const FullScreenImageWidget({Key? key, required this.imageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullScreenWidget(
      disposeLevel: DisposeLevel.High,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageModel.media.m.replaceFirst("_m.", "_b."),
          fit: BoxFit.cover,
        ),
      ),
    );
    // return Scaffold(
    //   body: Image.network(
    //     imageModel.media.m.replaceFirst("_m.", "_b."),
    //     fit: BoxFit.cover,
    //     height: double.infinity,
    //     width: double.infinity,
    //     alignment: Alignment.center,
    //   ),
    // );
  }
}
