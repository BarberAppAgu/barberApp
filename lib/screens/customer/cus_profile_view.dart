import 'dart:ui';
import 'package:barber_app/models/basicUser.dart';
import 'package:barber_app/providers/basicUserInfo.dart';
import 'package:barber_app/screens/customer/cus_edit_profile_view.dart';
import 'package:barber_app/screens/customer/cus_favorite_view.dart';
import 'package:barber_app/screens/customer/cus_home_view.dart';
import 'package:barber_app/screens/customer/cus_reservation_view.dart';
import 'package:barber_app/screens/on_board.dart';
import 'package:barber_app/services/auth_shared_pref.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class CusProfileView extends StatefulWidget {
// const CusProfileView({Key? key}) : super(key: key);
  String? name;
  String? phone="";
  CusProfileView.withParam(this.name,this.phone);
  CusProfileView();



  @override
  State<CusProfileView> createState() => _CusProfileViewState();
}

class _CusProfileViewState extends State<CusProfileView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: kBackgroundColor,
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.08,
              child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: kButtonColor,
                  ),
                  child: Text("Operations")),
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.heart,
                color: Colors.red,
              ),
              title: const Text("Favourite Enterprises"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CusFavoriteView()));
              },
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.calendar,
                color: Colors.red,
              ),
              title: const Text("Reservations"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CusReservationView()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text("Log Out"),
              onTap: () async {
                await AuthSharedPref().removeAuthData();
                Provider.of<BasicUserInfo>(context, listen: false)
                    .clearUserInfo();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => OnBoard()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: height * 0.075,
        child: ElevatedButton(
          onPressed: () {

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CusEditProfileView()));
          },
          child: Text(
            "Edit Information",
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
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => CusHomeView()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Image.asset(
          'assets/image/logo.png',
          fit: BoxFit.cover,
          height: height * 0.12,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
            preferredSize: const Size.fromHeight(4.0)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            color: kButtonColor,
            size: height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: height * 0.03),
            child: Text(
              "${Provider.of<BasicUserInfo>(context, listen: true).basicUser.name} ${Provider.of<BasicUserInfo>(context, listen: true).basicUser.surname}",
              style: TextStyle(
                  fontSize: height * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                child: Divider(
                  indent: 20.0,
                  endIndent: 10.0,
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: width * 0.6),
            child: Text(
              "Contact Information",
              style: TextStyle(
                fontSize: height * 0.020,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.02, bottom: height * 0.04),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              width: width * 0.9,
              height: height * 0.061,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  Provider.of<BasicUserInfo>(context, listen: false)
                      .basicUser
                      .phoneNumber,
                  style: TextStyle(
                    fontSize: height * 0.020,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: width * 0.6),
            child: Text(
              "City Information",
              style: TextStyle(
                fontSize: height * 0.020,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              width: width * 0.9,
              height: height * 0.1,
              child: Align(
                alignment: Alignment.center,
                heightFactor: height * 0.1,
                child: Text(
                  Provider.of<BasicUserInfo>(context, listen: false)
                      .basicUser
                      .city,
                  style: TextStyle(
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
