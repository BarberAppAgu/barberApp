import 'package:barber_app/screens/customer/cus_booking_timeselection_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Initial Selected Value
  String dropdownvalue = 'Fön için personel seçiniz';
  String dropdownvalue2 = 'Manikür için personel seçiniz';

  // List of items in our dropdown menu
  var items = [
    'Fön için personel seçiniz',
    'Farketmez',
    'Rabia',
    'Hamza',
    'Kerem',
    'Kerem',
    'Ömer Uluyağmur',
    'Ömer Akcan',
  ];
  var items2 = [
    'Manikür için personel seçiniz',
    'Farketmez',
    'Rabia',
    'Hamza',
    'Kerem',
    'Kerem',
    'Ömer Uluyağmur',
    'Ömer Akcan',
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: height * 0.075,
        child: ElevatedButton(
          onPressed: () {
            //   Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => TimeSelectionPage()),
            // );
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
            primary: Color(0xFF83D1C1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF83D1C1),
        title: Text("Choose Personal"),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFE5E5E5),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: DropdownButton(
                  isExpanded: true,
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.030,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: DropdownButton(
                  isExpanded: true,
                  value: dropdownvalue2,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items2.map((String items2) {
                    return DropdownMenuItem(
                      value: items2,
                      child: Text(items2),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue2 = newValue!;
                    });
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: height * 0.030,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
