import 'package:flutter/material.dart';

class SmallImageContainer extends StatelessWidget {
  final Widget containerChild;
  final double width;
  final double height;
  const SmallImageContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.containerChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: containerChild,
    );
  }
}
