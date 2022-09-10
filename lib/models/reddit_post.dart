import 'package:flutter_demo/utils/json_converter.dart';

class RedditPost implements JSONConverter {
  final String id;
  final String title;
  final String? thumbnail;
  final int? thumbnailHeight;
  final int? thumbnailWidth;
  final String description;
  final String authorName;
  final String flair;
  final String flairBGColor;
  final int score;
  final String url;

  RedditPost(
    this.id, this.title, this.thumbnail, this.thumbnailHeight, this.thumbnailWidth,
    this.description, this.authorName, this.flair, this.flairBGColor, this.score, this.url
  );

  @override
  Map<String, Object> convertToJson() => {};
}
