import 'package:barber_app/constants.dart';
import 'package:barber_app/models/service.dart';
import 'package:barber_app/providers/basicUserInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/basicUser.dart';
import '../../widgets/enter/order_info_forms.dart';
import '../../widgets/enter/personalInfoForms.dart';
import '../../widgets/enter/shopInfoForms.dart';

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
              ],
            ),
          ),
          Text(
            stepIndex == 1
                ? 'Personal Information'
                : stepIndex == 2
                    ? 'Shop Information'
                    : 'Order Information',
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
                    : orderInfoForms(),
          ),
        ],
      ),
    );
  }

  Widget stepInSteps(IconData iconData, int index) {
    return GestureDetector(
      onTap: () {},
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
}
