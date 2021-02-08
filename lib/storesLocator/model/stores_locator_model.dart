class StoreLocatorModel {
  String id, storeName, storeAddress, latitude, longitude;

  StoreLocatorModel(this.id, this.storeName, this.storeAddress, this.latitude,
      this.longitude);

  factory StoreLocatorModel.fromJson(Map<String, dynamic> json) {
    return new StoreLocatorModel(json['id'], json['store_name'],
        json['store_address'], json['latitude'], json['longitude']);
  }
}
