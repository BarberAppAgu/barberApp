import 'package:barber_app/screens/employer/emp_home_view.dart';
import 'package:checkmark/checkmark.dart';
import 'package:flutter/material.dart';

import '../../models/services_list_forCampagin.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  bool isAllChecked = false;
  String fee = '0';

  Color primaryColor = Color(0XFF83D1C3); //gray
  bool isFavorite = true;
  int chosenSort = 0;
  String discountDropDownValue = 'Select Discount';

  // List of items in our dropdown menu
  var items = [
    'Select Discount',
    '%5',
    '%10',
    '%15',
    '%20',
    '%25',
    '%30',
    '%35',
    '%40',
    '%45',
    '%50',
  ];
  Map<bool, Color> favorite_colors = {};
  List<Campaigns> campaigns = [
    Campaigns(
        service_name: "Hair Painting",
        checked: false,
        fee: 25,
        discountItem: 'Select Discount',
        isSelected: false),
    Campaigns(
        service_name: "Hair Cutting",
        checked: true,
        fee: 30,
        discountItem: 'Select Discount',
        isSelected: false),
    Campaigns(
        service_name: "Hair dry",
        checked: false,
        fee: 25,
        discountItem: 'Select Discount',
        isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: primaryColor,
        title: Text("Campaigns"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, _) {
            return campaginMethod(
              size,
              campaigns[_],
            );
          },
          padding: EdgeInsets.all(8),
          itemCount: campaigns.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black, //Floating action button on Scaffold
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmpHomeView()),
          );
        },
        child: Icon(Icons.send), //icon inside button
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //floating action button position to center

      bottomNavigationBar: BottomAppBar(
        //bottom navigation bar on scaffold
        color: Color(0XFF83D1C3),
        shape: CircularNotchedRectangle(),
        //shape of notch
        notchMargin: 5,
        //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmpHomeView()),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.people,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Padding campaginMethod(Size size, Campaigns campaigns) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width * 4 / 5,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 8),
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      campaigns.checked = !campaigns.checked;
                    });
                  },
                  child: SizedBox(
                    height: 24,
                    width: 24,
                    child: CheckMark(
                      inactiveColor: Colors.black,
                      active: campaigns.checked,
                      strokeWidth: 2,
                      duration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campaigns.service_name,
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: (campaigns.isSelected)
                        ? Row(
                            children: [
                              Text(
                                "${campaigns.fee} TL",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Icon(Icons.arrow_forward_rounded, size: 15),
                              Text(
                                " ${applyDiscount(campaigns.discountItem, campaigns.fee)} TL",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                "${campaigns.fee} TL",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4),
                child: DropdownButton(
                  // Initial Value
                  value: campaigns.discountItem,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: items == 'Select Discount'
                          ? Text(
                              items,
                              style: TextStyle(fontSize: 10),
                            )
                          : Text(
                              items,
                              style: TextStyle(fontSize: 15),
                            ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    campaigns.isSelected = true;
                    setState(() {
                      print(newValue);
                      campaigns.discountItem = newValue!;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }

  static int applyDiscount(String discount, int price) {
    String newDiscount = discount.substring(1);
    if (newDiscount == "elect Discount") {
      return price;
    } else {
      int IntDiscount = int.parse(newDiscount);
      return ((price * (100 - IntDiscount) / 100)).round();
    }
  }
// Text checkLine(String discount,Campaigns campaigns){
//  if(discount=="Select Discount"){
//    return Text("${campaigns.fee} TL",
//  style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough));
//  }
}
// Widget buildSheet() =>
