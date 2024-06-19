import 'package:flutter/material.dart';

class WidgetPositionded extends StatelessWidget {
  WidgetPositionded({
    super.key,
    required this.text,
    this.tam = null,
    this.btt = null,
    this.top = null,
    this.lf = null,
    this.rgt = null,
    required this.cor,
  });

  final Color cor;
  final String text;
  final double? btt, top, lf, rgt, tam;


  @override
  Widget build(BuildContext context) {
    return Positioned(

      left: lf,
      bottom: btt,
      right: rgt,
      top: top,

      child: Text(
        text,
        style: TextStyle(
          height: 1.2,
          color: cor,
          fontSize: tam,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
