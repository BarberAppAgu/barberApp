
import 'package:barber_app/screens/customer/cus_create_appointment.dart';
import 'package:flutter/material.dart';
import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../../constants.dart';



class TimeSelectionPage extends StatefulWidget {
  const TimeSelectionPage({Key? key}) : super(key: key);

  @override
  _TimeSelectionPageState createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  var selectedDate;
  DateTime _dateTime = DateTime.now();

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateAppointmet()),
            );

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
            primary: kButtonColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),


          ),
        ),
      ),

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kButtonColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0, bottom: 15.0),
              child: Center(child: Text("DATE & TIME"
              ,style: TextStyle(
                  fontSize: height*0.030
                ),)),
            ),
            Container(
              height: height*0.20,
              child: AnimatedHorizontalCalendar(
                  unSelectedBoxShadow: BoxShadow(
                    color: kButtonColor
                  ),
                  tableCalenderButtonColor: kButtonColor,
                  tableCalenderIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  initialDate: DateTime.now(),
                  colorOfWeek: kButtonColor,
                  date: DateTime.now(),
                  textColor: Colors.black45,
                  backgroundColor: Colors.white,
                  tableCalenderThemeData: ThemeData.light().copyWith(
                    primaryColor: Colors.yellow,
                    buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal),
                    colorScheme: ColorScheme.light(primary: kButtonColor)
                        .copyWith(secondary: kButtonColor),
                  ),
                  selectedColor: kButtonColor,
                  onDateSelected: (date) {
                    selectedDate = date;
                  }),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                width: width*0.7,
                  height: height*0.4,
                  decoration: BoxDecoration(
                    color: kButtonColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(2, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: hourMinute12HCustomStyle()
              ),
            ),


          ],
        ),
      ),


    );
  }
  Widget hourMinute12HCustomStyle(){
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(
          fontSize: 24,
          color: Colors.black
      ),
      highlightedTextStyle: TextStyle(
          fontSize: 24,
          color: Colors.white
      ),
      spacing: 40,
      itemHeight: 80,
      isForce2Digits: true,
      minutesInterval: 60,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
