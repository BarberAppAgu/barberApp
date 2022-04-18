import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  Color primaryColor = Color(0xffF3F6F4); //gray
  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var name = "Rafi Akaş- Hair Des..";
    var minPrice = 30;
    var commentAmount = 100;
    var amountFav = 70;
    Color _iconColor = Colors.red;

    var listItems = [
      Padding(
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
                  'assets/barber2.jpg',
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
                        "$name",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Min $minPrice TL",
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
                                "$amountFav",
                                style: TextStyle(color: Color(0xff83D1C3)),
                              ),
                              Text(
                                "  ($commentAmount+)",
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
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                              icon: isFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      size: 35,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: 35,
                                    ),
                              color: Color(0xff83D1C3),
                              onPressed: () =>
                                  setState(() => isFavorite = !isFavorite),
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
      Padding(
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
                  'assets/barber2.jpg',
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
                        "$name",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Min $minPrice TL",
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
                                "$amountFav",
                                style: TextStyle(color: Color(0xff83D1C3)),
                              ),
                              Text(
                                "  ($commentAmount+)",
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
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                              icon: isFavorite
                                  ? Icon(
                                Icons.favorite,
                                size: 40,
                              )
                                  : Icon(
                                Icons.favorite_border,
                                size: 40,
                              ),
                              color: Color(0xff83D1C3),
                              onPressed: () =>
                                  setState(() => isFavorite = !isFavorite),
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

      Padding(
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
                  'assets/barber2.jpg',
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
                        "$name",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Min $minPrice TL",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Color(0xff83D1C3),
                              size: 15,
                            ),
                            Text(
                              "$amountFav",
                              style: TextStyle(color: Color(0xff83D1C3)),
                            ),
                            Text(
                              "  ($commentAmount+)",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                              icon: isFavorite
                                  ? Icon(
                                Icons.favorite,
                                size: 40,
                              )
                                  : Icon(
                                Icons.favorite_border,
                                size: 40,
                              ),
                              color: Color(0xff83D1C3),
                              onPressed: () =>
                                  setState(() => isFavorite = !isFavorite),
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
      Padding(
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
                  'assets/barber2.jpg',
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
                        "$name",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Min $minPrice TL",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Color(0xff83D1C3),
                              size: 15,
                            ),
                            Text(
                              "$amountFav",
                              style: TextStyle(color: Color(0xff83D1C3)),
                            ),
                            Text(
                              "  ($commentAmount+)",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                              icon: isFavorite
                                  ? Icon(
                                Icons.favorite,
                                size: 40,
                              )
                                  : Icon(
                                Icons.favorite_border,
                                size: 40,
                              ),
                              color: Color(0xff83D1C3),
                              onPressed: () =>
                                  setState(() => isFavorite = !isFavorite),
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
      Padding(
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
                  'assets/barber1.png',
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
                        "$name",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Min $minPrice TL",
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Color(0xff83D1C3),
                                size: 15,
                              ),
                              Text(
                                "$amountFav",
                                style: TextStyle(color: Color(0xff83D1C3)),
                              ),
                              Text(
                                "  ($commentAmount+)",
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: IconButton(
                              icon: isFavorite
                                  ? Icon(
                                Icons.favorite,
                                size: 40,
                              )
                                  : Icon(
                                Icons.favorite_border,
                                size: 40,
                              ),
                              color: Color(0xff83D1C3),
                              onPressed: () =>
                                  setState(() => isFavorite = !isFavorite),
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
    ];

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
              // do something
            },
          )
        ],
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: (context, _) {
          return listItems[_];
        },
        padding: EdgeInsets.all(8),
        itemCount: listItems.length,
      )),
    );
  }
}
