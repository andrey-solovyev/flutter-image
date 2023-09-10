import 'package:images_test/src/api/api_service.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../model/image_model.dart';
import 'app_state.dart';
import 'model_action.dart';
import 'dart:developer';

AppState reducer(AppState prev, dynamic action) {
  if (action is FetchImagesAction) {
    return AppState(action.images, action.page, action.tags);
  }
  if (action is LikeImageAction) {
    return _likeImage(prev, action);
  }

  if (action is DislikeImageAction) {
    return _dislikeImage(prev, action);
  }
  return prev;
}

ThunkAction<AppState> fetchImages = (Store<AppState> store) async {
  try {
    final newItems =
        await ApiService.getPhotoByTag(store.state.tags, store.state.page);
    if (store.state.page == 10) {
      return;
    }
    List<ImageModel> result = [];
    result.addAll(store.state.images);
    result.addAll(newItems.items);
    store.dispatch(
        FetchImagesAction(result, store.state.page + 1, store.state.tags));
  } catch (e) {
    log("Catch error in fetch image: $e");
    return;
  }
};

AppState _likeImage(AppState store, LikeImageAction action) {
  try {
    var firstWhere =
        store.images.firstWhere((element) => element.link == action.image.link);
    var indexOfSelectedImage = store.images.indexOf(firstWhere);
    List<ImageModel> copyImages = List.from(store.images);
    var imageLikes = copyImages[indexOfSelectedImage];
    imageLikes.isLiked = !imageLikes.isLiked;
    imageLikes.isDisliked=false;
    copyImages.setAll(indexOfSelectedImage, [imageLikes]);
    return AppState(copyImages, store.page, store.tags);
  } catch (e) {
    log("Catch error in like image: $e");
  }
  return AppState(store.images, store.page, store.tags);
}

AppState _dislikeImage(AppState store, DislikeImageAction action) {
  try {
    var firstWhere =
    store.images.firstWhere((element) => element.link == action.image.link);
    var indexOfSelectedImage = store.images.indexOf(firstWhere);
    List<ImageModel> copyImages = List.from(store.images);
    var imageLikes = copyImages[indexOfSelectedImage];
    imageLikes.isLiked = false;
    imageLikes.isDisliked = !imageLikes.isDisliked;
    copyImages.setAll(indexOfSelectedImage, [imageLikes]);
    return AppState(copyImages, store.page, store.tags);
  } catch (e) {
    log("Catch error in dislike image: $e");
  }
  return AppState(store.images, store.page, store.tags);
}