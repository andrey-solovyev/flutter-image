import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/model/image_model.dart';
import 'package:images_test/src/component/full_screen_widget.dart';
import 'package:images_test/src/resources/colors.dart';
import 'package:images_test/src/resources/styles.dart';
import 'package:images_test/src/resources/text.dart';

import '../redux/app_state.dart';
import '../redux/model_action.dart';
import '../resources/dimens.dart';
import 'image_card_details.dart';

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
          borderRadius: UIDimentions.borderRadiusDefault,
        ),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: UIDimentions.defaultPadding.copyWith(bottom: 3),
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
                height: UIDimentions.smallImageHeight,
                fit: BoxFit.cover,
                padding: UIDimentions.defaultPadding,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: UIDimentions.borderRadiusDefault,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullScreenImageWidget(
                                  imageModel: imageModel,
                                  store: store,
                                )));
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
            padding: UIDimentions.defaultPadding.copyWith(bottom: 0),
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
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImageCardDetails(
                                imageModel: imageModel,
                                store: store,
                              )));
                },
                child: const Text(UIText.detailsTitle),
              )
            ],
          ),
        ]));
  }
}
