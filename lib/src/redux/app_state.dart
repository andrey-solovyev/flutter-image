import '../ImageModel.dart';

class AppState {
  final List<ImageModel> _images;
  final int _page;
  final String _tags;

  List<ImageModel> get images => _images;

  int get page => _page;

  String get tags => _tags;

  AppState(this._images, this._page, this._tags);

  AppState.initialState()
      : _images = List.empty(),
        _page = 1,
        _tags = "";
}
