class CartModel {
  String pId,
      pName,
      cCurrentPrice,
      pFeaturedImage,
      cartId,
      pQty,
      dateAdded;

  CartModel(this.pId, this.pName, this.cCurrentPrice, this.pFeaturedImage,
      this.cartId, this.pQty, this.dateAdded);

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return new CartModel(
        json['p_id'],
        json['product_name'],
        json['p_current_price'],
        json['p_featured_photo'],
        json['cart_id'],
        json['p_qty'],
        json['date_added']);
  }
}
