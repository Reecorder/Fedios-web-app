class MenuModel {
  bool? enable;
  int? restaurant;
  String? name;
  int? id;
  int? foodItems;

  MenuModel({this.enable, this.restaurant, this.name, this.id, this.foodItems});

  MenuModel.fromJson(Map<String, dynamic> json) {
    enable = json['enable'];
    restaurant = json['restaurant'];
    name = json['name'];
    id = json['id'];
    foodItems = json['foodItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enable'] = enable;
    data['restaurant'] = restaurant;
    data['name'] = name;
    data['id'] = id;
    data['foodItems'] = foodItems;
    return data;
  }
}
