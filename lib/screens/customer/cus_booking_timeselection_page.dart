import 'package:barber_app/models/appointment.dart';
import 'package:barber_app/models/shop.dart';
import 'package:barber_app/models/worker_hour.dart';
import 'package:barber_app/providers/appointment_info.dart';
import 'package:barber_app/providers/basicUserInfo.dart';
import 'package:barber_app/providers/order_info.dart';
import 'package:barber_app/screens/customer/cus_create_appointment.dart';
import 'package:barber_app/screens/customer/cus_home_view.dart';
import 'package:flutter/material.dart';
import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_range/time_range.dart';
import '../../constants.dart';
import '../../models/order.dart';
import '../../models/worker.dart';
import '../../services/server_handler.dart';

class TimeSelectionPage extends StatefulWidget {
  Shop currentShop;

  TimeSelectionPage({required this.currentShop});

  @override
  _TimeSelectionPageState createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  late DateTime selectedDate;

  int selectedWorkerIndex = 0;
  int selectedWorkerId = -1;

  int selectedHour = 0;

  TextEditingController noteCtr = TextEditingController();

  Future<Appointment> appointmentFromAPI(String start_hour) async {
    Map<dynamic, dynamic>? resultMapOfAppointment =
        await ServerHandler().fetchOneAppointment(
      worker_id: selectedWorkerId.toString(),
      date: DateFormat("yyyy-MM-dd").format(selectedDate),
      user_id: Provider.of<BasicUserInfo>(context, listen: false)
          .basicUser
          .userId
          .toString(),
      shop_id: widget.currentShop.shop_id.toString(),
      start_hour: start_hour,
    );
    Appointment appointment;
    if (resultMapOfAppointment!['appointment'] != null) {
      appointment = Appointment.fromMap(resultMapOfAppointment['appointment']);
    } else {
      appointment = Appointment(shopId: 0, takenHour: 0, user_id: 0, price: 0);
    }
    return appointment;
  }

  Future<Appointment> reservedAppointmentFromAPI(String start_hour) async {
    Map<dynamic, dynamic>? resultMapOfAppointment =
        await ServerHandler().fetchReservedAppointment(
      worker_id: selectedWorkerId.toString(),
      date: DateFormat("yyyy-MM-dd").format(selectedDate),
      shop_id: widget.currentShop.shop_id.toString(),
      start_hour: start_hour,
    );
    Appointment appointment;
    if (resultMapOfAppointment!['appointment'] != null) {
      appointment = Appointment.fromMap(resultMapOfAppointment['appointment']);
    } else {
      appointment = Appointment(shopId: 0, takenHour: 0, user_id: 0, price: 0);
    }
    return appointment;
  }

  Future<WorkerHour> workersHourFromAPI(String worker_id, String day) async {
    Map<dynamic, dynamic>? resultMapOfWorkersHour =
        await ServerHandler().fetchWorkerHour(worker_id: worker_id, day: day);
    WorkerHour workerHour;
    if (resultMapOfWorkersHour!['worker_hours'] != null) {
      workerHour = WorkerHour.fromMap(resultMapOfWorkersHour['worker_hours']);
    } else {
      workerHour = WorkerHour(day: 'day', startTime: 1, finishTime: 1);
    }
    return workerHour;
  }

  Future<List<Worker>> workersFromAPI() async {
    List<Worker> workers = [];
    Map<dynamic, dynamic>? resultMapOfWorkers = await ServerHandler()
        .fetchWorkers(shop_id: widget.currentShop.shop_id.toString());

    if (resultMapOfWorkers!['workers'] != null) {
      for (Map<dynamic, dynamic> mapWorkers in resultMapOfWorkers['workers']) {
        Worker worker = Worker.fromMap(mapWorkers);
        print('in workersFromAPI: worker_id ${mapWorkers['worker_id']}');
        print(
            'in workersFromAPI: worker_id ${worker.worker_id} worker_name ${worker.name} shop_id ${worker.shop_id}');
        workers.add(worker);
      }
    }
    print("finish fetch worker");
    return workers;
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: height * 0.075,
        child: ElevatedButton(
          onPressed: () async {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const CreateAppointmet()),
            // );
            await ServerHandler().addAppointment(
                shop_id: widget.currentShop.shop_id.toString(),
                worker_id: selectedWorkerId.toString(),
                user_id: Provider.of<BasicUserInfo>(context, listen: false)
                    .basicUser
                    .userId
                    .toString(),
                date: DateFormat("yyyy-MM-dd").format(selectedDate),
                start_hour: ((selectedHour - 7) * 4).toString(),
                note: noteCtr.text,
                price: Provider.of<AppointmentInfo>(context, listen: false)
                    .appointment
                    .price
                    .toString(),
                taken_hour: Provider.of<AppointmentInfo>(context, listen: false)
                    .appointment
                    .takenHour
                    .toString());
            Map<dynamic, dynamic>? resultMapOfAppointment =
                await ServerHandler().fetchOneAppointment(
              worker_id: selectedWorkerId.toString(),
              date: DateFormat("yyyy-MM-dd").format(selectedDate),
              user_id: Provider.of<BasicUserInfo>(context, listen: false)
                  .basicUser
                  .userId
                  .toString(),
              shop_id: widget.currentShop.shop_id.toString(),
              start_hour: ((selectedHour - 7) * 4).toString(),
            );
            print('currentApp Info: ${resultMapOfAppointment!['appointment']}');
            Appointment newAppointment =
                Appointment.fromMap(resultMapOfAppointment['appointment']);

            for (Order order
                in Provider.of<OrderInfo>(context, listen: false).orders) {
              await ServerHandler().addOrder(
                  app_id: newAppointment.appId.toString(),
                  service_id: order.service_id.toString());
            }
            Provider.of<AppointmentInfo>(context, listen: false)
                .clearHourAndPrice();
            Provider.of<OrderInfo>(context, listen: false).clearAllOrder();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CusHomeView()),
                (route) => false);
          },
          child: Text(
            "Apply Changes",
            style: TextStyle(
              color: const Color(0xffF3F6F4),
              fontSize: height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: kButtonColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kButtonColor,
        title: const Text("DATE & TIME"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Worker>>(
                future: workersFromAPI(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Worker> workers = snapshot.data!;
                    selectedWorkerId = workers[selectedWorkerIndex].worker_id!;
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: workers.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedWorkerIndex = index;
                                    selectedWorkerId =
                                        workers[selectedWorkerIndex].worker_id!;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: selectedWorkerIndex == index
                                        ? kTurquoise.withOpacity(0.5)
                                        : Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      workers[index].name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    const Text('Error');
                  }
                  return const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  );
                }),
            SizedBox(
              height: height * 0.20,
              child: AnimatedHorizontalCalendar(
                  unSelectedBoxShadow: const BoxShadow(color: kButtonColor),
                  tableCalenderButtonColor: kButtonColor,
                  tableCalenderIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  initialDate: DateTime.now(),
                  colorOfWeek: kButtonColor,
                  date: DateTime.now(),
                  textColor: Colors.black45,
                  backgroundColor: Colors.white,
                  tableCalenderThemeData: ThemeData.light().copyWith(
                    primaryColor: Colors.yellow,
                    buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.normal),
                    colorScheme: const ColorScheme.light(primary: kButtonColor)
                        .copyWith(secondary: kButtonColor),
                  ),
                  selectedColor: kButtonColor,
                  onDateSelected: (date) {
                    print('date: $date');
                    selectedHour = 0;
                    selectedDate = DateFormat("yyyy-MM-dd").parse(date);
                    setState(() {});
                  }),
            ),
            const SizedBox(
              height: 40,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Text(
                  'Select Time',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            selectedWorkerId == -1
                ? const SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder<WorkerHour>(
                    future: workersHourFromAPI(selectedWorkerId.toString(),
                        '${DateFormat("E").format(selectedDate)}.'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        WorkerHour workerHour = snapshot.data!;
                        if (workerHour.day == 'day') {
                          return const Text(
                              'The worker does not work in this day.');
                        } else {
                          List<String> timesString = List.generate(
                              ((workerHour.finishTime - workerHour.startTime) /
                                      4)
                                  .round(),
                              (index) =>
                                  "${(workerHour.startTime / 4 + 7 + index).round()}");
                          print('timesString: $timesString');
                          return SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: timesString.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder<Appointment>(
                                  future: reservedAppointmentFromAPI(
                                      ((int.parse(timesString[index]) - 7) * 4)
                                          .toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Appointment appointment = snapshot.data!;
                                      return GestureDetector(
                                        onTap: () {
                                          print('Hello app hours');
                                          print(timesString[index]);
                                          if (appointment.shopId == 0) {
                                            setState(() {
                                              selectedHour =
                                                  int.parse(timesString[index]);
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: appointment.shopId == 0
                                                ? selectedHour.toString() ==
                                                        timesString[index]
                                                    ? Colors.green[300]
                                                    : Colors.white
                                                : Colors.red.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Center(
                                            child: Text(
                                                '${timesString[index]}:00'),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Text('Error');
                                    }
                                    return const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                          // return Text(
                          //     '${workerHour.day}, ${workerHour.startTime}, ${workerHour.finishTime}');
                        }
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      return const SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
            SizedBox(
              width: double.infinity,
              height: 90,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  controller: noteCtr,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    hintText: 'Note',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
