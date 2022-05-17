
import 'package:barber_app/screens/customer/cus_create_appointment.dart';
import 'package:flutter/material.dart';
import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';
import 'package:time_range/time_range.dart';
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
            SizedBox(
              height: height*0.20,
              child: AnimatedHorizontalCalendar(
                  unSelectedBoxShadow: const BoxShadow(
                    color: kButtonColor
                  ),
                  tableCalenderButtonColor: kButtonColor,
                  tableCalenderIcon: const Icon(
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
                    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.normal),
                    colorScheme: const ColorScheme.light(primary: kButtonColor)
                        .copyWith(secondary: kButtonColor),
                  ),
                  selectedColor: kButtonColor,
                  onDateSelected: (date) {
                    selectedDate = date;
                  }),
            ),
            const SizedBox(height: 40,),
            TimeRange(
              fromTitle: const Text('From', style: TextStyle(fontSize: 18, color: Colors.black),),
              toTitle: const Text('To', style: TextStyle(fontSize: 18, color: Colors.black),),
              titlePadding: 20,
              textStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
              activeTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              borderColor: Colors.grey,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: kButtonColor,
              activeBorderColor: Colors.grey,
              firstTime: const TimeOfDay(hour: 08, minute: 00),
              lastTime: const TimeOfDay(hour: 24, minute: 00),
              timeStep: 60,
              timeBlock: 30,
              onRangeCompleted: (range) => setState(() => print(range)),

            ),





          ],
        ),
      ),


    );
  }
}
