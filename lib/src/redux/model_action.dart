import '../model/image_model.dart';

class FetchImagesAction {
  final List<ImageModel> _images;
  final int _page;
  final String _tags;

  List<ImageModel> get images => _images;

  int get page => _page;

  String get tags => _tags;

  FetchImagesAction(this._images, this._page, this._tags);
}

class LikeImageAction {
  final ImageModel _image;

  ImageModel get image => _image;

  LikeImageAction(this._image);
}

class DislikeImageAction {
  final ImageModel _image;

  ImageModel get image => _image;

  DislikeImageAction(this._image);
}