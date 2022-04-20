import 'package:flutter/material.dart';

class CusHomeView extends StatefulWidget {
  const CusHomeView({Key? key}) : super(key: key);

  @override
  _CusHomeViewState createState() => _CusHomeViewState();
}

class _CusHomeViewState extends State<CusHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Home View'),
      ),
    );
  }
}
