import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/reddit_list_event.dart';
import 'package:flutter_demo/bloc/reddit_list_state.dart';
import 'package:flutter_demo/services/reddit_service.dart';

class RedditListBloc extends Bloc<RedditListEvent, RedditListState> {
  final RedditService _redditService;

  RedditListBloc(this._redditService) : super(RedditListLoading()) {
    on<RedditListEvent>((event, emit) async {
      emit(RedditListLoading());

      final listResponse = await _redditService.getRedditList();
      emit(RedditListLoaded(listResponse.data));
    });
  }
}
