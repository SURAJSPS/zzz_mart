class StoreModel {
  String id, sellerId, storeName, storeLogo, storeEmail, storePhone, storeProduct, storeBanner, document, storeDesc, storeAddress, lat, lng, storeCity, storeCountry, storeState, storeZip, storeShippingPolicy, storeReturnPolicy, storeMetaKeyWord, storeMetaDesc, storeBankDetails, storeTin, storeShippingType, storeShippingOrderType, storeShippingCharge, storeLiveChatEnable, storeLiveChatCode, storeStatus,
  storeCommission, isRemoved, storeCreatedAt, storeUpdatedAt, sellerPaypalId, storeImage, storeVideo, googleMap, storeTiming, multiStoreId, vacation, role, storePassword, storeToken, storeOrder, distance;

  StoreModel(
      this.id,
      this.sellerId,
      this.storeName,
      this.storeLogo,
      this.storeEmail,
      this.storePhone,
      this.storeProduct,
      this.storeBanner,
      this.document,
      this.storeDesc,
      this.storeAddress,
      this.lat,
      this.lng,
      this.storeCity,
      this.storeCountry,
      this.storeState,
      this.storeZip,
      this.storeShippingPolicy,
      this.storeReturnPolicy,
      this.storeMetaKeyWord,
      this.storeMetaDesc,
      this.storeBankDetails,
      this.storeTin,
      this.storeShippingType,
      this.storeShippingOrderType,
      this.storeShippingCharge,
      this.storeLiveChatEnable,
      this.storeLiveChatCode,
      this.storeStatus,
      this.storeCommission,
      this.isRemoved,
      this.storeCreatedAt,
      this.storeUpdatedAt,
      this.sellerPaypalId,
      this.storeImage,
      this.storeVideo,
      this.googleMap,
      this.storeTiming,
      this.multiStoreId,
      this.vacation,
      this.role,
      this.storePassword,
      this.storeToken,
      this.storeOrder,
      this.distance);

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return new StoreModel(
        json['stor_id'],
        json['seller_id'],
        json['store_name'],
        json['store_logo'],
        json['store_email'],
        json['store_phone'],
        json['store_product'],
        json['store_banner'],
        json['document'],
        json['store_description'],
        json['store_address'],
        json['latitude'],
        json['longitude'],
        json['store_city'],
        json['store_country'],
        json['store_state'],
        json['store_zipcode'],
        json['store_shipping_policy'],
        json['store_return_policy'],
        json['store_meta_keywords'],
        json['store_meta_descriptions'],
        json['store_bank_details'],
        json['store_tin'],
        json['store_shipping_type'],
        json['store_shipping_order_type'],
        json['store_shipping_charge'],
        json['store_live_chat_enable'],
        json['store_live_chat_code'],
        json['store_status'],
        json['store_commission'],
        json['store_created_at'],
        json['store_updated_at'],
        json['seller_paypal_id'],
        json['store_image'],
        json['store_video'],
        json['google_map'],
        json['store_timings'],
        json['multi_store_id'],
        json['vacation'],
        json['role'],
        json['store_password'],
        json['vendor_name'],
        json['store_token'],
        json['sort_order'],
        json['distance']);
  }
}