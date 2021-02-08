import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zzzmart/category/util/category_util.dart';
import 'package:zzzmart/home/model/category_model.dart';
import 'package:zzzmart/home/widget/product_card.dart';

class CategoryProductListPage extends StatefulWidget {
  final CategoryModel categoryModel;

  CategoryProductListPage(this.categoryModel);

  @override
  _CategoryProductListPageState createState() =>
      _CategoryProductListPageState();
}

class _CategoryProductListPageState extends State<CategoryProductListPage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      appBar: AppBar(
        elevation: 1,
        brightness: Brightness.light,
        backgroundColor: colorScheme.onPrimary,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            CupertinoIcons.chevron_back,
            size: 32,
            color: colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: new Icon(
              CupertinoIcons.heart,
              color: colorScheme.primary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: new Icon(
              CupertinoIcons.bag_badge_plus,
              color: colorScheme.primary,
            ),
            onPressed: () {},
          ),
          new SizedBox(
            width: 15,
          )
        ],
      ),
      body: new ListView(
        children: [
          new Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
              '${widget.categoryModel.catName}',
              style: TextStyle(
                fontSize: 24,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(55, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(5.0, 5.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(55, 0, 0, 55),
                  ),
                ],
              ),
            ),
          ),
          new FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData && CategoryUtil.productList.length != 0) {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // I only need two card horizontally
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    if (CategoryUtil.productList.length == 0) {
                      return new Container();
                    } else {
                      return new ProductCard(CategoryUtil.productList[index]);
                    }
                  },
                  itemCount: CategoryUtil.productList.length,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  staggeredTileBuilder: (int index) {
                    return StaggeredTile.fit(1);
                  }, // add some space
                );
              } else {
                return new Container();
              }
            },
            future: CategoryUtil.fetchProducts(widget.categoryModel.catId),
            initialData: CategoryUtil.productList,
          )
        ],
      ),
    );
  }
}
