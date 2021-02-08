class ProductModel {
  String pId,
      pName,
      pOldPrice,
      pCurrentPrice,
      pQty,
      pFeaturedImage,
      pDesc,
      pShortDesc,
      pFeature,
      pCondition,
      pReturnPolicy,
      pTotalView,
      isFeatured,
      isActive,
      catId,
      vendorId,
      vendorName,
      favourite,
      discount,
      createdAt;

  ProductModel(
      this.pId,
      this.pName,
      this.pOldPrice,
      this.pCurrentPrice,
      this.pQty,
      this.pFeaturedImage,
      this.pDesc,
      this.pShortDesc,
      this.pFeature,
      this.pCondition,
      this.pReturnPolicy,
      this.pTotalView,
      this.isFeatured,
      this.isActive,
      this.catId,
      this.vendorId,
      this.vendorName,
      this.favourite,
      this.discount,
      this.createdAt);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return new ProductModel(
        json['p_id'],
        json['p_name'],
        json['p_old_price'],
        json['p_current_price'],
        json['p_qty'],
        json['p_featured_photo'],
        json['p_description'],
        json['p_short_description'],
        json['p_feature'],
        json['p_condition'],
        json['p_return_policy'],
        json['p_total_view'],
        json['p_is_featured'],
        json['p_is_active'],
        json['tcat_id'],
        json['vendor_id'],
        json['vendor_name'],
        json['favorite'],
        json['discount'],
        json['created']);
  }
}