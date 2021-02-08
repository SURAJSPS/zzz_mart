import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:zzzmart/home/model/product_model.dart';
import 'package:zzzmart/home/widget/product_card.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  bool _error;
  bool _loading;
  List<ProductModel> _productList = new List();

  @override
  void initState() {
    super.initState();
    _error = false;
    _loading = true;
    fetchItems(context);
  }

  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  Widget getBody(context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    if (_productList.length == 0) {
      if (_loading) {
        return Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(0),
            child: LinearProgressIndicator());
      } else if (_error) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Failed to load!",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            new MaterialButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchItems(context);
                });
              },
              child: new Text(
                "Retry",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              color: Theme.of(context).colorScheme.primaryVariant,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2)),
              height: 30,
              minWidth: 100,
            ),
          ],
        );
      }
    } else {
      return StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        // I only need two card horizontally
        padding: const EdgeInsets.all(5),
        itemBuilder: (context, index) {
          if (_productList.length == 0) {
            return new Container();
          } else {
            return new ProductCard(_productList[index]);
          }
        },
        itemCount: _productList.length,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        staggeredTileBuilder: (int index) {
          return StaggeredTile.fit(1);
        }, // add some space
      );
    }
    return Container();
  }

  Future<void> fetchItems(context) async {
    try {
      String url =
          "https://zzzmart.com/admin/ecommerce_api/product/product.php?apicall=product_list";
      print("URL  $url");
      final response = await http.get(url);
      print("Response $response");
      var data = jsonDecode(response.body);
      print("DATA   $data");
      List<dynamic> list = data['records']
          .map((result) => new ProductModel.fromJson(result))
          .toList();
      print("LIST Category  $list");
      for (int b = 0; b < list.length; b++) {
        ProductModel productModel = list[b] as ProductModel;
        _productList.add(productModel);
      }
      setState(() {
        _loading = false;
      });
    } catch (e) {
      _loading = false;
      _error = true;
      print("Exception___Cat_____$e}");
    }
  }
}
