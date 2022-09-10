import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/bloc/reddit_list_bloc.dart';
import 'package:flutter_demo/bloc/reddit_list_event.dart';
import 'package:flutter_demo/models/reddit_post.dart';
import 'package:flutter_demo/widgets/expandable_text.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

class RedditList extends StatelessWidget {
  final List<RedditPost> list;

  const RedditList(
    this.list,
    {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<RedditListBloc>(context).add(ListRequestEvent());

        return Future.value();
      },
      child: ListView.separated(
        itemBuilder: ((context, index) {
          final item = list[index];
    
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text("Posted by u/${item.authorName}"),
                      ),
                      Card(
                        color: Color(int.parse("0xFF${item.flairBGColor.replaceAll("#", "")}")),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(item.flair, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        HtmlUnescape().convert(item.title),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final uri = Uri.tryParse(item.url);

                        if (uri != null && await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      }, 
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.open_in_browser_rounded, color: CupertinoColors.systemBlue)
                    )
                  ],
                ),
                if (item.thumbnail != null && item.thumbnailHeight != null && item.thumbnailWidth != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Image.network(
                      item.thumbnail!,
                      width: item.thumbnailWidth?.toDouble(),
                      height: item.thumbnailHeight?.toDouble(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ExpandableText(item.description),
                ),
              ],
            ),
          );
        }),
        itemCount: list.length, 
        separatorBuilder: (_, __) => const Divider(thickness: 2),
      ),
    );
  }
}
