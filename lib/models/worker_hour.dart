class WorkerHour {
  int? worker_id;
  String day;
  int startTime;
  int finishTime;
  bool? isSelected;
  String? nameOfTheWorker;

  WorkerHour({
    this.worker_id,
    required this.day,
    required this.startTime,
    required this.finishTime,
    this.isSelected,
    this.nameOfTheWorker,
  });

  factory WorkerHour.fromMap(Map map) {
    return WorkerHour(
      worker_id: int.parse(map['worker_id']),
      day: map['day'],
      startTime: int.parse(map['start_hour']),
      finishTime: int.parse(map['finish_hour']),
    );
  }
}
