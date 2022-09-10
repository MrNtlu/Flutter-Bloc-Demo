import 'package:flutter_demo/models/reddit_post.dart';
import 'package:flutter_demo/utils/response.dart';
import 'package:http/http.dart' as http;

class RedditService {
  Future<BaseListResponse<RedditPost>> getRedditList() async {
    try {
      final response = await http.get(
        Uri.parse("https://www.reddit.com/r/flutterdev/top.json?count=20")
      );

      var baseListResponse = response.getBaseListResponse<RedditPost>();

      return baseListResponse;
    } catch (e) {
      return BaseListResponse(error: e.toString());
    }
  }
}