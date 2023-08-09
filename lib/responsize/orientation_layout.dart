// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  final Widget? landscape;
  final Widget portrait;
  const OrientationLayout({
    Key? key,
    this.landscape,
    required this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape ?? portrait;
    }

    return portrait;
  }
}
