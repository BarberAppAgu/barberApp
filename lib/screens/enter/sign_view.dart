import 'package:barber_app/constants.dart';
import 'package:barber_app/screens/customer/cus_home_view.dart';
import 'package:flutter/material.dart';

enum SignCondition { signIn, signUp }

class SignView extends StatefulWidget {
  const SignView({Key? key}) : super(key: key);

  @override
  _SignViewState createState() => _SignViewState();
}

class _SignViewState extends State<SignView> {
  SignCondition signCondition = SignCondition.signIn;

  GlobalKey<FormState> textFieldKey = GlobalKey<FormState>();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController passwordAgainCtr = TextEditingController();

  bool isCustomer = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Form(
        key: textFieldKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/logo/find_best_logo.png'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Divider(
                  height: 16,
                  color: Colors.black,
                  thickness: 1.5,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                signCondition == SignCondition.signIn ? 'Sign In' : 'Sign Up',
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              textFormField(
                emailCtr,
                Icon(
                  Icons.email,
                  color: kTurquoise,
                ),
                'Email',
              ),
              textFormField(
                passwordCtr,
                Icon(
                  Icons.lock,
                  color: kTurquoise,
                ),
                'Password',
              ),
              signCondition == SignCondition.signIn
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: kTurquoise,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              signCondition == SignCondition.signUp
                  ? textFormField(
                      passwordAgainCtr,
                      Icon(
                        Icons.lock,
                        color: kTurquoise,
                      ),
                      'Password Again')
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    signCondition == SignCondition.signUp
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              checkbox('Customer'),
                              checkbox('Employer'),
                            ],
                          )
                        : Container(),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (textFieldKey.currentState!.validate()) {
                          if (signCondition == SignCondition.signIn) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CusHomeView(),
                              ),
                            );
                          } else {}
                        }
                      },
                      child: Container(
                        width: signCondition == SignCondition.signIn
                            ? size.width - 32
                            : size.width / 2 - 16,
                        height: 60,
                        decoration: BoxDecoration(
                          color: kTurquoise,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            signCondition == SignCondition.signIn
                                ? 'Sign In'
                                : 'Sign Up',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    signCondition == SignCondition.signIn
                        ? 'Don\'t have account?'
                        : 'Do have account?',
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        signCondition == SignCondition.signIn
                            ? signCondition = SignCondition.signUp
                            : signCondition = SignCondition.signIn;
                        emailCtr.text = '';
                        passwordCtr.text = '';
                        passwordAgainCtr.text = '';
                      });
                    },
                    child: Text(
                      signCondition == SignCondition.signIn
                          ? 'Sign Up'
                          : 'Sign In',
                      style: TextStyle(color: kTurquoise),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row checkbox(String userType) {
    return Row(
      children: [
        Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: userType == 'Customer' ? isCustomer : !isCustomer,
            onChanged: (bool) {
              setState(() {
                userType == 'Customer' ? isCustomer = true : isCustomer = false;
              });
            }),
        Text(
          userType,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return kTurquoise;
    }
    return kTurquoise;
  }

  Padding textFormField(
    TextEditingController ctr,
    Icon icon,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return 'Don\'t leave blank';
          } else if (hintText != 'Email' &&
              signCondition == SignCondition.signUp &&
              passwordCtr.text != passwordAgainCtr.text) {
            return 'Please enter same password';
          }
        },
        controller: ctr,
        obscureText: hintText != 'Email' ? true : false,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(color: kTurquoise),
          ),
        ),
      ),
    );
  }
}
