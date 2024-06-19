import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text, required this.active, required this.onpressed});
  final bool active;
  final String text;
  final Function() onpressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
      
            return Theme.of(context).primaryColor;
          }),
          alignment: Alignment.center,
          shadowColor: MaterialStatePropertyAll(Colors.black),
          foregroundColor: MaterialStatePropertyAll(Colors.grey.shade400),
          iconColor: MaterialStatePropertyAll(Colors.grey.shade400),
          textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
          shape: MaterialStatePropertyAll(
            ContinuousRectangleBorder(),
          ),
        ),
        onPressed: !active ? null : onpressed,
      ),
    );
  }
}
