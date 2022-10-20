import 'package:flutter/material.dart';
import 'package:kobar/Utility/Theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(
          color: green_color,
        ),
      ),
    );
  }
}
