import 'package:barber_app/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentInfo with ChangeNotifier {
  Appointment appointment =
      Appointment(shopId: 0, user_id: 0, price: 0, takenHour: 0);

  void startToSetApp(int shopId, int userId, int takenHour) {
    appointment = Appointment(
      shopId: shopId,
      user_id: userId,
      price: appointment.price,
      takenHour: takenHour,
    );
    notifyListeners();
  }

  void changeTotalPrice(double additionalPrice) {
    appointment.price += additionalPrice;
    notifyListeners();
  }

  void changeToTakenHour(int additionalHour) {
    appointment.takenHour += additionalHour;
    notifyListeners();
  }

  void clearHourAndPrice() {
    appointment = Appointment(shopId: 0, user_id: 0, price: 0, takenHour: 0);
    notifyListeners();
  }
}
