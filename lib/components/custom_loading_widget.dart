import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String text;
  const CustomLoadingWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: SpinKitWave(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(text),
      ],
    );
  }
}
