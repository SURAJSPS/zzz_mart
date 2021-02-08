import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/home/model/store_model.dart';
import 'package:zzzmart/store/store_details_page.dart';

class StoresCard extends StatefulWidget {
  final StoreModel topStoreModel;

  StoresCard(this.topStoreModel);

  @override
  _StoresCardState createState() => _StoresCardState();
}

class _StoresCardState extends State<StoresCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new CupertinoButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => StoreDetailsPage(widget.topStoreModel, null)));
      },
      child: new Card(
          margin: EdgeInsets.all(0),
          elevation: 1,
          shadowColor: colorScheme.onSurface,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: colorScheme.onPrimary,
          child: new Column(children: [
            new SizedBox(
                height: 150,
                width: 280,
                child: new ClipRRect(
                    child: new Image.network(
                      "https://zzzmart.com/assets/uploads/${widget.topStoreModel.storeBanner}",
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                ),
            new SizedBox(
              height: 10,
            ),
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: 280,
              child: new Column(
                children: [
                  new Row(
                    children: [
                      new Expanded(
                        child: new Text(
                          "${widget.topStoreModel.storeName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, color: colorScheme.primary),
                        ),
                      ),
                      new Container(
                        height: 25,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: colorScheme.secondary,
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              color: colorScheme.onPrimary,
                              size: 15,
                            ),
                            new Text(
                              " ${widget.topStoreModel.storeTiming}",
                              style: TextStyle(
                                  color: colorScheme.onPrimary, fontSize: 14),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  new Text(
                    "Bread with chicken Bread with chicken bread with chicken",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14, color: colorScheme.secondaryVariant),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
