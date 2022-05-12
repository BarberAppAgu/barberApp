import 'package:barber_app/models/worker_hour.dart';
import 'package:flutter/foundation.dart';

class WorkerHourInfo with ChangeNotifier {
  List<WorkerHour> workersHourList = [];

  void addWorkerHour(WorkerHour workerHour) {
    workersHourList.add(workerHour);
    notifyListeners();
  }

  void removeWorkerHours(String nameOfTheWorker) {
    workersHourList = workersHourList
        .where((workerHour) => workerHour.nameOfTheWorker != nameOfTheWorker)
        .toList();
  }
}
