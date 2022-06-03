import 'package:barber_app/providers/data_on_order_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cus_services_view.dart';

class CreateAppointmet extends StatefulWidget {
  const CreateAppointmet({Key? key}) : super(key: key);

  @override
  State<CreateAppointmet> createState() => _CreateAppointmetState();
}

class _CreateAppointmetState extends State<CreateAppointmet> {
  bool agree = false;

  void _doSomething() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ServicesPage()),
    // );
    print('Hello_doSomething');
  }

  String BarberName = "Raif Akkaş Hair Design Studio";
  String ServiceName = "Hair Cutting ";
  String date = "13-05-2022";
  String hour = "11:30";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff83D1C1),
        title: Text("Appointment Details"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Color(0xff83D1C1), width: 2)),
      ),
      body: Consumer<DataOnOrderPage>(
        builder: (context, data, child)=> Column(
            children: [
              buildColumn(size, data.shop!.name),
              buildColumn(size, ServiceName),
              DateColumn(size, date, "Date"),
              DateColumn(size, hour, "Hour"),
              CheckboxRow(),
              CreateButton()
          ]
        ),
      ),
    );
  }

  Expanded CreateButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff83D1C1),
              ),
              onPressed: agree ? _doSomething : null,
              child: const Text('Create the Appointment')),
        ),
      ),
    );
  }

  Row CheckboxRow() {
    return Row(
      children: [
        Material(
          child: Checkbox(
            value: agree,
            onChanged: (value) {
              setState(() {
                agree = value ?? false;
              });
            },
          ),
        ),
        const Text(
          'I have read and accept terms and conditions',
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Column buildColumn(Size size, String text) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 1 / 15,
          width: size.width * 17 / 20,
          child: Container(alignment: Alignment.centerLeft, child: Text(text)),
        ),
        Center(
          child: Container(
            width: size.width * 17 / 20,
            child: Divider(
              height: 5,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Column DateColumn(Size size, String text, String type) {
    return Column(
      children: [
        SizedBox(
            height: size.height * 1 / 15,
            width: size.width * 17 / 20,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$type:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(text),
                ],
              ),
            )),
        Center(
          child: Container(
            width: size.width * 17 / 20,
            child: Divider(
              height: 5,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
