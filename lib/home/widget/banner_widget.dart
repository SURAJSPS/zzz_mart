import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zzzmart/home/model/banner_model.dart';

class BannerWidget extends StatelessWidget {
  final List<BannerModel> list;

  BannerWidget(this.list);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0),
      height: MediaQuery.of(context).size.width * 0.37,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Swiper(
        itemHeight: 100,
        duration: 1000,
        itemWidth: double.infinity,
        pagination: SwiperPagination(),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) => new CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            // print("Banner Id, ${bannerList[index].redirect}");
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => HomeChefsStoreDetailsPage(
            //           null, bannerList[index].redirect),
            //     ));
          },
          child: new Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            child: new Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://zzzmart.com/assets/uploads/${list[index].image}"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: new Container(
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.black.withOpacity(0.1)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: new Column(
                  crossAxisAlignment: list[index].position == "Center"
                      ? CrossAxisAlignment.center
                      : list[index].position == "Right"
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                  children: [
                    new Text(
                      "${list[index].heading}",
                      style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "${list[index].content}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        autoplay: true,
        viewportFraction: 0.9,
        scale: 0.95,
        layout: SwiperLayout.DEFAULT,
      ),
    );
  }
}
