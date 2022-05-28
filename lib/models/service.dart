class Service {
  int? serviceId;
  int? shopId;
  String serviceName;
  double price;
  String hourOfProcess;

  Service({
    this.serviceId,
    this.shopId,
    required this.serviceName,
    required this.price,
    required this.hourOfProcess,
  });

  factory Service.fromMap(Map map) {
    return Service(
      serviceName: map['service_name'],
      price: double.parse(map['price']),
      hourOfProcess: map['work_hour'],
      shopId: int.parse(map['shop_id']),
      serviceId: int.parse(map['service_id']),
    );
  }
}
