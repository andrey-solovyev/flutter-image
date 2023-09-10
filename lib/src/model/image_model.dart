class ImageModel {
  final String title;
  final String link;
  final Media media;
  final String dateTaken;
  final String description;
  final String tags;
  final String author;
  late bool isLiked = false;
  late bool isDisliked = false;

  ImageModel({required this.title,
    required this.link,
    required this.media,
    required this.dateTaken,
    required this.description,
    required this.tags,
    required this.author});

  factory ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    return ImageModel(
      title: parsedJson['title'] ?? "",
      link: parsedJson['link'] ?? "",
      media: Media(parsedJson['media']) ?? Media("m"),
      dateTaken: parsedJson['date_taken'] ?? "",
      description: parsedJson['description'] ?? "",
      tags: parsedJson['tags'] ?? "",
      author: parsedJson['author'] ?? "",
    );
  }
}

class Media {
  late String m;

  Media(parsedJson) {
    m = parsedJson['m'] ?? "";
  }
}
