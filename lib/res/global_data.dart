import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalData {
  static String baseUrl = "https://zzzmart.com";
  static String GOOGLE_API_KEY = "AIzaSyC5m-C32piW2yiT3kevVbvLfHXsLsPTWik";

  // API's
  // API's
  static String passwordChangeUrl = "/admin/ecommerce_api/customer-forget-pass.php";
  static String sendOtpUrl = "/admin/ecommerce_api/customer-login-send-sms-otp.php";
  static String verifyOtpUrl = "/admin/ecommerce_api/customer-otp-verify.php";
  static String changePassUrl = "/admin/ecommerce_api/customer-new-pass.php";
  static String loginWithIdPasswordUrl =
      "/admin/ecommerce_api/customer_login.php?apicall=login";
  static String registerUrl =
      "/admin/ecommerce_api/profile.php?apicall=register";
  static String updateUrl = "/admin/ecommerce_api/profile.php?apicall=update";
  static String getUserUrl =
      "/admin/ecommerce_api/profile_get.php?apicall=profile";
  static String bannerUrl = "/admin/ecommerce_api1/banner/home_slider.php";
  static String categoryUrl =
      "/admin/ecommerce_api/category/cat_read.php?apicall=category_list";
  static String allProductByCategoryUrl =
      "/admin/ecommerce_api/category/cat_read.php?apicall=category_product&tcat_id=";
  static String allProductUrl =
      "/admin/ecommerce_api/product/product.php?apicall=product_list";
  static String storeLocatorUrl = "/admin/ecommerce_api/store_api.php";

  static String storeByCategoryIdUrl = "/admin/ecommerce_api/category/category-based-shoplist.php?apicall=category-based-shop";
  static String productByStoreIdUrl = "/admin/ecommerce_api/product/shop-based-product-list.php?apicall=shop-based-product";

  static String addToWishListUrl =
      "/admin/ecommerce_api/cart/wishlist.php?apicall=add_wishlist";
  static String removeFromWishListUrl =
      "/admin/ecommerce_api/cart/wishlist.php?apicall=remove";
  static String getWishListUrl =
      "/admin/ecommerce_api/cart/wishlist.php?apicall=wishlist";

  static String addToCartUrl =
      "/admin/ecommerce_api/cart/cart.php?apicall=add_product";
  static String getCartUrl =
      "/admin/ecommerce_api/cart/cart.php?apicall=cart_product";
  static String removeCartUrl =
      "/admin/ecommerce_api/cart/cart.php?apicall=remove";

  static String getAddressUrl =
      "/admin/ecommerce_api/shared/order-address-list.php";
  static String addAddressUrl = "/admin/ecommerce_api/shared/order-address.php";
  static String deleteAddressUrl =
      "/admin/ecommerce_api/shared/order-address-delete.php";
  static String updateAddressUrl =
      "/admin/ecommerce_api/shared/order-address-update.php";

  static String addWishListInBulkUrl =
      "/admin/ecommerce_api/cart/array-insertincart.php";

  static String codCheckoutUrl = "/admin/ecommerce_api/product/order_save.php?apicall=cash_on_delivery";

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  static userLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("user")) {
      print("User Available");
      return true;
    } else {
      print("User Not Available");
      return false;
    }
  }

  static showInSnackBar(
      String value, context, bgColor, textColor, icon, iconColor) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: bgColor,
        content: new Row(
          children: [
            new Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            new Text(
              "  $value",
              style: TextStyle(color: textColor),
            )
          ],
        )));
  }
}
