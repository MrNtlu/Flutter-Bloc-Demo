import 'package:equatable/equatable.dart';
import 'package:flutter_demo/models/reddit_post.dart';

abstract class RedditListState extends Equatable {
  const RedditListState();

  @override
  List<Object?> get props => [];
}

class RedditListLoading extends RedditListState {}

class RedditListLoaded extends RedditListState {
  final List<RedditPost> list;
  const RedditListLoaded(this.list);
}

class RedditListError extends RedditListState {
  final String? error;
  const RedditListError(this.error);
}
