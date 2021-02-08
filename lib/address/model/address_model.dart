class AddressModel {
  String id,
      address,
      cAddId,
      cId,
      landmark,
      city,
      phone,
      sessionId,
      zipCode,
      createdAt;

  AddressModel(this.id, this.address, this.cAddId, this.cId, this.landmark,
      this.city, this.phone, this.sessionId, this.zipCode, this.createdAt);

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return new AddressModel(
        json['id'],
        json['address'],
        json['cust_add_id'],
        json['cust_id'],
        json['cust_landmarks'],
        json['cust_citys'],
        json['cust_phones'],
        json['session_id'],
        json['pincode'],
        json['created_at']);
  }
}
