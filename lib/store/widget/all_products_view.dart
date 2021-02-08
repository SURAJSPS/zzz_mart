
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zzzmart/home/model/product_model.dart';
import 'package:zzzmart/home/widget/product_card.dart';
import 'package:zzzmart/store/util/store_controller.dart';

class AllProductsView extends StatelessWidget {
  final String storeId;

  AllProductsView(this.storeId);

  final StoreController storeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).colorScheme.onSurface,
      child: new FutureBuilder(
        future: storeController.fetchItems(storeId),
        builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData && snapshot.data.length != 0) {
            return StaggeredGridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              // I only need two card horizontally
              padding: const EdgeInsets.all(0.0),
              children: snapshot.data.map<Widget>((item) {
                //Do you need to go somewhere when you tap on this card, wrap using InkWell and add your route
                return new ProductCard(item);
              }).toList(),
              //Here is the place that we are getting flexible/ dynamic card for various images
              staggeredTiles: snapshot.data
                  .map<StaggeredTile>((_) => StaggeredTile.fit(1))
                  .toList(),
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0, // add some space
            );
          } else {
            return new Container();
          }
        },
      ),
    );
  }
}
