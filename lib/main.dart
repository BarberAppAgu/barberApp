import 'package:barber_app/providers/appointment_info.dart';
import 'package:barber_app/providers/order_info.dart';
import 'package:barber_app/providers/service_info.dart';
import 'package:barber_app/providers/shop_hours_info.dart';
import 'package:barber_app/providers/shop_info.dart';
import 'package:barber_app/providers/worker_hour_info.dart';
import 'package:barber_app/providers/worker_info.dart';
import 'package:barber_app/screens/enter/sign_view.dart';
import 'package:barber_app/screens/on_board.dart';
import 'package:barber_app/services/auth_shared_pref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'providers/basicUserInfo.dart';

//test push--
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ShopInfo>(
          create: (_) => ShopInfo(),
        ),
        ChangeNotifierProvider<BasicUserInfo>(
          create: (_) => BasicUserInfo(),
        ),
        ChangeNotifierProvider<ShopHoursInfo>(
          create: (_) => ShopHoursInfo(),
        ),
        ChangeNotifierProvider<ServiceInfo>(
          create: (_) => ServiceInfo(),
        ),
        ChangeNotifierProvider<WorkerInfo>(
          create: (_) => WorkerInfo(),
        ),
        ChangeNotifierProvider<WorkerHourInfo>(
          create: (_) => WorkerHourInfo(),
        ),
        ChangeNotifierProvider<OrderInfo>(
          create: (_) => OrderInfo(),
        ),
        ChangeNotifierProvider<AppointmentInfo>(
          create: (_) => AppointmentInfo(),
        ),
      ],
      builder: (context, __) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: OnBoard(),
    );
  }
}
