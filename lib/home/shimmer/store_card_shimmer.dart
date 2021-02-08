import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoreCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new CupertinoButton(
      onPressed: null,
      child: new Card(
          margin: EdgeInsets.all(0),
          elevation: 1,
          shadowColor: colorScheme.onSurface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: colorScheme.onPrimary,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[100],
            highlightColor: Colors.white.withOpacity(0.5),
            enabled: true,
            child: new Column(children: [
              new Container(
                height: 150,
                width: 280,
                decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
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
                          child: new Container(
                            height: 10,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        new SizedBox(width: 15,),
                        new Container(
                          height: 25,
                          width: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            color: colorScheme.onSurface,
                          ),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                    new SizedBox(height: 10,),
                    new Container(
                      height: 5,
                      width: 280,
                      color: colorScheme.onSurface,
                    ),
                  ],
                ),
              )
            ]),
          )),
    );
  }
}
