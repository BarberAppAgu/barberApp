class Shop {
  int? shop_id;
  String typeOfShop;
  String name;
  String address;
  double lat;
  double lng;
  String imgUrl;
  int user_id;

  Shop({
    this.shop_id,
    required this.typeOfShop,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.imgUrl,
    required this.user_id,
  });

  factory Shop.fromMap(Map map) {
    return Shop(
      shop_id: int.parse(map['shop_id']),
      typeOfShop: map['type_shop'],
      name: map['name'],
      address: map['address'],
      lat: double.parse(map['lat']),
      lng: double.parse(map['lng']),
      imgUrl: map['img_url'],
      user_id: int.parse(map['user_id']),
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "typeOfShop: $typeOfShop, name: $name, address: $address, lat: $lat, lng: $lng, img_url: $imgUrl, user_id: $user_id";
  }
}
