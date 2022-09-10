import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText(this.text, {Key? key}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  late bool isExpandable;
  late String visibleText;
  late String expandedText;

  @override
  void initState() {
    super.initState();
    isExpandable = widget.text.length > 250;
    if (isExpandable) {
      visibleText = widget.text.substring(0, 250);
      expandedText = widget.text.substring(250, widget.text.length);
    } else {
      visibleText = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 14,
      color: Colors.black
    );

    return isExpandable
    ? Column(
      children: [
        SelectableLinkify(
          onOpen: (link) async {
            final uri = Uri.tryParse(link.url);

            if (uri != null && await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          text: isExpanded ? visibleText + expandedText : visibleText, style: textStyle,
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              }, 
              child: Row(
                children: [
                  Text("Show ${isExpanded ? 'less' : 'more'}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Icon(isExpanded ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded)
                ],
              )
            ),
          ],
        )
      ],
    )
    : Text(visibleText, style: textStyle);
  }
}
