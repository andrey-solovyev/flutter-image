import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/model/image_model.dart';
import 'package:images_test/src/component/full_screen_widget.dart';
import 'package:images_test/src/resources/colors.dart';
import 'package:images_test/src/resources/styles.dart';
import 'package:images_test/src/resources/text.dart';

import '../redux/app_state.dart';
import '../redux/model_action.dart';

class ImageCard extends StatelessWidget {
  final ImageModel imageModel;

  const ImageCard({
    Key? key,
    required this.imageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    return Card(
        color: UIColors.backgroundImagine,
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10).copyWith(bottom: 3),
              child: Text(
                textAlign: TextAlign.left,
                'Author: ${imageModel.author}',
                style: UIStyles.textAuthorCard,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Ink.image(
                image:
                    NetworkImage(imageModel.media.m.replaceFirst("_m.", "_b.")),
                height: 260,
                fit: BoxFit.cover,
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullScreenImageWidget(imageModel: imageModel)));
                  },
                  onDoubleTap: () {
                    store.dispatch(LikeImageAction(imageModel));
                  },
                ),
              )
            ],
          ),
          UIStyles.margins(),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(
              imageModel.title,
              style: UIStyles.textDescriptionCard,
            ),
          ),
          UIStyles.margins(),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  store.dispatch(LikeImageAction(imageModel));
                },
                style: UIStyles.textButtonStyle(imageModel.isLiked),
                child: const Text(UIText.likeImage),
              ),
              TextButton(
                onPressed: () {
                  store.dispatch(DislikeImageAction(imageModel));
                },
                style: UIStyles.textButtonStyle(imageModel.isDisliked),
                child: const Text(UIText.dislikeImage),
              )
            ],
          ),
        ]));
  }
}
