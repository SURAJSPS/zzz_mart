import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zzzmart/auth/login/util/current_user_controller.dart';
import 'package:zzzmart/auth/model/user_model.dart';
import 'package:zzzmart/wishlist/util/wish_list_util.dart';
import 'package:zzzmart/wishlist/widget/wish_list_card.dart';

class WishListView extends StatefulWidget {
  @override
  _WishListViewState createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
  bool _hasMore;
  bool _error;
  bool _loading;
  final int _nextPageThreshold = 5;
  bool isEmptyData = false;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    _error = false;
    _loading = true;
    getUser();
    WishListController.productList.clear();
  }

  getUser() async {
    UserModel u = await CurrentUser.fetchCurrentUser();
    setState(() {
      userModel = u;
    });
    WishListController.fetchWishListItems(userModel.id, userModel.token);
  }

  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  Widget getBody(context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return userModel != null
        ? FutureBuilder(
            builder: (context, snapshot) {
              if (WishListController.productList.length == 0) {
                return Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(25),
                    child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  // I only need two card horizontally
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return WishListCard(
                      WishListController.productList[index],
                    );
                  },
                  itemCount: WishListController.productList.length,
                  // add some space
                );
              }
            },
            future: WishListController.fetchWishListItems(
                userModel.id, userModel.token),
          )
        : new Container();
    return Container();
  }

// Future<void> fetchItems() async {
//   setState(() {
//     isEmptyData = false;
//   });
//   try {
//     String url =
//         "${GlobalData.baseUrl}${GlobalData.getWishListUrl}&cust_id=${userModel.id}&cust_token=${userModel.token}";
//     print("URL W  $url");
//     final response = await http.get(url);
//     print("Response $response");
//     var data = jsonDecode(response.body);
//     print("DATA W  ${data['data']}");
//     List<dynamic> list = data['data']
//         .map((result) => new WishListModel.fromJson(result))
//         .toList();
//     print("LIST Category  $list");
//     if (list.length == 0) {
//       setState(() {
//         isEmptyData = true;
//       });
//     }
//     WishListController.productList.clear();
//     for (int b = 0; b < list.length; b++) {
//       WishListModel wishListModel = list[b] as WishListModel;
//       WishListController.productList.add(wishListModel);
//       print("Amenities ${wishListModel.pName}");
//     }
//     setState(() {
//       _loading = false;
//     });
//   } catch (e) {
//     _loading = false;
//     _error = true;
//     print("Exception___Cat_____$e}");
//   }
//   print("Is Empty $isEmptyData");
// }
}
