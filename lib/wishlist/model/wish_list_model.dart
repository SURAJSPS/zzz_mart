class WishListModel {
  String pId,
      pName,
      pOldPrice,
      pCurrentPrice,
      pFeaturedImage,
      pDesc,
      pShortDesc,
      pFeature,
      pCondition,
      pReturnPolicy,
      pTotalView,
      isFeatured,
      catId,
      vendorId,
      vendorName,
      favourite,
      discount,
      wishListId,
      pQty,
      createdAt;

  WishListModel(
      this.pId,
      this.pName,
      this.pOldPrice,
      this.pCurrentPrice,
      this.pFeaturedImage,
      this.pDesc,
      this.pShortDesc,
      this.pFeature,
      this.pCondition,
      this.pReturnPolicy,
      this.pTotalView,
      this.isFeatured,
      this.catId,
      this.vendorId,
      this.vendorName,
      this.favourite,
      this.discount,
      this.wishListId,
      this.pQty,
      this.createdAt);

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return new WishListModel(
        json['p_id'],
        json['product_name'],
        json['p_old_price'],
        json['p_current_price'],
        json['p_featured_photo'],
        json['p_description'],
        json['p_short_description'],
        json['p_feature'],
        json['p_condition'],
        json['p_return_policy'],
        json['p_total_view'],
        json['p_is_featured'],
        json['tcat_id'],
        json['vendor_id'],
        json['vendor_name'],
        json['favorite'],
        json['discount'],
        json['cart_id'],
        json['p_qty'],
        json['date_added']);
  }
}
