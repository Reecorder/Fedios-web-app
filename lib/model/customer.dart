class Customer {
  String? id;
  String? docId;
  bool? enable;
  String? name;
  String? email;
  String? phone;
  String? gender;
  String? image;
  Address? defaultAddress;
  List<Address>? addresses;
  Customer(
      {this.id,
      this.docId,
      this.enable,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.image,
      this.defaultAddress,
      this.addresses});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enable = json['enable'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    image = json['image'];
    defaultAddress = json['default_address'] != null
        ? Address.fromJson(json['default_address'])
        : null;
    if (json['addresses'] != null) {
      addresses = <Address>[];
      json['addresses'].forEach((v) {
        addresses!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['gender'] = gender;
    data['image'] = image;
    if (defaultAddress != null) {
      data['default_address'] = defaultAddress!.toJson();
    }
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? fullAddress;
  String? country;
  String? state;
  String? city;
  String? zipcode;
  String? landmark;
  String? type;

  Address(
      {this.fullAddress,
      this.country,
      this.state,
      this.city,
      this.zipcode,
      this.landmark,
      this.type});

  Address.fromJson(Map<String, dynamic> json) {
    fullAddress = json['full_address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zipcode'];
    landmark = json['landmark'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_address'] = fullAddress;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['landmark'] = landmark;
    data['type'] = type;
    return data;
  }
}
