import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtualstore/src/ui/views/category/page_list_products/widget/custom_grid_view.dart';

class ProductCategoryScreen extends StatelessWidget {
  const ProductCategoryScreen({super.key, required this.snapshots});

  final QueryDocumentSnapshot snapshots;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(snapshots.get('title')),
            centerTitle: true,
            bottom: TabBar(tabs: [
              Tab(child: Icon(Icons.grid_on, color: Colors.white)),
              Tab(child: Icon(Icons.list, color: Colors.white)),
            ]),
          ),
          body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('products')
                .doc(snapshots.id)
                .collection('itens')
                .get(),
            builder: (context, snapshot) {


              if (!snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else {
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [

                    CustomGridViews(cac: 2, cas: 2.0, mas: 4.0, ratio: 0.64, categoryUid : snapshots.id,   snapshot: snapshot, grid: true),
                    CustomGridViews(cac: 1, cas: 4.0, mas: 2.0, ratio: 1.6, categoryUid : snapshots.id , snapshot: snapshot, grid: false),

                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
