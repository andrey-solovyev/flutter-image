import 'dart:convert';
import 'package:images_test/src/model/search_response_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  final String serverUrl = "https://api.flickr.com";
  final String apiVersion = "/v1";
  static const int MAX_PER_PAGE = 10;

  static Future<SearchResponseModel> getPhotoByTag(String tag, int page) async {
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
      print("Catch error in api $e");
    }
    return SearchResponseModel(
        title: "Me", link: "", description: "", generator: "", items: Set());
  }
}
