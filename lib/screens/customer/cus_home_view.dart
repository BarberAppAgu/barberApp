import 'package:barber_app/screens/customer/cus_profile_view.dart';
import 'package:barber_app/screens/customer/cus_services_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class CusHomeView extends StatefulWidget {
  const CusHomeView({Key? key}) : super(key: key);

  @override
  _CusHomeViewState createState() => _CusHomeViewState();
}

class _CusHomeViewState extends State<CusHomeView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final searchController = TextEditingController();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.solidCircleUser),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CusProfileView()));
            },
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Image.asset(
          'assets/image/logo.png',
          fit: BoxFit.cover,
          height: height * 0.12,
        ),
        bottom: PreferredSize(
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
            preferredSize: const Size.fromHeight(4.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height * 0.055,
                child: TextField(
                  controller: searchController,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: const InputDecoration(
                    hintText: "Search with place name",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(width: 1, color: kButtonColor),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Choose any service that you wish",
              style: TextStyle(color: Colors.black, fontSize: height * 0.027),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.1, vertical: height * 0.01),
              child: PreferredSize(
                  child: Container(
                    color: Colors.black,
                    height: 1.0,
                  ),
                  preferredSize: const Size.fromHeight(4.0)),
            ),
            GestureDetector(onTap:(){
              setState(() {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ServicesPage()),
                  );

              });
            },child: buildCategory("assets/image/coiffeurs.png", "Coiffeurs")),
      GestureDetector(onTap:(){
        setState(() {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ServicesPage()),
          );

        });
      },child: buildCategory("assets/image/barbers.png", "Barbers")),
      GestureDetector(onTap:(){
        setState(() {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ServicesPage()),
          );

        });
      },child: buildCategory(
                "assets/image/beutycenter.png", "Beuty And Aesthetic Center")),
      GestureDetector(onTap:(){
        setState(() {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ServicesPage()),
          );

        });
      },child:  buildCategory("assets/image/massage.png", "Spa & Massage Saloons")),
          ],
        ),
      ),
    );
  }

  Widget buildCategory(String imagePath, String imageName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRect(
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                ),
                // borderRadius: BorderRadius.circular(32),
              ),
            ),
            // Image.asset(
            //   imagePath,
            //   fit: BoxFit.cover,
            //   width: 390,
            // ),
          ),
          Positioned(
            bottom: 30,
            left: 5,
            child: Container(
                clipBehavior: Clip.none,
                padding: EdgeInsets.only(right: 50),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),
                  child: Text(
                    imageName,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
