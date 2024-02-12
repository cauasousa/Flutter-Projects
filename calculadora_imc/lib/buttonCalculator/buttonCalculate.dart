import 'package:flutter/material.dart';

const color1 = Color.fromRGBO(25, 252, 0, 1);

class ButtonCalculate extends StatelessWidget {
  ButtonCalculate({super.key, required this.calculateIMC});

  final Function() calculateIMC;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStatePropertyAll(
                Size(double.maxFinite, 50),
              ),
              backgroundColor: MaterialStatePropertyAll(
                color1,
              ),
              shape: MaterialStatePropertyAll(
                LinearBorder(),
              ),
            ),
            onPressed: calculateIMC,
            child: Text(
              'Calculate',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18
              ),
            ),
          ),
        ),
      ],
    );
  }
}
