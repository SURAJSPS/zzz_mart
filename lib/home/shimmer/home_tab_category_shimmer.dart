import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeTabCategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: Colors.grey[100],
      highlightColor: Colors.white.withOpacity(0.5),
      enabled: true,
      child: new CupertinoButton(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new CircleAvatar(radius: 20, backgroundColor: colorScheme.onSurface,),
              new SizedBox(
                height: 10,
              ),
              new Container(
                height: 5,
                width: 40,
                color: colorScheme.onSurface,
              )
            ],
          ),
        ),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(index)));
        },
      ),);
  }
}
