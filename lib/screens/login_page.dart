// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_shuttle_driver/controllers/ShuttlesController.dart';
import 'package:space_shuttle_driver/controllers/StaffController.dart';
import 'package:space_shuttle_driver/model/Staff.dart';
import 'package:space_shuttle_driver/screens/homepage.dart';
import 'package:space_shuttle_driver/utils/constants.dart';
import 'package:space_shuttle_driver/widgets/rounded_button.dart';
import '../model/Shuttle.dart';
import '../utils/colors.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

class LoginPage extends StatefulWidget {
  String selectedStaff = '';
  String selectedShuttle = '';
  String pin = '';
  bool isPinVisible = false;
  final staffController = Get.put(StaffController());
  final shuttleController = Get.put(ShuttlesController());
  // ignore: use_super_parameters
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    checkActiveDriver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: orangeGradient,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          height: 200,
                          width: 200,
                        ),
                        Text(
                          'Sign In',
                          style: heading1Style(Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please enter your details below to sign in',
                          style: paragraph1Style(Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              FormBuilder(
                                  child: Column(
                                children: [
                                  Obx(() {
                                    // ignore: invalid_use_of_protected_member
                                    if (widget.staffController.staff.value
                                        .toList()
                                        .isNotEmpty) {
                                      return FormBuilderDropdown(
                                        decoration:
                                            getProfileInputDecoration('Driver'),
                                        name: 'driver',
                                        items: widget
                                            // ignore: invalid_use_of_protected_member
                                            .staffController
                                            .staff
                                            .value
                                            .toList()
                                            .map((e) => DropdownMenuItem(
                                                value: e.name,
                                                child: Text(e.name)))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            widget.selectedStaff =
                                                value.toString();
                                          });
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() {
                                    // ignore: invalid_use_of_protected_member
                                    if (widget.shuttleController.shuttles.value
                                        .toList()
                                        .isNotEmpty) {
                                      return FormBuilderDropdown(
                                        decoration: getProfileInputDecoration(
                                            'Shuttle'),
                                        name: 'driver',
                                        items: widget
                                            // ignore: invalid_use_of_protected_member
                                            .shuttleController
                                            .shuttles
                                            .value
                                            .where((element) =>
                                                element.driver == 'None')
                                            .toList()
                                            .map((e) => DropdownMenuItem(
                                                value: e.registration,
                                                child: Text(e.registration)))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            widget.selectedShuttle =
                                                value.toString();
                                          });
                                        },
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FormBuilderTextField(
                                    onChanged: (value) {
                                      setState(() {
                                        widget.pin = value ?? '';
                                      });
                                    },
                                    name: 'pin',
                                    decoration:
                                        getPasswordInputDecorationSignup(
                                            'Enter PIN', widget.isPinVisible,
                                            () {
                                      setState(() {
                                        widget.isPinVisible =
                                            !widget.isPinVisible;
                                      });
                                    }),
                                  )
                                ],
                              )),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 60,
                                child: RoundedButton(
                                  label: 'Log In',
                                  width: 250,
                                  labelColor: Colors.white,
                                  borderRadius: 20,
                                  gradient: orangeGradient,
                                  elevation: 3,
                                  onClick: () async {
                                    if (widget.selectedStaff.isNotEmpty &&
                                        widget.pin.isNotEmpty) {
                                      Staff staff = widget
                                          // ignore: invalid_use_of_protected_member
                                          .staffController
                                          .staff
                                          .value
                                          .toList()
                                          .firstWhere((element) =>
                                              element.name ==
                                              widget.selectedStaff);
                                      Shuttle shuttle = widget
                                          // ignore: invalid_use_of_protected_member
                                          .shuttleController
                                          .shuttles
                                          .value
                                          .toList()
                                          .firstWhere((element) =>
                                              element.registration ==
                                              widget.selectedShuttle);
                                      if (widget.pin == staff.pin) {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                          email: dotenv
                                              .env['FIREBASE_USER_EMAIL']!,
                                          password: dotenv
                                              .env['FIREBASE_USER_PASSWORD']!,
                                        );
                                        widget.staffController.setActiveDriver(
                                            staff.id, shuttle.registration);
                                        Get.to(() => Homepage());
                                      } else {
                                        Get.snackbar('Error', 'Invalid PIN');
                                      }
                                    } else {
                                      Get.snackbar('Error',
                                          'Please select a driver and enter PIN');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void checkActiveDriver() async {
    var prefs = await SharedPreferences.getInstance();
    var uid = prefs.getString('driver');
    // ignore: unnecessary_brace_in_string_interps, avoid_print
    print('driver uid found: ${uid}');
    if (uid != null) {
      Get.to(() => Homepage());
    }
  }
}
