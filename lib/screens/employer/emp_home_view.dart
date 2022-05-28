import 'package:barber_app/screens/on_board.dart';
import 'package:barber_app/services/auth_shared_pref.dart';
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
      body: Center(
        child: TextButton(
          onPressed: () async {
            await AuthSharedPref().removeAuthData();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => OnBoard()),
                (route) => false);
          },
          child: Text('Log Out'),
        ),
      ),
    );
  }
}
