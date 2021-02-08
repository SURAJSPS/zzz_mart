class CategoryModel {
  String catId,
      catName,
      catImage,
      backgroundColor,
      textColor,
      numberItem,
      showOnMenu,
      productCount;

  CategoryModel(this.catId, this.catName, this.catImage, this.backgroundColor,
      this.textColor, this.numberItem, this.showOnMenu, this.productCount);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return new CategoryModel(
        json['tcat_id'],
        json['tcat_name'],
        json['tcat_image'],
        json['backgroundColor'],
        json['textColor'],
        json['numberItems'],
        json['show_on_menu'],
        json['ProductCount']);
  }
}
