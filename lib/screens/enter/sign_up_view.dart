import 'package:barber_app/constants.dart';
import 'package:barber_app/models/service.dart';
import 'package:barber_app/providers/basicUserInfo.dart';
import 'package:barber_app/providers/shop_info.dart';
import 'package:barber_app/services/server_handler.dart';
import 'package:barber_app/widgets/enter/worker_info_forms.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/basicUser.dart';
import '../../widgets/enter/service_info_forms.dart';
import '../../widgets/enter/personal_info_forms.dart';
import '../../widgets/enter/shop_info_forms.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  int stepIndex = 1;

  void updateStepIndex(int newIndex) {
    setState(() {
      stepIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                stepInSteps(Icons.person, 0),
                Provider.of<BasicUserInfo>(context, listen: false)
                            .basicUser
                            .type ==
                        'Employer'
                    ? Expanded(
                        child: Container(
                          height: 1,
                          color: kTurquoise,
                        ),
                      )
                    : Container(),
                Provider.of<BasicUserInfo>(context, listen: false)
                            .basicUser
                            .type ==
                        'Employer'
                    ? stepInSteps(Icons.location_on, 1)
                    : Container(),
                Provider.of<BasicUserInfo>(context, listen: false)
                            .basicUser
                            .type ==
                        'Employer'
                    ? Expanded(
                        child: Container(
                          height: 1,
                          color: kTurquoise,
                        ),
                      )
                    : Container(),
                Provider.of<BasicUserInfo>(context, listen: false)
                            .basicUser
                            .type ==
                        'Employer'
                    ? stepInSteps(Icons.timeline, 2)
                    : Container(),
                Provider.of<BasicUserInfo>(context, listen: false)
                            .basicUser
                            .type ==
                        'Employer'
                    ? Expanded(
                        child: Container(
                          height: 1,
                          color: kTurquoise,
                        ),
                      )
                    : Container(),
                Provider.of<BasicUserInfo>(context, listen: false)
                            .basicUser
                            .type ==
                        'Employer'
                    ? stepInSteps(Icons.supervisor_account, 3)
                    : Container(),
              ],
            ),
          ),
          Text(
            stepIndex == 1
                ? 'Personal Information'
                : stepIndex == 2
                    ? 'Shop Information'
                    : stepIndex == 3
                        ? 'Service Information'
                        : 'Worker Information',
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          Divider(
            color: kTurquoise,
            height: 24,
            thickness: 1.5,
          ),
          Expanded(
            child: stepIndex == 1
                ? PersonalInfoForms(callback: updateStepIndex)
                : stepIndex == 2
                    ? ShopInformationForms(callback: updateStepIndex)
                    : stepIndex == 3
                        ? ServiceInfoForms()
                        : WorkerInfoForms(),
          ),
        ],
      ),
      floatingActionButton: stepIndex == 3
          ? FloatingActionButton(
              backgroundColor: kTurquoise,
              onPressed: () {
                setState(() {
                  stepIndex = 4;
                });
              },
              child: const Text('Next'),
            )
          : stepIndex == 4
              ? FloatingActionButton(
                  backgroundColor: kTurquoise,
                  onPressed: () async {
                    print(Provider.of<ShopInfo>(context, listen: false)
                        .shop
                        .favNum
                        .toString());

                    /// Adding Shop to DB
                    Map<dynamic, dynamic>? resultMap = await ServerHandler()
                        .addNewShop(
                            shop: Provider.of<ShopInfo>(context, listen: false)
                                .shop);
                    // await _showMyDialog(resultMap!);
                  },
                  child: const Text('Finish'),
                )
              : Container(),
    );
  }

  Widget stepInSteps(IconData iconData, int index) {
    return GestureDetector(
      onTap: () {
        if (index <= stepIndex - 1) {
          setState(() {
            stepIndex = index + 1;
          });
        }
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: index < stepIndex ? kTurquoise : kTurquoise.withOpacity(0.5),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(Map<dynamic, dynamic> resultMap) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: resultMap['success'] == 0
              ? const Text('Error')
              : const Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('${resultMap['message']}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
