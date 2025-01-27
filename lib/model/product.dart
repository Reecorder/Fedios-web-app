class Product {
  String? id;
  String? docId;
  bool? enable;
  String? category;
  String? name;
  String? image;
  String? availableQuantity;
  String? maxQuantity;
  String? minQuantity;
  String? price;
  String? discount;
  String? totalPrice;

  Product(
      {this.id,
      this.docId,
      this.enable,
      this.category,
      this.name,
      this.image,
      this.availableQuantity,
      this.maxQuantity,
      this.minQuantity,
      this.price,
      this.discount,
      this.totalPrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enable = json['enable'];
    category = json['category_id'];
    name = json['name'];
    image = json['image'];
    availableQuantity = json['available_quantity'];
    maxQuantity = json['max_quantity'];
    minQuantity = json['min_quantity'];
    price = json['price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enable'] = enable;
    data['category'] = category;
    data['name'] = name;
    if (image != null) {
      data['image'] = image;
    }
    data['available_quantity'] = availableQuantity;
    data['max_quantity'] = maxQuantity;
    data['min_quantity'] = minQuantity;
    data['price'] = price;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    return data;
  }
}

class Image {
  String? imageLow;
  List<String>? imageHigh;

  Image({this.imageLow, this.imageHigh});

  Image.fromJson(Map<String, dynamic> json) {
    imageLow = json['image_low'];
    imageHigh = json['image_high'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_low'] = imageLow;
    data['image_high'] = imageHigh;
    return data;
  }
}
