class LocalCartModel {
  String pId, pName, pFeaturedImage, cCurrentPrice, pQty;

  LocalCartModel(
      this.pId, this.pName, this.pFeaturedImage, this.cCurrentPrice, this.pQty);

  factory LocalCartModel.fromJson(Map<String, dynamic> json) {
    return new LocalCartModel(json['p_id'], json['product_name'],
        json['p_current_price'], json['p_featured_photo'], json['p_qty']);
  }
}
