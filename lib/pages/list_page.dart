import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/reddit_list_bloc.dart';
import 'package:flutter_demo/bloc/reddit_list_event.dart';
import 'package:flutter_demo/bloc/reddit_list_state.dart';
import 'package:flutter_demo/services/reddit_service.dart';
import 'package:flutter_demo/widgets/loading_view.dart';
import 'package:flutter_demo/widgets/reddit_list.dart';

class RedditListPage extends StatelessWidget {
  const RedditListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RedditListBloc(RepositoryProvider.of<RedditService>(context))..add(ListRequestEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("r/FlutterDev"),
        ),
        body: SafeArea(
          child: BlocBuilder<RedditListBloc, RedditListState>(
            builder: (context, state) {
              if (state is RedditListLoading) {
                return const LoadingView();
              } else if (state is RedditListLoaded) {
                return RedditList(state.list);
              } else {
                return Container(); // Error View
              }
            }
          ),
        ),
      ),
    );
  }
}