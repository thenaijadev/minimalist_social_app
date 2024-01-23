import 'package:flutter/material.dart';

class BiometricsButton extends StatelessWidget {
  const BiometricsButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(20),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.inversePrimary,
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                offset: const Offset(0,
                    0.0), // Adjust the values to control the shadow direction
                blurRadius: 5.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Image.asset("images/biometrics.png"),
        ),
      ),
    );
  }
}
