import 'package:flutter/material.dart';

class AppBarSliver extends StatelessWidget {
  const AppBarSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text("Novidades"),
        titlePadding: EdgeInsets.all(13.0),
        centerTitle: true,
      ),
    );
  }
}
