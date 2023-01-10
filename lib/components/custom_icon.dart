import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final Color color;
  final IconData icon;
  final bool hasGradient;
  const CustomIcon({
    Key? key,
    required this.color,
    required this.icon,
    required this.hasGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: hasGradient
              ? const LinearGradient(
                  colors: [Colors.red, Color.fromARGB(255, 1, 36, 71)],
                )
              : const LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black,
                  ],
                ),
        ),
        child: Icon(
          color: color,
          icon,
          size: 45.0,
        ));
  }
}
