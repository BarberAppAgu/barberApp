import 'package:flutter/material.dart';

class EmpHomeView extends StatefulWidget {
  const EmpHomeView({Key? key}) : super(key: key);

  @override
  _EmpHomeViewState createState() => _EmpHomeViewState();
}

class _EmpHomeViewState extends State<EmpHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Home View'),
      ),
    );
  }
}
