import 'package:barber_app/constants.dart';
import 'package:barber_app/models/comment.dart';
import 'package:barber_app/models/order.dart';
import 'package:barber_app/models/service.dart';
import 'package:barber_app/models/shop.dart';
import 'package:barber_app/models/shop_hours.dart';
import 'package:barber_app/models/u_shop_about.dart';
import 'package:barber_app/models/u_shop_comments.dart';
import 'package:barber_app/models/u_shop_services.dart';
import 'package:barber_app/models/worker.dart';
import 'package:barber_app/models/worker_hour.dart';
import 'package:barber_app/providers/appointment_info.dart';
import 'package:barber_app/providers/order_info.dart';
import 'package:barber_app/screens/customer/cus_choose_personal%20_view.dart';
import 'package:barber_app/screens/customer/cus_create_appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/basicUserInfo.dart';
import '../../services/server_handler.dart';
import '../customer/cus_booking_timeselection_page.dart';

class uShopInfoPage extends StatefulWidget {
  Shop currentShop;

  uShopInfoPage({required this.currentShop});

  @override
  State<uShopInfoPage> createState() => _uShopInfoPageState();
}

class _uShopInfoPageState extends State<uShopInfoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.black,
                height: 1.0,
              ),
              preferredSize: const Size.fromHeight(4.0)),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () {
              Provider.of<AppointmentInfo>(context, listen: false)
                  .clearHourAndPrice();
              Provider.of<OrderInfo>(context, listen: false).clearAllOrder();
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xffe5e5e5),
          title: SizedBox(
            //height: 120,
            // width: 100,
            height: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset("assets/image/logo.png"),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                iconSize: MediaQuery.of(context).size.width * 0.09,
                color: Colors.black,
                onPressed: () => null,
                icon: Icon(Icons.account_circle),
              ),
            ),
          ],
        ),
        body: uShopInfo2(currentShop: widget.currentShop),
      ),
    );
  }
}

class uShopInfo2 extends StatefulWidget {
  Shop currentShop;

  uShopInfo2({required this.currentShop});

  @override
  _uShopInfo2State createState() => _uShopInfo2State();
}

class _uShopInfo2State extends State<uShopInfo2> {
  String dropdownValue = 'Ulu';
  TextEditingController newCommentCtr = TextEditingController();

  // List<ShopServices> serviceList = [
  //   ShopServices(45, "Hair Cutting"),
  //   ShopServices(55, "Perm dye"),
  //   ShopServices(65, "Groom Shave"),
  //   ShopServices(25, "Shave with machine"),
  //   ShopServices(35, "Shave with razor"),
  //   ShopServices(15, "Neck Shave")
  // ];

  // List<ShopComments> comments = [
  //   ShopComments.withBasic("very good", "2022–04–02"),
  //   ShopComments.withBasic(" good", "2022–04–03"),
  //   ShopComments.withBasic(
  //       "excellent barber.I strongly recommend it", "2022–04–30"),
  // ];
  var mapHours = {
    "Monday": "09:00 - 20:00",
    "Tuesday": "09:00 - 20:00",
    "Wednesday": "09:00 - 20:00",
    "Thursday": "09:00 - 20:00",
    "Friday": "09:00 - 20:00",
    "Saturday": "09:00 - 20:00",
  };

  Future<List<Service>> servicesFromShop() async {
    List<Service> services = [];
    Map<dynamic, dynamic>? resultMapOfServicesFromShop = await ServerHandler()
        .fetchServicesFromShop(shop_id: widget.currentShop.shop_id!.toString());

    if (resultMapOfServicesFromShop!['services'] != null) {
      for (Map<dynamic, dynamic> mapServiceInfo
          in resultMapOfServicesFromShop['services']) {
        Service service = Service.fromMap(mapServiceInfo);
        services.add(service);
      }
    }
    return services;
  }

  Future<List<Comment>> commentsFromShop() async {
    List<Comment> comments = [];
    Map<dynamic, dynamic>? resultMapOfCommentsFromShop = await ServerHandler()
        .showComment(shop_id: widget.currentShop.shop_id.toString());

    if (resultMapOfCommentsFromShop!['comments'] != null) {
      for (Map<dynamic, dynamic> mapCommentInfo
          in resultMapOfCommentsFromShop['comments']) {
        Comment comment = Comment.fromMap(mapCommentInfo);
        comments.add(comment);
      }
    }
    return comments;
  }

  Future<List<ShopHours>> shopHoursFromAPI() async {
    print("start fetch shop hour");
    List<ShopHours> shopHours = [];
    Map<dynamic, dynamic>? resultMapOfShopHours = await ServerHandler()
        .fetchShopHours(shop_id: widget.currentShop.shop_id.toString());

    if (resultMapOfShopHours!['shop_hours'] != null) {
      for (Map<dynamic, dynamic> mapShopHourInfo
          in resultMapOfShopHours['shop_hours']) {
        ShopHours shopHour = ShopHours.fromMap(mapShopHourInfo);
        shopHours.add(shopHour);
      }
    }
    print("finish fetch shop hour");
    return shopHours;
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

  Future<int> countWorkerFav(String shop_id, String worker_id) async {
    Map<dynamic, dynamic>? resultMapCountWorkerFav =
        await ServerHandler().countWorkerFav(
      shop_id: shop_id,
      worker_id: worker_id,
    );
    print(
        'worker_id: $worker_id, shop_id: $shop_id, ${resultMapCountWorkerFav!['num_fav']['num_fav']}');
    return int.parse(resultMapCountWorkerFav['num_fav']['num_fav']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: Color(0xffe5e5e5),

          //toolbarHeight: 220,
          toolbarHeight: MediaQuery.of(context).size.height * 0.33,
          bottom: const TabBar(
            tabs: [
              Tab(
                  child: Text(
                "Services",
                style: TextStyle(color: Colors.black),
              )),
              Tab(
                  child: Text(
                "Comments",
                style: TextStyle(color: Colors.black),
              )),
              Tab(
                child: Text(
                  "About",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          title: Column(
            children: [
              Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                Image(
                  height: size.height * 0.33,
                  image: AssetImage('assets/image/barber2.jpg'),
                  fit: BoxFit.cover,
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.currentShop.name),
                          IconButton(
                            icon: FutureBuilder<Map<dynamic, dynamic>?>(
                                future: ServerHandler().fetchOneShopFav(
                                    cus_id: Provider.of<BasicUserInfo>(context,
                                            listen: false)
                                        .basicUser
                                        .userId
                                        .toString(),
                                    shop_id:
                                        widget.currentShop.shop_id.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    Map<dynamic, dynamic>?
                                        fetchedDataOneShopFav = snapshot.data;
                                    if (fetchedDataOneShopFav!['fav'] == null) {
                                      return const Icon(
                                        Icons.favorite_border,
                                        size: 35,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.favorite,
                                        size: 35,
                                      );
                                    }
                                  } else if (snapshot.hasError) {
                                    Icon(
                                      Icons.favorite_border,
                                      size: 32,
                                      color: Colors.red,
                                    );
                                  }
                                  return const Icon(
                                    Icons.favorite_border,
                                    size: 32,
                                  );
                                }),
                            onPressed: () async {
                              await ServerHandler().changeShopFav(
                                  cus_id: Provider.of<BasicUserInfo>(context,
                                          listen: false)
                                      .basicUser
                                      .userId!
                                      .toString(),
                                  shop_id:
                                      widget.currentShop.shop_id.toString());
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    )),
              ]),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.03),
                  ))
            ],
          ),
        ),
        body: Container(
          color: Color(0xffe5e5e5),
          child: TabBarView(
            children: [
              Center(
                child: FutureBuilder<List<Service>>(
                    future: servicesFromShop(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Service> services = snapshot.data!;
                        return buildSubServices(services);
                      } else if (snapshot.hasError) {
                        return const Text('Error');
                      }
                      return const CircularProgressIndicator();
                    }),
              ),
              Center(
                  child: FutureBuilder<List<Comment>>(
                      future: commentsFromShop(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Comment> comments = snapshot.data!;
                          return buildSubComments(comments);
                        } else if (snapshot.hasError) {
                          return const Text('Error');
                        }
                        return const CircularProgressIndicator();
                      })),
              Center(child: buildAbout(dropdownValue, mapHours)),
            ],
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //
        //   onPressed : () {
        //     // Add your onPressed code here!
        //     _showMyDialog();
        //   },
        //   backgroundColor: Colors.green,
        //   child: const Icon(Icons.navigation),
        // ),
      ),
    );
  }

  Widget buildSubServices(List<Service> services) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                child: ListTile(
                  onTap: () => null,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(services.elementAt(index).serviceName),
                      Text("${services.elementAt(index).price} TL"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Provider.of<OrderInfo>(context, listen: false)
                            .orders
                            .any((order) =>
                                order.service_id == services[index].serviceId!)
                        ? Icon(Icons.remove)
                        : Icon(
                            Icons.add,
                          ),
                    onPressed: () {
                      if (Provider.of<OrderInfo>(context, listen: false)
                          .orders
                          .any((order) =>
                              order.service_id == services[index].serviceId!)) {
                        Provider.of<OrderInfo>(context, listen: false)
                            .removeOrder(services[index].serviceId!);
                        Provider.of<AppointmentInfo>(context, listen: false)
                            .changeTotalPrice(-services[index].price);
                        Provider.of<AppointmentInfo>(context, listen: false)
                            .changeToTakenHour(-services[index].hourOfProcess);
                      } else {
                        Order newOrder =
                            Order(service_id: services[index].serviceId!);
                        Provider.of<OrderInfo>(context, listen: false)
                            .addNewOrder(newOrder);
                        Provider.of<AppointmentInfo>(context, listen: false)
                            .changeTotalPrice(services[index].price);
                        Provider.of<AppointmentInfo>(context, listen: false)
                            .changeToTakenHour(services[index].hourOfProcess);
                      }
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TimeSelectionPage(
                          currentShop: widget.currentShop,
                        ))).then((value) => setState(() {
                  Provider.of<AppointmentInfo>(context, listen: false)
                      .clearHourAndPrice();
                  Provider.of<OrderInfo>(context, listen: false)
                      .clearAllOrder();
                }));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: double.infinity,
            height:
                Provider.of<OrderInfo>(context, listen: false).orders.length ==
                        0
                    ? 0
                    : 60,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[300],
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      Provider.of<OrderInfo>(context, listen: false)
                          .orders
                          .length
                          .toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Orders are selected.',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Text(convertIntToTime(
                    Provider.of<AppointmentInfo>(context, listen: false)
                        .appointment
                        .takenHour)),
                const Icon(Icons.watch_later_outlined),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '${Provider.of<AppointmentInfo>(context, listen: false).appointment.price.round()} \$',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_drop_up,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ListView buildSubComments(List<Comment> comments) {
    return ListView.builder(
      itemCount: comments.length + 1,
      itemBuilder: (_, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newCommentCtr,
                    decoration: InputDecoration(
                      hintText: 'Add Comment',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Comment newComment = Comment(
                      shopId: widget.currentShop.shop_id!,
                      userId: Provider.of<BasicUserInfo>(context, listen: false)
                          .basicUser
                          .userId!,
                      detail: newCommentCtr.text,
                      date: DateFormat("d/M/y").format(
                        DateTime.now(),
                      ),
                      detailedDate: DateFormat("y/MM/dd HH:mm:ss").format(
                        DateTime.now(),
                      ),
                    );
                    await ServerHandler().addNewComment(comment: newComment);
                    newCommentCtr.text = '';
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.send,
                    color: kTurquoise,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            elevation: 5,
            child: ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text(comments.elementAt(i - 1).detail),
              subtitle: Text(comments.elementAt(i - 1).date),
            ),
          );
        }
      },
      //shrinkWrap: true,
    );
  }

  Padding buildAbout(String dropdownValue, Map<String, String> map) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 8, 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.map,
                  size: MediaQuery.of(context).size.height * 0.08,
                  color: Color(0xff83d1c3),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.015,
                ),
                Expanded(
                    child: Text(
                  widget.currentShop.address,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025),
                )),
              ],
            ),
            ElevatedButton(
                onPressed: () => null,
                child: Text("Get Direction",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff83d1c3),
                  shape: StadiumBorder(),
                )),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Working Hours",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: FutureBuilder<List<ShopHours>>(
                  future: shopHoursFromAPI(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ShopHours> shopHours = snapshot.data!;
                      return buildDataTable(shopHours);
                    } else if (snapshot.hasError) {
                      return const Text('Error');
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Employees",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.035),
              ),
            ),
            FutureBuilder<List<Worker>>(
              future: workersFromAPI(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Worker> workers = snapshot.data!;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: workers.length,
                    itemBuilder: (context, index) {
                      print(
                          'worker name: ${workers[index].name} and worker_id: ${workers[index].worker_id}');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              workers[index].name,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            FutureBuilder<int>(
                              future: countWorkerFav(
                                widget.currentShop.shop_id!.toString(),
                                workers[index].worker_id.toString(),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  int numberOfCount = snapshot.data!;
                                  return Text(
                                    numberOfCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Text('-2');
                                }
                                return const Text(
                                  '-1',
                                  style: TextStyle(color: Colors.red),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () async {
                                await ServerHandler().changeWorkerFav(
                                  cus_id: Provider.of<BasicUserInfo>(context,
                                          listen: false)
                                      .basicUser
                                      .userId!
                                      .toString(),
                                  shop_id:
                                      widget.currentShop.shop_id.toString(),
                                  worker_id:
                                      workers[index].worker_id.toString(),
                                );
                                setState(() {});
                              },
                              icon: FutureBuilder<Map<dynamic, dynamic>?>(
                                  future: ServerHandler().fetchOneWorkerFav(
                                      cus_id: Provider.of<BasicUserInfo>(
                                              context,
                                              listen: false)
                                          .basicUser
                                          .userId
                                          .toString(),
                                      shop_id:
                                          widget.currentShop.shop_id.toString(),
                                      worker_id:
                                          workers[index].worker_id.toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Map<dynamic, dynamic>?
                                          fetchedDataOneShopFav = snapshot.data;
                                      if (fetchedDataOneShopFav!['fav'] ==
                                          null) {
                                        return const Icon(
                                          Icons.favorite_border,
                                          size: 24,
                                        );
                                      } else {
                                        return const Icon(
                                          Icons.favorite,
                                          size: 24,
                                        );
                                      }
                                    } else if (snapshot.hasError) {
                                      Icon(
                                        Icons.favorite_border,
                                        size: 20,
                                        color: Colors.red,
                                      );
                                    }
                                    return const Icon(
                                      Icons.favorite_border,
                                      size: 24,
                                    );
                                  }),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error');
                }
                return const CircularProgressIndicator();
              },
            ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: DropdownButton<String>(
            //     value: dropdownValue,
            //     icon: const Icon(
            //       Icons.arrow_downward,
            //       color: Color(0xff83D1C3),
            //     ),
            //     elevation: 16,
            //     style: const TextStyle(color: Colors.black),
            //     underline: Container(
            //       height: 2,
            //       color: Color(0xffe5e5e5),
            //     ),
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         dropdownValue = newValue!;
            //       });
            //     },
            //     items: <String>['Ulu', 'Alaattin', 'Akcan', 'kerem']
            //         .map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: Text(value),
            //       );
            //     }).toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  DataTable buildDataTable(List<ShopHours> shopHours) {
    return DataTable(
      dataRowHeight: MediaQuery.of(context).size.width * 0.06,
      dividerThickness: 0,
      columnSpacing: 0,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Days',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Hours',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: List.generate(
        shopHours.length,
        (index) => DataRow(
          cells: <DataCell>[
            DataCell(
              Text("${shopHours[index].day} "),
            ),
            DataCell(Text(
                "${shopHours[index].startTime} - ${shopHours[index].endTime}")),
          ],
        ),
      ),
    );
  }

  String convertIntToTime(int currentInt) {
    if (currentInt < 4) {
      return '${currentInt * 15} min.';
    } else {
      int currentH = (currentInt / 4).floor();
      int currentM = currentInt % 4;
      return "$currentH.${currentM * 15} H";
    }
  }
}
