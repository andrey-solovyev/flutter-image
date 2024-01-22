import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/component/profile/profile_page.dart';
import 'package:images_test/src/resources/colors.dart';
import 'package:images_test/src/resources/styles.dart';
import 'package:like_button/like_button.dart';

import '../model/image_model.dart';
import '../redux/app_state.dart';
import '../redux/model_action.dart';
import '../resources/dimens.dart';
import 'full_screen_widget.dart';
import 'image_card_details.dart';

class PostCard extends StatelessWidget {
  final ImageModel imageModel;

  const PostCard({
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
      child: Column(
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: InkWell(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        imageModel.media.m.replaceFirst("_m.", "_b.")),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            imageModel.author,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageCardDetails(
                                    imageModel: imageModel,
                                    store: store,
                                  )));
                    },
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                          account: imageModel.author, img: imageModel.media.m)),
                );
              },
            ),
          ),
          // Image Section

          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    child: Ink.image(
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
                    )),
              ],
            ),
          ),

          //Like Comment Section
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: Row(
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
          ),
          // Description & Number of comments

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${imageModel.isLiked ? 1 : 0} likes',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: UIStyles.textDescriptionCard,
                      children: [
                        TextSpan(
                          text: imageModel.author,
                          style: UIStyles.textAuthorCard,
                        ),
                        TextSpan(
                          text: '  ${imageModel.title}',
                          style: UIStyles.textDescriptionCard,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Text(
                    imageModel.dateTaken,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
