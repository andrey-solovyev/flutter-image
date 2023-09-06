import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../redux/app_action.dart';
import '../redux/app_state.dart';
import 'image_card.dart';

class ImageList extends StatelessWidget {
  final AppState state;

  const ImageList({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            physics: const ScrollPhysics(),
            itemCount: state.images.length,
            itemBuilder: (context, i) {
              if (state.images.length - 2 == i) {
                store.dispatch(fetchImages);
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: ImageCard(imageModel: state.images[i]),
              );
            }));
  }
}
