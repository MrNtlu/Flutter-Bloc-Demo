import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reddit_details_event.dart';
part 'reddit_details_state.dart';

class RedditDetailsBloc extends Bloc<RedditDetailsEvent, RedditDetailsState> {
  RedditDetailsBloc() : super(RedditDetailsInitial()) {
    on<RedditDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
