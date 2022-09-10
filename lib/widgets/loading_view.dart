import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  final String text;

  const LoadingView({this.text = "Loading", Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait  || Platform.isMacOS || Platform.isWindows;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: isPortrait
        ? _body(context)
        : SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _body(context)
        ),
    );
  }

  Widget _body(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      Align(
        alignment: Alignment.center,
        child: Lottie.asset(
          "assets/lottie/loading.json",
          frameRate: FrameRate(60)
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      )
    ]
  );
}