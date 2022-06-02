import 'package:barber_app/providers/basicUserInfo.dart';
import 'package:barber_app/screens/employer/bookings_view.dart';
import 'package:barber_app/screens/employer/campaigns_view.dart';
import 'package:barber_app/screens/on_board.dart';
import 'package:barber_app/services/auth_shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';



class EmpHomeView extends StatefulWidget {
  const EmpHomeView({Key? key}) : super(key: key);

  @override
  _EmpHomeViewState createState() => _EmpHomeViewState();
}

class _EmpHomeViewState extends State<EmpHomeView> {
  @override
  Widget build(BuildContext context) {

    var height=MediaQuery.of(context).size.height;
    var width =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,





      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [

                Container(
                  width: width,
                  height: height*0.4,
                  child: Image.asset('assets/image/barber3.png', fit: BoxFit.fill,),
                ),

                Container(
                  width: width,
                  height: height*0.40,
                  color: Colors.black.withOpacity(0.6),
                ),
                Column(
                  children: [
                    Container(
                      width: width,
                      height: height*0.33,
                      child: Image.asset('assets/logo/logo2.png'),
                    ),
                    Text("Welcome, Hamza", style: const TextStyle(color: Colors.white, fontSize: 20),),

                  ],
                ),
                Positioned(top:10 , right:0,child: IconButton(onPressed: ()async{
                  await AuthSharedPref().removeAuthData();
                  Provider.of<BasicUserInfo>(context, listen: false)
                      .clearUserInfo();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => OnBoard()),
                          (route) => false);
                }, icon: Icon(Icons.logout, color: Colors.white))),

              ],
            ),

            SizedBox(height: height*0.05),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                Column(
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BookingTrack()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          color: Color(0xff83D1C3),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        width: width*0.35,
                        height: height*0.30,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.event, color: Colors.white,size: width*0.12,),
                            Text('BOOKINGs', style: TextStyle(color: Colors.white, fontSize: 15),),
                          ],
                        ),

                      ),
                    ),

                    SizedBox(height: height* 0.02),

                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: width*0.35,
                        height: height*0.20,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          color: Color(0xff83D1C3),
                          borderRadius: BorderRadius.circular(20.0),
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              children: [
                                Icon(Icons.favorite, color: Colors.white,size: width*0.12,),
                                Padding(
                                  padding:  EdgeInsets.only(left: width*0.05, top: width*0.035),
                                  child: Icon(Icons.mode_comment, color: Colors.white,size: width*0.12,),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: 30),
                              child: Text('FAVs and COMMENTs', style: TextStyle(color: Colors.white, fontSize: 15),),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                Column(

                  children: [

                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: width*0.35,
                        height: height*0.20,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          color: Color(0xff83D1C3),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.mode_edit, color: Colors.white,size: width*0.12,),
                            Text('EDIT', style: TextStyle(color: Colors.white, fontSize: 15),),
                          ],
                        ),

                      ),
                    ),
                    SizedBox(height: height* 0.02),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ServicesPage()),
                        );
                      },
                      child: Container(
                        width: width*0.35,
                        height: height*0.30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          color: Color(0xff83D1C3),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.card_giftcard, color: Colors.white,size: width*0.12,),
                            Text('CAMPAIGNs', style: TextStyle(color: Colors.white, fontSize: 15),),
                          ],
                        ),
                      ),
                    ),

                  ],
                )
              ],
            )
          ],
        ),
      ) ,
    );
  }
}
