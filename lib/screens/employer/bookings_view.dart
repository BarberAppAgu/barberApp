import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import '../../models/BookingDetails.dart';

class BookingTrack extends StatefulWidget {
  const BookingTrack({Key? key}) : super(key: key);

  @override
  State<BookingTrack> createState() => _BookingTrackState();
}

class _BookingTrackState extends State<BookingTrack> {
  Color primaryColor = Color(0XFF83D1C3);
  var num = false;
  int i =0;
  List<BookingDetails> bookingDetails = [
    BookingDetails(
        date: "28 May 2022, 8am - 10am",
        image: Image.asset("assets/image/1.jpg"),
        Barbername: "Ömer Akcan"),
    BookingDetails(
        date: "28 May 2022, 8am - 10am",
        image: Image.asset("assets/image/1.jpg"),
        Barbername: "Hamza Duman"),
    BookingDetails(
        date: "28 May 2022, 8am - 10am",
        image: Image.asset("assets/image/anonymous.jpg"),
        Barbername: "Kerem Keskin"),
    BookingDetails(
        date: "28 May 2022, 8am - 10am",
        image: Image.asset("assets/image/1.jpg"),
        Barbername: "Ismayil"),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text("Campaigns"),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
      ),
      body: Center(
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.fromLTRB(8.0, 20, 8, 20),
                child: Text("WELCOME BACK!",
                    style: GoogleFonts.inter(
                        fontSize: 20, color: Color(0xFF7C99AC))),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                child: Text("COMPANY NAME",
                    style: GoogleFonts.inter(
                        fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),

            num == false ? LastBookingMethod(size, bookingDetails[i]) : LastBookingMethod(size, bookingDetails[i+1]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Next Appointments",
                      style: GoogleFonts.inter(
                          fontSize: 20, color: Color(0xFF7C99AC)))),
            ),
            Container(
              height: 160,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {


                  return BookingMethod(
                    size,
                    bookingDetails[index+1],
                  );
                },
                padding: EdgeInsets.all(8),
                itemCount: bookingDetails.length-1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LastBookingMethod(Size size, BookingDetails bd) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width * 4 / 5,
        height: 200,
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
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    child: Container(
                  width: size.width * 4 / 5 - 2,
                  decoration: BoxDecoration(
                    color: Color(0xFF11468F),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(" Appointment Request",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white,
                            ),
                            Text("  ${bd.date}",
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/image/anonymous.jpg"),
                    radius: 25,
                  ),
                ),
                Text("Omer Akcan", style: GoogleFonts.inter(fontSize: size.height*0.03))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: size.width * 3 / 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      primary: Color(0xFF11468F),
                    ),
                    onPressed: () {
                      setState(() {
                        num = true;
                      });
                    },
                    child: Text('Accept'),
                  ),
                ),
                SizedBox(
                  width: size.width * 3 / 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      primary: Color(0xFFD8D2CB),
                    ),
                    onPressed: () {
                      // Respond to button press
                    },
                    child: Text(
                      'Decline',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BookingMethod(Size size, BookingDetails bookingDetails) {
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/image/anonymous.jpg"),
                radius: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${bookingDetails.Barbername}",
                    style: TextStyle(fontSize: size.height*0.02),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 Text(
                   "${bookingDetails.date}",style: TextStyle( color: Color(0xff7C99AC), fontSize: size.height *0.02),
                 )
                ],
              ),
            ),

            SizedBox(
              width: 10,
            ),
            Row(
              
              children: [IconButton(

                icon:Icon(Icons.check),
                color: Colors.green, onPressed: () {  setState(() {
                  print("true");
                });},
              ),
                IconButton(

                  icon:Icon(Icons.clear),
                  color: Colors.red, onPressed: () {  setState(() {
                  print("true");
                });},
                )],
            ),
          ],
        ),
      ),
    );
  }
}
