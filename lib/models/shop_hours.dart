class ShopHours {
  int? shopId;
  String day;
  String startTime;
  String endTime;

  ShopHours({
    this.shopId,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory ShopHours.fromMap(Map map) {
    return ShopHours(
      day: map['day'],
      startTime: map['start_hour'],
      endTime: map['finish_hour'],
      shopId: int.parse(map['shop_id']),
    );
  }
}
