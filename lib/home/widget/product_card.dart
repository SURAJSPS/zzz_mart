import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/home/model/product_model.dart';
import 'package:zzzmart/productDetails/product_details_page.dart';
import 'package:zzzmart/res/global_data.dart';

class ProductCard extends StatefulWidget {
  final ProductModel productModel;

  ProductCard(this.productModel);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(widget.productModel),
            ));
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            // side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 5),
            borderRadius: BorderRadius.circular(5)),
        color: colorScheme.onPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                constraints:
                    new BoxConstraints.expand(height: 200.0, width: 450),
                alignment: Alignment.bottomLeft,
                padding: new EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: new DecorationImage(
                    image: new NetworkImage(
                        'https://zzzmart.com/assets/uploads/${widget.productModel.pFeaturedImage}'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.productModel.pName}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: new Text(
                      "${GlobalData.removeAllHtmlTags("${widget.productModel.pDesc}")}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: colorScheme.secondaryVariant, fontSize: 14),
                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Text(
                        "₹${double.parse(widget.productModel.pCurrentPrice).floor()}",
                        style:
                            TextStyle(color: colorScheme.primary, fontSize: 16),
                      ),
                      new SizedBox(
                        width: 5,
                      ),
                      new Text(
                        "₹${double.parse(widget.productModel.pOldPrice).floor()}",
                        style: TextStyle(
                            color: colorScheme.secondaryVariant,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
