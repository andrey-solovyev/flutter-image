import 'dart:convert';
import 'package:images_test/src/ImageModel.dart';
import 'package:images_test/src/model/SearchResponseModel.dart';
import 'package:http/http.dart' as http;

import '../model/SearchResponseModel.dart';

class ApiService {
  final String serverUrl = "https://api.flickr.com";
  final String apiVersion = "/v1";
  static const int MAX_PER_PAGE = 10;
  Future<SearchResponseModel> getPhotoByTag(String tag, int page) async {
    try {
      Uri uri = Uri.https(
          "api.flickr.com", "services/feeds/photos_public.gne", {
        'tags': tag,
        'format': 'json',
        'nojsoncallback': '1',
        'per_page': '$page'
      });
      var client = http.Client();
      final response =
          await client.get(uri, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return SearchResponseModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return SearchResponseModel(
        title: "Me", link: "", description: "", generator: "", items: Set());
  }
}
