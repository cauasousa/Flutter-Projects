import 'package:chatflutter/src/Views/chatpage/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BoxMessage extends StatelessWidget {
  const BoxMessage({super.key, required this.documents, required this.my});
  final bool my;

  final QueryDocumentSnapshot documents;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      

      child: Row(
        mainAxisAlignment:
            my == false ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,

        children: [
          my == false
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    documents.get(senderPhotoUrl),
                  ),
                )
              : Container(),
          if (my == false) const Padding(padding: EdgeInsets.all(3.0)),
          boxText(context, my),
          if (my == true) const Padding(padding: EdgeInsets.all(3.0)),
          my == true
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    documents.get(senderPhotoUrl),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget boxText(BuildContext context, bool my) {
    // late double paddSize;

    return Flexible(
      child: Container(
        padding: EdgeInsets.only(
          bottom: 4.0,
          left: 4.0,
          right: 4.0 + textboolSize(),
          top: 4.0,
        ),

        decoration: BoxDecoration(
          color: (my == false)
              ? const Color.fromRGBO(32, 44, 51, 1.0)
              : const Color.fromRGBO(0, 92, 75, 1.0),
          borderRadius: BorderRadius.circular(6),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (my == false)
              Text(
                documents.get(senderName),
                style: const TextStyle(
                  color: Color.fromARGB(255, 163, 180, 249),
                ),
              ),
            if (my == false)
              const Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
            _format(context),
          ],
        ),
        // width: 50,
      ),
    );
  }

  Widget _format(BuildContext context) {
    try {
      final String textData = documents.get('text');

      return Text(
        textData,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Colors.white,
        ),
      );
    } catch (e) {
      var urlimg = documents.get(imgUrl);

      return Image.network(
        urlimg,
        width: _widthImage(context),
      );
    }
  }

  double textboolSize() {
    try {
      // ignore: unused_local_variable
      final String textData = documents.get('text');

      return 2.0;
    } catch (e) {
      // ignore: unused_local_variable
      var urlimg = documents.get(imgUrl);

      return 0.0;
    }
  }

  double _widthImage(BuildContext context) {
    Size resol = _getScreenSize(context);

    return resol.width * 0.6;
  }

  Size _getScreenSize(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    Size screenSize = mediaQueryData.size;
    return screenSize;
  }
}
