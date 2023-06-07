import 'dart:async';

import 'UpdateStreamEvent.dart';

class LoadStreamController<T> {
  final StreamController<T> _controller;

  // If you are using this on multiple widgets then  use asBroadcastStream()
  Stream<T> get uiStream => _controller.stream;

  LoadStreamController(
    this._controller,
  );

  void updateMyUI([dynamic params]) {
    T t;
    // your logic //
    //------------//
    _controller.stream.listen((event) {
      print(event);
    });
  }

  void dispose() {
    _controller.close();
  }
}
