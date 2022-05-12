import 'dart:io';

import 'package:barber_app/models/shop_hours.dart';
import 'package:barber_app/providers/shop_hours_info.dart';
import 'package:barber_app/providers/shop_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/shop.dart';
import '../../providers/basicUserInfo.dart';
import '../../screens/enter/google_maps_view.dart';

class ShopInformationForms extends StatefulWidget {
  Function callback;

  ShopInformationForms({required this.callback});

  @override
  State<ShopInformationForms> createState() => _ShopInformationFormsState();
}

class _ShopInformationFormsState extends State<ShopInformationForms> {
  TextEditingController shopNameCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();

  String typeOfShopDropDownValue = 'Type Of Shop';

  bool isMonday = false;
  bool isTuesday = false;
  bool isWednesday = false;
  bool isThursday = false;
  bool isFriday = false;
  bool isSaturday = false;
  bool isSunday = false;

  String mondayStartDropDown = '08.00';
  String mondayEndDropDown = '23.00';
  String tuesdayStartDropDown = '08.00';
  String tuesdayEndDropDown = '23.00';
  String wednesdayStartDropDown = '08.00';
  String wednesdayEndDropDown = '23.00';
  String thursdayStartDropDown = '08.00';
  String thursdayEndDropDown = '23.00';
  String fridayStartDropDown = '08.00';
  String fridayEndDropDown = '23.00';
  String saturdayStartDropDown = '08.00';
  String saturdayEndDropDown = '23.00';
  String sundayStartDropDown = '08.00';
  String sundayEndDropDown = '23.00';
  List<String> times = ['08.00', '08.30', '09.00', '20.00', '23.00'];

  List<ShopHours> newShopHoursList = [];

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        setShopHours(context);
        setShopInfo(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: kTurquoise,
            ),
          ),
          child: Center(
            child: DropdownButton<String>(
              isExpanded: true,
              value: typeOfShopDropDownValue,
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
              ),
              elevation: 16,
              underline: Container(),
              borderRadius: BorderRadius.circular(16),
              onChanged: (String? newValue) {
                setState(() {
                  typeOfShopDropDownValue = newValue!;
                  print(newValue);
                });
              },
              items: [
                'Type Of Shop',
                'Barbershop',
                'Woman Hairdresser',
                'Massage Saloon'
              ].map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: value == 'Type Of Shop'
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        textFormField(shopNameCtr, 'Shop Name'),
        textFormField(addressCtr, 'Address'),
        const Padding(
          padding: EdgeInsets.only(left: 32.0, bottom: 16, top: 20),
          child: Text(
            'Location Of Shop',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GoogleMapsView()));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: size.width / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: kTurquoise,
              ),
              image: DecorationImage(
                image: AssetImage('assets/image/map_photo.PNG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 32.0, bottom: 16, top: 20),
          child: Text(
            'Work Hours',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: kTurquoise,
            ),
            color: Colors.grey[300],
          ),
          child: Column(
            children: [
              /// Monday
              Row(
                children: [
                  Switch(
                    value: isMonday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      if (!_val) {
                        newShopHoursList.removeWhere(
                            (shopHour) => shopHour.day == 'Monday');
                      } else {
                        newShopHoursList.add(
                          ShopHours(
                            day: 'Monday',
                            startTime: mondayStartDropDown,
                            endTime: mondayEndDropDown,
                          ),
                        );
                      }
                      setState(() {
                        isMonday = _val;
                      });
                    },
                  ),
                  Text(
                    'Monday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('From '),
                  IgnorePointer(
                    ignoring: isMonday ? false : true,
                    child: DropdownButton<String>(
                      value: mondayStartDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          mondayStartDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Monday') {
                              newShopHoursList[i].startTime =
                                  mondayStartDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isMonday ? Colors.black : Colors.grey,
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
                    ignoring: isMonday ? false : true,
                    child: DropdownButton<String>(
                      value: mondayEndDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          mondayEndDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Monday') {
                              newShopHoursList[i].endTime = mondayEndDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isMonday ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),

              /// Tuesday
              Row(
                children: [
                  Switch(
                    value: isTuesday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      if (!_val) {
                        newShopHoursList.removeWhere(
                            (shopHour) => shopHour.day == 'Tuesday');
                      } else {
                        newShopHoursList.add(
                          ShopHours(
                            day: 'Tuesday',
                            startTime: tuesdayStartDropDown,
                            endTime: tuesdayEndDropDown,
                          ),
                        );
                      }
                      setState(() {
                        isTuesday = _val;
                      });
                    },
                  ),
                  Text(
                    'Tuesday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('From '),
                  IgnorePointer(
                    ignoring: isMonday ? false : true,
                    child: DropdownButton<String>(
                      value: tuesdayStartDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          tuesdayStartDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Tuesday') {
                              newShopHoursList[i].startTime =
                                  tuesdayStartDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isTuesday ? Colors.black : Colors.grey,
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
                    ignoring: isTuesday ? false : true,
                    child: DropdownButton<String>(
                      value: tuesdayEndDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          tuesdayEndDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Tuesday') {
                              newShopHoursList[i].endTime = tuesdayEndDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isTuesday ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),

              /// Wednesday
              Row(
                children: [
                  Switch(
                    value: isWednesday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      if (!_val) {
                        newShopHoursList.removeWhere(
                            (shopHour) => shopHour.day == 'Wednesday');
                      } else {
                        newShopHoursList.add(
                          ShopHours(
                            day: 'Wednesday',
                            startTime: wednesdayStartDropDown,
                            endTime: wednesdayEndDropDown,
                          ),
                        );
                      }
                      setState(() {
                        isWednesday = _val;
                      });
                    },
                  ),
                  Text(
                    'Wednesday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('From '),
                  IgnorePointer(
                    ignoring: isWednesday ? false : true,
                    child: DropdownButton<String>(
                      value: wednesdayStartDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          wednesdayStartDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Wednesday') {
                              newShopHoursList[i].startTime =
                                  wednesdayStartDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isWednesday ? Colors.black : Colors.grey,
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
                    ignoring: isWednesday ? false : true,
                    child: DropdownButton<String>(
                      value: wednesdayEndDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          wednesdayEndDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Wednesday') {
                              newShopHoursList[i].endTime =
                                  wednesdayEndDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isWednesday ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),

              /// Thursday
              Row(
                children: [
                  Switch(
                    value: isThursday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      if (!_val) {
                        newShopHoursList.removeWhere(
                            (shopHour) => shopHour.day == 'Thursday');
                      } else {
                        newShopHoursList.add(
                          ShopHours(
                            day: 'Thursday',
                            startTime: thursdayStartDropDown,
                            endTime: thursdayEndDropDown,
                          ),
                        );
                      }
                      setState(() {
                        isThursday = _val;
                      });
                    },
                  ),
                  Text(
                    'Thursday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('From '),
                  IgnorePointer(
                    ignoring: isThursday ? false : true,
                    child: DropdownButton<String>(
                      value: thursdayStartDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          thursdayStartDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Thursday') {
                              newShopHoursList[i].startTime =
                                  thursdayStartDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isThursday ? Colors.black : Colors.grey,
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
                    ignoring: isThursday ? false : true,
                    child: DropdownButton<String>(
                      value: thursdayEndDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          thursdayEndDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Thursday') {
                              newShopHoursList[i].endTime = thursdayEndDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isThursday ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),

              /// Friday
              Row(
                children: [
                  Switch(
                    value: isFriday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      if (!_val) {
                        newShopHoursList.removeWhere(
                            (shopHour) => shopHour.day == 'Friday');
                      } else {
                        newShopHoursList.add(
                          ShopHours(
                            day: 'Friday',
                            startTime: fridayStartDropDown,
                            endTime: fridayEndDropDown,
                          ),
                        );
                      }
                      setState(() {
                        isFriday = _val;
                      });
                    },
                  ),
                  Text(
                    'Friday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('From '),
                  IgnorePointer(
                    ignoring: isFriday ? false : true,
                    child: DropdownButton<String>(
                      value: fridayStartDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          fridayStartDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Friday') {
                              newShopHoursList[i].startTime =
                                  fridayStartDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isFriday ? Colors.black : Colors.grey,
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
                    ignoring: isFriday ? false : true,
                    child: DropdownButton<String>(
                      value: fridayEndDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          fridayEndDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Friday') {
                              newShopHoursList[i].endTime = fridayEndDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isFriday ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),

              /// Saturday
              Row(
                children: [
                  Switch(
                    value: isSaturday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      if (!_val) {
                        newShopHoursList.removeWhere(
                            (shopHour) => shopHour.day == 'Saturday');
                      } else {
                        newShopHoursList.add(
                          ShopHours(
                            day: 'Saturday',
                            startTime: saturdayStartDropDown,
                            endTime: saturdayEndDropDown,
                          ),
                        );
                      }
                      setState(() {
                        isSaturday = _val;
                      });
                    },
                  ),
                  Text(
                    'Saturday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('From '),
                  IgnorePointer(
                    ignoring: isSaturday ? false : true,
                    child: DropdownButton<String>(
                      value: saturdayStartDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          saturdayStartDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Saturday') {
                              newShopHoursList[i].startTime =
                                  saturdayStartDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isSaturday ? Colors.black : Colors.grey,
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
                    ignoring: isSaturday ? false : true,
                    child: DropdownButton<String>(
                      value: saturdayEndDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          saturdayEndDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Saturday') {
                              newShopHoursList[i].endTime = saturdayEndDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isSaturday ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),

              /// Sunday
              Row(
                children: [
                  Switch(
                    value: isSunday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      if (!_val) {
                        newShopHoursList.removeWhere(
                            (shopHour) => shopHour.day == 'Sunday');
                      } else {
                        newShopHoursList.add(
                          ShopHours(
                            day: 'Sunday',
                            startTime: sundayStartDropDown,
                            endTime: sundayEndDropDown,
                          ),
                        );
                      }
                      setState(() {
                        isSunday = _val;
                      });
                    },
                  ),
                  Text(
                    'Sunday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text('From '),
                  IgnorePointer(
                    ignoring: isSunday ? false : true,
                    child: DropdownButton<String>(
                      value: sundayStartDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          sundayStartDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Sunday') {
                              newShopHoursList[i].startTime =
                                  sundayStartDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isSunday ? Colors.black : Colors.grey,
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
                    ignoring: isSunday ? false : true,
                    child: DropdownButton<String>(
                      value: sundayEndDropDown,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                      ),
                      elevation: 16,
                      underline: Container(),
                      borderRadius: BorderRadius.circular(16),
                      onChanged: (String? newValue) {
                        setState(() {
                          sundayEndDropDown = newValue!;
                          for (int i = 0; i < newShopHoursList.length; i++) {
                            if (newShopHoursList[i].day == 'Sunday') {
                              newShopHoursList[i].endTime = sundayEndDropDown;
                            }
                          }
                          print(newValue);
                        });
                      },
                      items: times.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: isSunday ? Colors.black : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 32.0, bottom: 16, top: 20),
          child: Text(
            'Shop Image',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          height: size.width / 2,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kTurquoise),
            color: Colors.grey[300],
            image: imageFile != null
                ? DecorationImage(
                    image: FileImage(imageFile!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 100,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.camera);
                                  if (image != null) {
                                    setState(() {
                                      imageFile = File(image.path);
                                      Provider.of<ShopInfo>(context,
                                              listen: false)
                                          .updateShopImage(imageFile);
                                    });
                                  }
                                },
                                child: Text(
                                  'Select From Camera',
                                  style: TextStyle(
                                    color: kTurquoise,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  final XFile? image = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (image != null) {
                                    setState(() {
                                      imageFile = File(image.path);
                                      Provider.of<ShopInfo>(context,
                                              listen: false)
                                          .updateShopImage(imageFile);
                                    });
                                  }
                                },
                                child: Text(
                                  'Select From Gallery',
                                  style: TextStyle(
                                    color: kTurquoise,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.change_circle_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
                if (Provider.of<BasicUserInfo>(context, listen: false)
                        .basicUser
                        .type ==
                    'Employer') {
                  if (typeOfShopDropDownValue == 'Type Of Shop' ||
                      shopNameCtr.text.isEmpty ||
                      addressCtr.text.isEmpty ||
                      Provider.of<ShopInfo>(context, listen: false).shop.lat ==
                          0.0 ||
                      Provider.of<ShopInfo>(context, listen: false).shop.lng ==
                          0.0 ||
                      imageFile == null) {
                    await _showMyDialog(
                        'Error', 'Please fill and select all space');
                  } else {
                    Provider.of<ShopInfo>(context, listen: false)
                        .updateShopInformation(typeOfShopDropDownValue,
                            shopNameCtr.text, addressCtr.text);
                    Provider.of<ShopHoursInfo>(context, listen: false)
                        .updateShopHourList(newShopHoursList);
                    widget.callback(3);
                  }
                }
              },
              child: Container(
                width: 120,
                height: 50,
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: kTurquoise,
                ),
                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Padding textFormField(
    TextEditingController ctr,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: TextFormField(
        controller: ctr,
        maxLines: hintText == 'Address' ? 3 : 1,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              color: kTurquoise,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise, width: 2),
          ),
        ),
      ),
    );
  }

  void setShopHours(BuildContext context) {
    for (ShopHours shopHour
        in Provider.of<ShopHoursInfo>(context, listen: false).shopHoursList) {
      print(shopHour.day + " " + shopHour.startTime + " " + shopHour.endTime);
      newShopHoursList.add(shopHour);
      if (shopHour.day == 'Monday') {
        isMonday = true;
        mondayStartDropDown = shopHour.startTime;
        mondayEndDropDown = shopHour.endTime;
      } else if (shopHour.day == 'Tuesday') {
        isTuesday = true;
        tuesdayStartDropDown = shopHour.startTime;
        tuesdayEndDropDown = shopHour.endTime;
      }
      if (shopHour.day == 'Wednesday') {
        isWednesday = true;
        wednesdayStartDropDown = shopHour.startTime;
        wednesdayEndDropDown = shopHour.endTime;
      }
      if (shopHour.day == 'Thursday') {
        isThursday = true;
        thursdayStartDropDown = shopHour.startTime;
        thursdayEndDropDown = shopHour.endTime;
      }
      if (shopHour.day == 'Friday') {
        isFriday = true;
        fridayStartDropDown = shopHour.startTime;
        fridayEndDropDown = shopHour.endTime;
      }
      if (shopHour.day == 'Saturday') {
        isSaturday = true;
        saturdayStartDropDown = shopHour.startTime;
        saturdayEndDropDown = shopHour.endTime;
      }
      if (shopHour.day == 'Sunday') {
        isSunday = true;
        sundayStartDropDown = shopHour.startTime;
        sundayEndDropDown = shopHour.endTime;
      }
    }
  }

  void setShopInfo(BuildContext context) {
    Shop oldShopInfo = Provider.of<ShopInfo>(context, listen: false).shop;
    shopNameCtr.text = oldShopInfo.name;
    addressCtr.text = oldShopInfo.address;
    typeOfShopDropDownValue = oldShopInfo.typeOfShop;
    imageFile = Provider.of<ShopInfo>(context, listen: false).imageFile;
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
