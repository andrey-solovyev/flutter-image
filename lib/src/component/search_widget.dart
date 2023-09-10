import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:images_test/src/resources/colors.dart';
import 'package:images_test/src/resources/text.dart';

import '../redux/app_action.dart';
import '../redux/app_state.dart';
import '../redux/model_action.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Form(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: TextFormField(
                controller: textController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: UIText.searchText,
                    hintText: UIText.hintSearchText),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return UIText.hintSearchText;
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      var store = StoreProvider.of<AppState>(context);
                      store.dispatch(FetchImagesAction(
                          [], 1, textController.text));
                      store.dispatch(fetchImages);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: UIColors.appBarBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                    child: const Text(UIText.searchText),
                  )),
            ),
          ],
        ),
      );
  }

}