import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/customer/formatter/max_lines_formatter.dart';
import 'cus_profile_view.dart';

class CusEditProfileView extends StatefulWidget {
  const CusEditProfileView({Key? key}) : super(key: key);

  @override
  _CusEditProfileViewState createState() => _CusEditProfileViewState();
}

class _CusEditProfileViewState extends State<CusEditProfileView> {
  bool isPasswordObsecure = true;
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final int maxLength = 234;
  final int maxLines = 5;
  final int maxLinesForced = 4;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: height * 0.075,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CusProfileView()));
            },
            child: Text(
              "Apply Changes",
              style: TextStyle(
                color: const Color(0xffF3F6F4),
                fontSize: height * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: kButtonColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Image.asset(
            'assets/image/logo.png',
            fit: BoxFit.cover,
            height: height * 0.12,
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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Personal Information",
                  style: TextStyle(
                    fontSize: height * 0.025,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              buildTextField("Name", false, nameController),
              buildTextField("Surname", false, surnameController),
              buildTextField("Password", true, passwordController),
              buildTextField("Phone Number", false, phoneNumberController),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  maxLines: maxLines,
                  maxLength: maxLength,
                  keyboardType: TextInputType.multiline,
                  inputFormatters: [MaxLinesTextInputFormatter(maxLinesForced)],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: kButtonColor),
                    ),
                    contentPadding: const EdgeInsets.only(bottom: 30, left: 20),
                    labelText: "Address",
                    labelStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, bool isPasswordTextField,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        obscureText: isPasswordTextField ? isPasswordObsecure : false,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: kButtonColor),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: kButtonColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: kButtonColor),
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1,
              )),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: kButtonColor)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(width: 1, color: kButtonColor)),
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 5, left: 20),
          labelText: labelText,
          labelStyle:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
