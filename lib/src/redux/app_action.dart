import 'package:flutter/cupertino.dart';
import 'package:images_test/src/api/ApiService.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../ImageModel.dart';
import 'app_state.dart';
import 'model_action.dart';


AppState reducer(AppState prev, dynamic action) {
  if (action is FetchImagesAction) {
    return AppState(action.images, action.page, action.tags);
  }
  if (action is LikeImageAction) {
    return _likeImage(prev, action);
  }

  // if (action is DislikeImageAction) {
  //   return _dislikeImage(prev, action);
  // }
  return prev;
}

ThunkAction<AppState> fetchImages = (Store<AppState> store) async {
  try {
    final newItems =
        await ApiService.getPhotoByTag(store.state.tags, store.state.page);
    if (store.state.page == 10){
      return;
    }
    List<ImageModel> result = [];
    result.addAll(store.state.images);
    result.addAll(newItems.items);
    store.dispatch(FetchImagesAction(
        result, store.state.page + 1, store.state.tags));
  } catch (e) {
    print('caught error: $e');
    return;
  }
};

AppState _likeImage(AppState store, LikeImageAction action) {
  try {
    var firstWhere =
        store.images.firstWhere((element) => element.link == action.image.link);
    var indexOfSelectedImage = store.images.indexOf(firstWhere);
    List<ImageModel> copyImages = List.from(store.images);
    // var copyWith =
    //     copyImages[indexOfSelectedImage].isLiked = true;
    // copyImages.setAll(indexOfSelectedImage, [copyWith]);
    return AppState(copyImages, store.page, store.tags);
  } catch (e) {
    print('caught error: $e');
  }
  return AppState(store.images, store.page, store.tags);
}
