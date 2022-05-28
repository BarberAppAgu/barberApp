import 'package:barber_app/models/basicUser.dart';
import 'package:barber_app/providers/basicUserInfo.dart';
import 'package:barber_app/screens/enter/sign_view.dart';
import 'package:barber_app/services/auth_shared_pref.dart';
import 'package:barber_app/services/server_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customer/cus_home_view.dart';
import 'employer/emp_home_view.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  Future<BasicUser> getAuthData() async {
    String storedEmail = await AuthSharedPref().readAuthData();
    if (storedEmail == '') {
      return BasicUser(
          email: '',
          password: '',
          name: '',
          surname: '',
          city: '',
          gender: '',
          birthday: '',
          phoneNumber: '');
    }
    Map<dynamic, dynamic>? resultedMapFetchUser =
        await ServerHandler().fetchOneUser(storedEmail);

    print(resultedMapFetchUser!['user']);

    BasicUser currentUser =
        BasicUser.fromMapForLogin(resultedMapFetchUser['user']);
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BasicUser>(
        future: getAuthData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BasicUser basicUser = snapshot.data!;
            Provider.of<BasicUserInfo>(context, listen: false)
                .updateAllUserInfo(basicUser);
            if (basicUser.name == '') {
              print('There is no user.');
              return SignView();
            } else {
              if (basicUser.shopId == null) {
                print('There is user. It is customer');
                return CusHomeView();
              } else {
                print('There is user. It is employer');
                return EmpHomeView();
              }
            }
          } else if (snapshot.hasError) {
            return const Text('Error');
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
