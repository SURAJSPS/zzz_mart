import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/category/category_page.dart';
import 'package:zzzmart/category/util/category_util.dart';
import 'package:zzzmart/home/model/category_model.dart';

class CategoryChip extends StatelessWidget {
  final CategoryModel categoryModel;

  CategoryChip(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width * 0.4,
      child: CupertinoButton(
        padding: EdgeInsets.all(5),
        borderRadius: BorderRadius.circular(30),
        child: new Row(
          children: [
            new CircleAvatar(
              radius: 25,
              backgroundColor: colorScheme.onPrimary,
              backgroundImage: NetworkImage(
                  "https://zzzmart.com/assets/uploads/custom/${categoryModel.catImage}"),
            ),
            new SizedBox(
              width: 5,
            ),
            new Expanded(
                child: new Text(
              "${categoryModel.catName}",
              style: TextStyle(
                  color: Color(int.parse(
                      "0XFF${categoryModel.textColor.replaceAll("#", "")}")),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ))
          ],
        ),
        onPressed: () {
          CategoryUtil.productList.clear();

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryProductListPage(categoryModel),
              ));
        },
        color: Color(int.parse(
            "0XFF${categoryModel.backgroundColor.replaceAll("#", "")}")),
      ),
    );
  }
}
