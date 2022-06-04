import 'package:barber_app/models/worker.dart';
import 'package:barber_app/models/worker_hour.dart';
import 'package:barber_app/providers/worker_hour_info.dart';
import 'package:barber_app/providers/worker_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class WorkerInfoForms extends StatefulWidget {
  const WorkerInfoForms({Key? key}) : super(key: key);

  @override
  _WorkerInfoFormsState createState() => _WorkerInfoFormsState();
}

class _WorkerInfoFormsState extends State<WorkerInfoForms> {
  List<dynamic> workers = [
    'Adding',
  ];

  TextEditingController workerNameCtr = TextEditingController();

  List<WorkerHour> workerHoursList = [];
  List<int> times = List.generate(16, (index) => ((index + 1) * 4));

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        setWorkerHourList(context);
        setWorkerList(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workers.length,
      itemBuilder: (context, index) {
        if (workers[index] == 'Editing') {
          return editingWorkerMethod();
        } else if (workers[index] == 'Adding') {
          return addingWorkerMethod();
        }
        List<WorkerHour> currentWorkerHours = [];
        for (WorkerHour currentWorkerHour
            in Provider.of<WorkerHourInfo>(context, listen: false)
                .workersHourList) {
          if (currentWorkerHour.nameOfTheWorker == workers[index].name) {
            currentWorkerHours.add(currentWorkerHour);
          }
        }
        return Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  Provider.of<WorkerHourInfo>(context, listen: false)
                      .removeWorkerHours(workers[index].name);
                  workers.removeAt(index);
                  updateWorkerListProvider(context);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        workers[index].name,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Divider(
                      color: Colors.black54,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: currentWorkerHours.length,
                        itemBuilder: (context, index2) {
                          return Text(currentWorkerHours[index2].day +
                              ' From ' +
                              // consider-1
                              '${((currentWorkerHours[index2].startTime / 4) + 7).round()}:00' +
                              ' To ' +
                              // consider-2
                              '${((currentWorkerHours[index2].finishTime / 4) + 7).round()}:00');
                        }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget addingWorkerMethod() {
    return GestureDetector(
      onTap: () {
        if (workers.length == 1) {
          setState(() {
            workerNameCtr.text = '';
            workers.insert(0, 'Editing');
          });
        } else {
          if (workers[workers.length - 2] != 'Editing') {
            workerNameCtr.text = '';
            setState(() {
              workers.insert(workers.length - 1, 'Editing');
            });
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: const Center(
          child: Text(
            'Add A Worker',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget editingWorkerMethod() {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            bool isSameName = false;
            for (Worker oldWorker
                in Provider.of<WorkerInfo>(context, listen: false).allWorker) {
              if (oldWorker.name == workerNameCtr.text) {
                isSameName = true;
              }
            }
            if (workerNameCtr.text.isEmpty) {
              await _showMyDialog('Error', 'Please enter the worker name');
            } else if (isSameName) {
              await _showMyDialog(
                  'Error', 'Please enter different worker name');
            } else {
              Worker newWorker = Worker(
                name: workerNameCtr.text,
              );
              for (WorkerHour workerHour in workerHoursList) {
                if (workerHour.isSelected!) {
                  workerHour.nameOfTheWorker = workerNameCtr.text;
                  Provider.of<WorkerHourInfo>(context, listen: false)
                      .addWorkerHour(workerHour);
                }
              }
              workerNameCtr.text = '';
              setWorkerHourList(context);
              setState(() {
                workers.insert(workers.length - 2, newWorker);
                workers.removeAt(workers.length - 2);
              });
              updateWorkerListProvider(context);
            }
          },
          icon: const Icon(
            Icons.done,
            color: Colors.green,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                TextField(
                  controller: workerNameCtr,
                  decoration: InputDecoration(
                    hintText: 'Worker Name',
                  ),
                ),
                Divider(
                  color: Colors.black54,
                ),
                selectDayAndTimeMethod(workerHoursList[0]),
                selectDayAndTimeMethod(workerHoursList[1]),
                selectDayAndTimeMethod(workerHoursList[2]),
                selectDayAndTimeMethod(workerHoursList[3]),
                selectDayAndTimeMethod(workerHoursList[4]),
                selectDayAndTimeMethod(workerHoursList[5]),
                selectDayAndTimeMethod(workerHoursList[6]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row selectDayAndTimeMethod(WorkerHour workerHourData) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              workerHourData.isSelected = !workerHourData.isSelected!;
            });
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
            child: Center(
              child: workerHourData.isSelected!
                  ? const Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : Container(),
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Text(workerHourData.day),
        Spacer(),
        Text('From '),
        IgnorePointer(
          ignoring: workerHourData.isSelected! ? false : true,
          child: DropdownButton<int>(
            value: workerHourData.startTime,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
            ),
            elevation: 16,
            underline: Container(),
            borderRadius: BorderRadius.circular(16),
            onChanged: (int? newValue) {
              setState(() {
                workerHourData.startTime = newValue!;
                // for (int i = 0; i < newShopHoursList.length; i++) {
                //   if (newShopHoursList[i].day == 'Monday') {
                //     newShopHoursList[i].startTime =
                //         mondayStartDropDown;
                //   }
                // }
                print(newValue);
              });
            },
            items: times.map<DropdownMenuItem<int>>(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    '${((value / 4) + 7).round()}:00',
                    style: TextStyle(
                      color: workerHourData.isSelected!
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text('To '),
        IgnorePointer(
          ignoring: workerHourData.isSelected! ? false : true,
          child: DropdownButton<int>(
            value: workerHourData.finishTime,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
            ),
            elevation: 16,
            underline: Container(),
            borderRadius: BorderRadius.circular(16),
            onChanged: (int? newValue) {
              setState(() {
                workerHourData.finishTime = newValue!;
                // for (int i = 0; i < newShopHoursList.length; i++) {
                //   if (newShopHoursList[i].day == 'Monday') {
                //     newShopHoursList[i].endTime = mondayEndDropDown;
                //   }
                // }
                print(newValue);
              });
            },
            items: times.map<DropdownMenuItem<int>>(
              (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    '${((value / 4) + 7).round()}:00',
                    style: TextStyle(
                      color: workerHourData.isSelected!
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  void updateWorkerListProvider(BuildContext context) {
    List<dynamic> tempWorkerList = [];
    for (dynamic service in workers) {
      if (service != 'Editing' && service != 'Adding') {
        tempWorkerList.add(service);
      }
    }
    Provider.of<WorkerInfo>(context, listen: false)
        .updateWorkerList(tempWorkerList);
  }

  void setWorkerList(BuildContext context) {
    workers = Provider.of<WorkerInfo>(context, listen: false)
        .allWorker
        .map((e) => e as dynamic)
        .toList();
    workers.add('Adding');
  }

  void setWorkerHourList(BuildContext context) {
    workerHoursList = [
      WorkerHour(day: 'Mon.', startTime: 4, finishTime: 64, isSelected: false),
      WorkerHour(day: 'Tue.', startTime: 4, finishTime: 64, isSelected: false),
      WorkerHour(day: 'Wed.', startTime: 4, finishTime: 64, isSelected: false),
      WorkerHour(day: 'Thu.', startTime: 4, finishTime: 64, isSelected: false),
      WorkerHour(day: 'Fri.', startTime: 4, finishTime: 64, isSelected: false),
      WorkerHour(day: 'Sat.', startTime: 4, finishTime: 64, isSelected: false),
      WorkerHour(day: 'Sun.', startTime: 4, finishTime: 64, isSelected: false),
    ];
  }

  Future<void> _showMyDialog(String title, String detail) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(detail),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: kTurquoise,
              ),
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
