import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

Widget buildLoadingOverlay() {
  return Container(
    color: Colors.black.withOpacity(0.5),
    child: Center(
      // child: Lottie.asset('assets/Wind.json', height: 100, width: 100),
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.indigo,
        size: 30,
      ),
    ),
  );
}

Widget buildLoadingOverlayWithWhite() {
  return Container(
    color: Colors.white.withOpacity(0.5),
    child: Center(
      child: Lottie.asset('assets/Wind.json', height: 100, width: 100),
    ),
  );
}
