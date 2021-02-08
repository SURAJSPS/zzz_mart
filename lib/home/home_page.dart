import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zzzmart/address/util/address_controller.dart';
import 'package:zzzmart/home/shimmer/store_card_shimmer.dart';
import 'package:zzzmart/home/util/home_util.dart';
import 'package:zzzmart/home/util/top_store_controller.dart';
import 'package:zzzmart/home/widget/banner_widget.dart';
import 'package:zzzmart/home/widget/category_chip.dart';
import 'package:zzzmart/home/widget/product_card.dart';
import 'package:zzzmart/home/widget/stores_card.dart';
import 'package:zzzmart/location/util/location_select_controller.dart';
import 'package:zzzmart/location/widget/select_location_button.dart';
import 'package:zzzmart/res/global_data.dart';
import 'package:zzzmart/store/util/store_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isExpanded = false;
  final TopStoresController topStoresController = Get.put(TopStoresController());
  final StoreController storeController = Get.put(StoreController());
  final LocationSelectController locationController = Get.put(LocationSelectController());
  final AddressController addressController = Get.put(AddressController());
  bool user = false;

  userLoggedIn() async {
    bool userLoggedIn = await GlobalData.userLoggedIn();
    setState(() {
      user = userLoggedIn;
    });
  }

  @override
  void initState() {
    userLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return new Scaffold(
      body: new ListView(
        children: [
          user
              ? new CupertinoNavigationBar(
            middle:new Container(child: SelectMapLocationButton(Colors.black, Colors.grey), width: size.width, alignment: Alignment.centerLeft,),
            automaticallyImplyMiddle: false,
          ) : new Container(),
          new SizedBox(
            height: 15,
          ),
          new FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData && HomeUtil.bannerList.length != 0) {
                return BannerWidget(HomeUtil.bannerList);
              } else {
                return new Container();
              }
            },
            future: HomeUtil.fetchBanner(),
            initialData: HomeUtil.bannerList,
          ),
          new FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData && HomeUtil.categoryList.length != 0) {
                return new Column(
                  children: [
                    StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      // I only need two card horizontally
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        if (HomeUtil.categoryList.length == 0) {
                          return new Container();
                        } else {
                          return new CategoryChip(HomeUtil.categoryList[index]);
                        }
                      },
                      itemCount: isExpanded
                          ? HomeUtil.categoryList.length
                          : HomeUtil.categoryList.length > 4
                              ? 4
                              : HomeUtil.categoryList.length,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.fit(1);
                      }, // add some space
                    ),
                    isExpanded
                        ? new Container(
                            child: new CupertinoButton(
                              child: new Text(
                                "Show Less",
                                style: TextStyle(color: colorScheme.primary),
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpanded = false;
                                });
                              },
                              color: colorScheme.onSurface,
                              padding: EdgeInsets.all(0),
                            ),
                            height: 40,
                            width: size.width,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                          )
                        : new Container(
                            child: new CupertinoButton(
                              child: new Text(
                                "Show More",
                                style: TextStyle(color: colorScheme.primary),
                              ),
                              onPressed: () {
                                setState(() {
                                  isExpanded = true;
                                });
                              },
                              color: colorScheme.onSurface,
                              padding: EdgeInsets.all(0),
                            ),
                            height: 40,
                            width: size.width,
                            padding: EdgeInsets.symmetric(horizontal: 25),
                          )
                  ],
                );
              } else {
                return new Container();
              }
            },
            future: HomeUtil.fetchCategories(),
            initialData: HomeUtil.categoryList,
          ),
          new SizedBox(
            height: 15,
          ),
          Obx(() => locationController.currentPlaceMark.value.subAdministrativeArea != null
              ? new Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'Trending Stores',
              style: TextStyle(
                fontSize: 18,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(25, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(5.0, 5.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(25, 0, 0, 25),
                  ),
                ],
              ),
            ),
          ) : new Container()),
          Obx(() => locationController.currentPlaceMark.value.subAdministrativeArea != null
              ? new Container(
            height: 260,
            width: size.width,
            child: Obx(() => FutureBuilder(
              builder: (context, projectSnap) {
                if (topStoresController
                    .topStoreModelList.length ==
                    0 &&
                    topStoresController.status.value == "false") {
                  //print('project snapshot data is: ${projectSnap.data}');
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return StoreCardShimmer();
                    },
                  );
                } else if (topStoresController
                    .topStoreModelList.length ==
                    0 &&
                    topStoresController.status.value == "true") {
                  //print('project snapshot data is: ${projectSnap.data}');
                  return new Container(
                      margin: EdgeInsets.only(top: 25),
                      child: new Column(
                        children: [
                          new Icon(
                            Icons.info,
                            size: 45,
                            color: colorScheme.primary,
                          ),
                          new Text(
                            "Stores not available for this location!",
                            style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      ));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: topStoresController
                        .topStoreModelList.length,
                    itemBuilder: (context, index) {
                      return StoresCard(topStoresController
                          .topStoreModelList[index]);
                    },
                  );
                }
              },
              future: topStoresController.fetchTopStores(
                  locationController.currentLatLng.value.latitude,
                  locationController
                      .currentLatLng.value.longitude),
            )),
          ) : new Container()),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              'Our Products',
              style: TextStyle(
                fontSize: 18,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(25, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(5.0, 5.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(25, 0, 0, 25),
                  ),
                ],
              ),
            ),
          ),
          new FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData && HomeUtil.productList.length != 0) {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // I only need two card horizontally
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    if (HomeUtil.productList.length == 0) {
                      return new Container();
                    } else {
                      return new ProductCard(HomeUtil.productList[index]);
                    }
                  },
                  itemCount: HomeUtil.productList.length,
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
            future: HomeUtil.fetchProducts(),
            initialData: HomeUtil.productList,
          ),
        ],
      ),
    );
  }
}
