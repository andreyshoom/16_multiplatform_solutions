import 'package:flutter/material.dart';

class AdaptiveWidget extends StatelessWidget {
  final Widget? narrow;
  final Widget? wide;
  final Widget? ultraWide;
  const AdaptiveWidget({
    Key? key,
    this.narrow,
    this.wide,
    this.ultraWide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1000 && ultraWide != null) {
      return ultraWide!;
    }
    if (width >= 720 && wide != null) {
      return wide!;
    }
    if (narrow != null) {
      return narrow!;
    }
    throw Exception('Can not match layout');
  }
}
