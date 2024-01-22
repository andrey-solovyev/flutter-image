import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/component/profile/profile_page.dart';
import 'package:images_test/src/model/image_model.dart';
import 'package:images_test/src/component/full_screen_widget.dart';
import 'package:images_test/src/resources/colors.dart';
import 'package:images_test/src/resources/styles.dart';
import 'package:like_button/like_button.dart';

import '../redux/app_state.dart';
import '../redux/model_action.dart';
import '../resources/dimens.dart';
import 'avatars.dart';

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _ProfileSlab(userData: imageModel.author),
          UIStyles.margins(),
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
          Container(
            padding: UIDimentions.defaultPadding.copyWith(bottom: 0),
            child: Text(
              imageModel.title,
              style: UIStyles.textDescriptionCard,
              textAlign: TextAlign.left,
            ),
          ),
          // Padding(
          //   padding: UIDimentions.defaultPadding.copyWith(bottom: 0),
          //   child: Text(
          //     imageModel.title,
          //     style: UIStyles.textDescriptionCard,
          //     textAlign: TextAlign.left,
          //   ),
          // ),
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
              LikeButton(
                size: UIDimentions.likeIconSize,
                isLiked: imageModel.isDisliked,
                likeBuilder: (isDisliked) {
                  final color = imageModel.isDisliked
                      ? UIColors.colorLikeIcon
                      : UIColors.colorNotLikeIcon;
                  return Icon(Icons.read_more,
                      color: color, size: UIDimentions.likeIconSize);
                },
                onTap: (isLiked) async {
                  store.dispatch(DislikeImageAction(imageModel));
                  return imageModel.isDisliked;
                },
              ),
            ],
          ),
          // ButtonBar(
          //   alignment: MainAxisAlignment.start,
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         store.dispatch(LikeImageAction(imageModel));
          //       },
          //       style: UIStyles.textButtonStyle(imageModel.isLiked),
          //       child: const Text(UIText.likeImage),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         store.dispatch(DislikeImageAction(imageModel));
          //       },
          //       style: UIStyles.textButtonStyle(imageModel.isDisliked),
          //       child: const Text(UIText.dislikeImage),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => ImageCardDetails(
          //                       imageModel: imageModel,
          //                       store: store,
          //                     )));
          //       },
          //       child: const Text(UIText.detailsTitle),
          //     )
          //   ],
          // ),
        ]));
  }
}

class _ProfileSlab extends StatelessWidget {
  const _ProfileSlab({
    Key? key,
    required this.userData,
  }) : super(key: key);

  final String userData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
        child: Row(
          children: [
            Avatar.small(streamagramUser: userData),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                userData,
                style: UIStyles.textStyleBold,
              ),
            ),
          ],
        ),
      ),
      onTap: () { print("TAP TAP TAP");},
    );
  }
}
