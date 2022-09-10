import 'package:flutter_demo/models/reddit_post.dart';
import 'package:http/http.dart';
import 'dart:convert';

class BaseListResponse<T> {
  late List<T> data = [];
  final String? error;

  BaseListResponse({List<dynamic>? response, this.error}) {
    if (response != null) {
      final typeConverter = _TypeConverter<T>();
      
      response.map((e) {
        return e as Map<String, dynamic>;
      }).forEach((element) {
        data.add(typeConverter.convertToObject(element));
      });
    }
  }
}

class _TypeConverter<T> {
  T convertToObject(Map<String, dynamic> response) {
    if (T == RedditPost) {
      return RedditPost(
        response["data"]["id"],
        response["data"]["title"],
        response["data"]["thumbnail"],
        response["data"]["thumbnail_height"],
        response["data"]["thumbnail_width"],
        response["data"]["selftext"],
        response["data"]["author"],
        response["data"]["link_flair_text"],
        response["data"]["link_flair_background_color"],
        response["data"]["score"],
        response["data"]["url"]
      ) as T;
    } else {
      return response as T;
    }
  }
}

extension ResponseExt on Response {
  BaseListResponse<T> getBaseListResponse<T>() => BaseListResponse<T>(
    response: json.decode(body)["data"]["children"],
    error: null
  );
}
