class ProductModel {
  late String displayName;
  late String thumbnail;
  late double mrp;
  late double salePrice;

  ProductModel({required this.displayName, required this.thumbnail, required this.mrp, required this.salePrice});

  ProductModel.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name']??"";
    thumbnail = json['thumbnail']??"";
    mrp = json['mrp']??0.0;
    salePrice = json['sale_price']??0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['display_name'] = this.displayName;
    data['thumbnail'] = this.thumbnail;
    data['mrp'] = this.mrp;
    data['sale_price'] = this.salePrice;
    return data;
  }

}