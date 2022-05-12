import 'package:flutter/material.dart';

import '../../constants.dart';

class CusFavoriteView extends StatefulWidget {
  const CusFavoriteView({Key? key}) : super(key: key);

  @override
  _CusFavoriteViewState createState() => _CusFavoriteViewState();
}

class _CusFavoriteViewState extends State<CusFavoriteView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Favourites",
          style: TextStyle(
            color: Colors.black,
          ),
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
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(4, 8),
                  ),
                ],
              ),
              child: const ListTile(
                title: Text("Kayıtlı Favoriniz bulunmamaktadır."),
              ),
            ),
          )
        ],
      ),
    );
  }
}
