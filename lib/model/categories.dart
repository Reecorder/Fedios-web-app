class Category {
  String? id;
  String? docId;
  bool? enable;
  String? image;
  String? name;
  String? details;

  Category(
      {this.id, this.docId, this.enable, this.image, this.name, this.details});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enable = json['enable'];
    image = json['image'];
    name = json['name'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enable'] = enable;
    data['image'] = image;
    data['name'] = name;
    data['details'] = details;
    return data;
  }
}
