
import 'package:flutter/material.dart';

import '../../models/enterprise.dart';
import '../shop/u_shop_info_page.dart';



class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

enum SingingCharacter { Smart, favorite, Min, Max }

class _ServicesPageState extends State<ServicesPage> {
  SingingCharacter? _character = SingingCharacter.Smart;
  Color primaryColor = Color(0xffF3F6F4); //gray
  bool isFavorite = true;
  int chosenSort = 0;
  Map<bool, Color> favorite_colors = {};
  List<Enterprise> entrprises = [
    Enterprise(70, 30, 'assets/image/barber2.jpg', false, 'Raif Akkaş', 30),
    Enterprise(80, 40, 'assets/barber2.jpg', false, 'Kerem Akkaş', 40),
    Enterprise(50, 80, 'assets/barber2.jpg', false, 'Hamza Akkaş', 80),
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
        shape: Border(bottom: BorderSide(color: Colors.black, width: 2)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list_sharp,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    context: context,
                    builder: (_) => StatefulBuilder(
                          builder: (BuildContext context, setState) => Stack(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ListView(
                                    children: [
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Sorting",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.black,
                                      ),
                                      ListTile(
                                        title: const Text(
                                            'Smart Sorting (default)'),
                                        leading: Radio<SingingCharacter>(
                                          value: SingingCharacter.Smart,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter? value) {
                                            setState(() {
                                              chosenSort = 1;
                                              _character = value;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Favorite Rating '),
                                        leading: Radio<SingingCharacter>(
                                          value: SingingCharacter.favorite,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter? value) {
                                            setState(() {
                                              print(value);
                                              chosenSort = 2;
                                              _character = value;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Minimum Price '),
                                        leading: Radio<SingingCharacter>(
                                          value: SingingCharacter.Min,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter? value) {
                                            setState(() {
                                              print(value);
                                              chosenSort = 3;
                                              _character = value;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Maximum Price '),
                                        leading: Radio<SingingCharacter>(
                                          value: SingingCharacter.Max,
                                          groupValue: _character,
                                          onChanged: (SingingCharacter? value) {
                                            setState(() {
                                              print(value);
                                              chosenSort = 4;
                                              _character = value;
                                            });
                                          },
                                        ),
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xff83D1C3),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (chosenSort == 1) {
                                                Navigator.pop(context);
                                                print(chosenSort);
                                              } else if (chosenSort == 2) {
                                                for (int i = 0;
                                                    i < entrprises.length;
                                                    i++) {
                                                  for (int j = i + 1;
                                                      j < entrprises.length;
                                                      j++) {
                                                    if (entrprises[i]
                                                            .FavAmount <
                                                        entrprises[j]
                                                            .FavAmount) {
                                                      var temp = entrprises[i];
                                                      entrprises[i] =
                                                          entrprises[j];
                                                      entrprises[j] = temp;
                                                    }
                                                  }
                                                }
                                                Navigator.pop(context);
                                                print(chosenSort);
                                              } else if (chosenSort == 3) {
                                                Navigator.pop(context);
                                                print(chosenSort);
                                              } else if (chosenSort == 4) {
                                                Navigator.pop(context);
                                                print(chosenSort);
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: size.width * 4 / 5,
                                            child: Center(
                                                child: Text(
                                              "Apply",
                                              style: TextStyle(fontSize: 20),
                                            )),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                    size.width / 2 - 40,
                                    0,
                                    size.width / 2 - 40,
                                    0,
                                  ),
                                  child: Divider(
                                    thickness: 3,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: size.height * 4 / 5,
              child: ListView.builder(
                itemBuilder: (context, _) {
                  return entrepriseMethod(
                    size,
                    entrprises[_],
                  );
                },
                padding: EdgeInsets.all(8),
                itemCount: entrprises.length,
              ),
            ),

          ),

        ],
      ),
    );
  }

  GestureDetector entrepriseMethod(Size size, Enterprise enterprise) {
    return GestureDetector(
      onTap:(){

          setState(() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const uShopInfoPage()),
            );

          });

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width * 4 / 5,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
              Container(
                width: size.width * 2 / 5,
                child: Image.asset(
                  'assets/image/barber2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        enterprise.name,
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Min ${enterprise.fee} TL",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Color(0xff83D1C3),
                                size: 15,
                              ),
                              Text(
                                "${enterprise.FavAmount}",
                                style: TextStyle(color: Color(0xff83D1C3)),
                              ),
                              Text(
                                "  (${enterprise.CommentAmount}+)",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                              icon: enterprise.isFav
                                  ? Icon(
                                      Icons.favorite,
                                      size: 35,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: 35,
                                    ),
                              color: Color(0xff83D1C3),
                              onPressed: () => setState(() {
                                print(enterprise.isFav);
                                enterprise.isFav = !enterprise.isFav;
                                print(enterprise.isFav);
                              }),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Widget buildSheet() =>
}
