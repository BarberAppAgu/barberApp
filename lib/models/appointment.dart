class Appointment {
  int? appId;
  int shopId;
  int? workerId;
  String? date;
  int? startHour;
  int takenHour;
  String? note;
  int user_id;
  double price;

  Appointment({
    this.appId,
    required this.shopId,
    this.workerId,
    this.date,
    this.startHour,
    required this.takenHour,
    this.note,
    required this.user_id,
    required this.price,
  });

  factory Appointment.fromMap(Map map) {
    return Appointment(
      shopId: int.parse(map['shop_id']),
      user_id: int.parse(map['user_id']),
      price: double.parse(map['price']),
      takenHour: int.parse(map['taken_hour']),
      date: map['date'],
      appId: int.parse(map['app_id']),
      note: map['note'],
      startHour: int.parse(map['start_hour']),
      workerId: int.parse(map['worker_id']),
    );
  }
}
