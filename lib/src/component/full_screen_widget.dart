import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:images_test/src/model/image_model.dart';
import 'package:redux/redux.dart';
import 'package:like_button/like_button.dart';
import '../redux/app_state.dart';
import '../redux/model_action.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/styles.dart';
import '../resources/text.dart';

class FullScreenImageWidget extends StatelessWidget {
  final ImageModel imageModel;
  final Store<AppState> store;

  const FullScreenImageWidget(
      {Key? key, required this.imageModel, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: UIColors.appBarBackground,
          title: const Text(
            UIText.applicationTitle,
            style: UIStyles.optionStyle,
          ),
        ),
        body: Hero(
          tag: imageModel.description,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage(
                      imageModel.media.m.replaceFirst("_m.", "_b."),
                    ),
                    fit: BoxFit.contain)),
            child: LikeButton(
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
          ),
        ));
  }
// return Scaffold(
//     backgroundColor: Colors.black,
//     body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           GestureDetector(
//             child: Center(
//               child: Hero(
//                 tag: 'imageHero',
//                 child: Image.network(
//                   imageModel.media.m.replaceFirst("_m.", "_b."),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             onTap: () {
//               Navigator.pop(context);
//             },
//             onDoubleTap: () {
//               store.dispatch(LikeImageAction(imageModel));
//             },
//           ),
//           LikeButton(
//             size: UIDimentions.likeIconSize,
//             isLiked: imageModel.isLiked,
//             likeBuilder: (isLiked) {
//               final color = imageModel.isLiked
//                   ? UIColors.colorLikeIcon
//                   : UIColors.colorNotLikeIcon;
//               return Icon(Icons.favorite,
//                   color: color, size: UIDimentions.likeIconSize);
//             },
//             onTap: (isLiked) async {
//               store.dispatch(LikeImageAction(imageModel));
//               return imageModel.isLiked;
//             },
//           ),
//         ]));
}
