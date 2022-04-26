import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/basicUserInfo.dart';

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

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

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
        Container(
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
              Row(
                children: [
                  Switch(
                    value: isMonday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      setState(() {
                        isMonday = _val;
                      });
                    },
                  ),
                  Text(
                    'Monday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              Row(
                children: [
                  Switch(
                    value: isTuesday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      setState(() {
                        isTuesday = _val;
                      });
                    },
                  ),
                  Text(
                    'Tuesday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              Row(
                children: [
                  Switch(
                    value: isWednesday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      setState(() {
                        isWednesday = _val;
                      });
                    },
                  ),
                  Text(
                    'Wednesday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              Row(
                children: [
                  Switch(
                    value: isThursday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      setState(() {
                        isThursday = _val;
                      });
                    },
                  ),
                  Text(
                    'Thursday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              Row(
                children: [
                  Switch(
                    value: isFriday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      setState(() {
                        isFriday = _val;
                      });
                    },
                  ),
                  Text(
                    'Friday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              Row(
                children: [
                  Switch(
                    value: isSaturday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      setState(() {
                        isSaturday = _val;
                      });
                    },
                  ),
                  Text(
                    'Saturday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              Row(
                children: [
                  Switch(
                    value: isSunday,
                    activeColor: kTurquoise,
                    onChanged: (_val) {
                      setState(() {
                        isSunday = _val;
                      });
                    },
                  ),
                  Text(
                    'Sunday',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
                                    imageFile = File(image.path);
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
                  decoration: BoxDecoration(
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
              onTap: () {
                if (Provider.of<BasicUserInfo>(context, listen: false)
                        .basicUser
                        .type ==
                    'Employer') {
                  widget.callback(3);
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
}
