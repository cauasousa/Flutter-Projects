import 'package:flutter/material.dart';
import 'package:searching_gifs/ui/gifpage/gifpage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

// ignore: must_be_immutable
class ListBoxGifs extends StatelessWidget {
  ListBoxGifs(
      {super.key, required this.snapshot, required this.increment_offset});
  final AsyncSnapshot snapshot;
  final Function() increment_offset;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: snapshot.data["data"].length + 1,
      itemBuilder: (context, index) {
        if (index < snapshot.data["data"].length) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(snapshot.data["data"][index]),
                ),
              );
            },
            onLongPress: () {
              Share.share(
                  "This is URL of Gif: ${snapshot.data["data"][index]["images"]["fixed_height"]["url"]}");
            },
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: snapshot.data["data"][index]["images"]["fixed_height"]
                  ["url"],
              height: 300.0,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              increment_offset();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white, size: 50),
                Text(
                  "Loand More...",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
