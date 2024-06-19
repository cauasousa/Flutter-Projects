import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class StaggeredGridTileAdaptative extends StatelessWidget {
  const StaggeredGridTileAdaptative({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future:
          FirebaseFirestore.instance.collection('home').orderBy('pos').get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData == true || ConnectionState.waiting == true) {
          return SliverToBoxAdapter(
            child: Container(
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 1.5,
              mainAxisSpacing: 1.5,
              children: [
                for (int i = 0; i < ((snapshot.data != null) ? snapshot.data!.docs.length : 0); i++)
                  StaggeredGridTile.count(
                    crossAxisCellCount: snapshot.data!.docs[i].get('x'),
                    mainAxisCellCount: snapshot.data!.docs[i].get('y'),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      fit: BoxFit.cover,
                      image: snapshot.data?.docs[i].get('image'),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
