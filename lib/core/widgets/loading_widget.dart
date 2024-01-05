import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.size = 50});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitWaveSpinner(
      color: Theme.of(context).colorScheme.inversePrimary,
      size: size,
    ));
  }
}
