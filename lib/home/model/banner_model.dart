class BannerModel {
  String id, image, heading, content, buttonText, buttonBrl, position;

  BannerModel(this.id, this.image, this.heading, this.content, this.buttonText,
      this.buttonBrl, this.position);

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return new BannerModel(
        json['id'],
        json['photo'],
        json['heading'],
        json['content'],
        json['button_text'],
        json['button_url'],
        json['position']);
  }
}
