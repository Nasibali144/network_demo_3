class UserList {
  late List<User> userList;

  UserList({required this.userList});

  UserList.fromJson(List json) {
    userList = json.map((map) => User.fromJson(map)).toList();
  }

  List toJson() {
    List list;
    list = userList.map((user) => user.toJson()).toList();
    return list;
  }
}

class User {
  late int id;
  late String name;
  late String username;
  late String email;
  late Address address;
  late String phone;
  late String website;
  late Company company;

  User({
    required this.id,
    required this.address,
    required this.name,
    required this.phone,
    required this.username,
    required this.email,
    required this.company,
    required this.website,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = Address.fromJson(json['address']);
    website = json['website'];
    company = Company.fromJson(json['company']);
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'address': address.toJson(),
    'website': website,
    'company': company.toJson(),
    'email': email,
    'username': username,
    'phone': phone,
    'name': name,
  };
}

class Company {
  late String name;
  late String catchPhrase;
  late String bs;

  Company({required this.name, required this.bs, required this.catchPhrase});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bs = json['bs'];
    catchPhrase = json['catchPhrase'];
  }

  Map<String, dynamic> toJson() => {
    'catchPhrase': catchPhrase,
    'name': name,
    'bs': bs,
  };
}

class Address {
  late String street;
  late String suite;
  late String city;
  late String zipcode;
  late Geo geo;

  Address({
    required this.street,
    required this.city,
    required this.geo,
    required this.suite,
    required this.zipcode,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    geo = Geo.fromJson(json['geo']);
    suite = json['suite'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() => {
    'street': street,
    'city': city,
    'suite': suite,
    'zipcode': zipcode,
    'geo': geo.toJson(),
  };
}

class Geo {
  late String lat;
  late String lng;

  Geo({required this.lng, required this.lat});

  Geo.fromJson(Map<String, dynamic> json) {
    lng = json['lng'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() => {
    'lng': lng,
    'lat': lat,
  };
}

