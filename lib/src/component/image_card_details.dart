import 'package:flutter/material.dart';
import 'package:images_test/src/model/image_model.dart';
import 'package:images_test/src/component/full_screen_widget.dart';
import 'package:images_test/src/resources/colors.dart';
import 'package:images_test/src/resources/styles.dart';
import 'package:images_test/src/resources/text.dart';
import 'package:like_button/like_button.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';
import '../redux/model_action.dart';
import '../resources/dimens.dart';

class ImageCardDetails extends StatelessWidget {
  final ImageModel imageModel;
  final Store<AppState> store;

  const ImageCardDetails(
      {Key? key, required this.imageModel, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIColors.background,
        appBar: AppBar(
          backgroundColor: UIColors.appBarBackground,
          title: const Text(
            UIText.applicationTitle,
            style: UIStyles.optionStyle,
          ),
        ),
        body: Card(
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
                    style: UIStyles.textAuthorCardDetail,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Ink.image(
                    image: NetworkImage(
                        imageModel.media.m.replaceFirst("_m.", "_b.")),
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
              Padding(
                padding: UIDimentions.defaultPadding.copyWith(bottom: 0),
                child: Text(
                  imageModel.dateTaken,
                  style: UIStyles.textDateTaken,
                ),
              ),
              UIStyles.margins(),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  LikeButton(
                    size: UIDimentions.likeIconSize,
                    isLiked: imageModel.isLiked,
                    likeBuilder: (isLiked) {
                      final color = imageModel.isLiked
                          ? UIColors.colorLikeIcon
                          : UIColors.colorNotLikeIcon;
                      return Icon(Icons.favorite,
                          color: color, size: UIDimentions.likeIconSize);
                    },
                    onTap: (isLiked) async {
                      store.dispatch(LikeImageAction(imageModel));
                      return imageModel.isLiked;
                    },
                  ),
                  LikeButton(
                    size: UIDimentions.likeIconSize,
                    isLiked: imageModel.isDisliked,
                    likeBuilder: (isDisliked) {
                      final color = imageModel.isDisliked
                          ? UIColors.colorLikeIcon
                          : UIColors.colorNotLikeIcon;
                      return Icon(Icons.thumb_down,
                          color: color, size: UIDimentions.likeIconSize);
                    },
                    onTap: (isLiked) async {
                      store.dispatch(DislikeImageAction(imageModel));
                      return imageModel.isDisliked;
                    },
                  ),
                ],
              ),
            ])));
  }
}
