import 'package:images_test/src/ImageModel.dart';

class SearchResponseModel {
  late String title;
  late String link;
  late String description;
  late String generator;
  late Set<ImageModel> items;

  SearchResponseModel(
      {required this.title,
      required this.link,
      required this.description,
      required this.generator,
      required this.items});

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    Set<ImageModel> images = Set();
    if (json["items"] != null) {
      for (var item in json["items"]) {
        images.add(ImageModel.fromJson(item));
      }
    }
    return SearchResponseModel(
        title: json['title'] ?? "",
        link: json['title'] ?? "",
        description: json['title'] ?? "",
        generator: json['title'] ?? "",
        items: images);
  }
}
