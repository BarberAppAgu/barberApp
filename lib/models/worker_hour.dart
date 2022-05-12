class WorkerHour {
  String day;
  String startTime;
  String finishTime;
  bool? isSelected;
  String? nameOfTheWorker;

  WorkerHour({
    required this.day,
    required this.startTime,
    required this.finishTime,
    this.isSelected,
    this.nameOfTheWorker,
  });
}
