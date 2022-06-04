class Worker {
  int? worker_id;
  int? shop_id;
  String name;

  Worker({this.worker_id, this.shop_id, required this.name});

  factory Worker.fromMap(Map map) {
    return Worker(
      name: map['worker_name'],
      shop_id: int.parse(map['shop_id']),
      worker_id: int.parse(map['worker_id']),
    );
  }
}
