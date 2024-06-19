import 'package:flutter/material.dart';

class BuildBodyBack extends StatelessWidget {
  const BuildBodyBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color(0xFF023535),
            // Color(0XFF008F8C)
            Color(0XFF000B0D),
            Color(0XFF390D02),
          ],
        ),
      ),
    );
  }
}
