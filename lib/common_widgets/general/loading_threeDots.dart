import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingThreeDotsWidget extends StatelessWidget{
  const LoadingThreeDotsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.threeRotatingDots(
      color: Colors.white,
      size: 100,
    );
  }

}