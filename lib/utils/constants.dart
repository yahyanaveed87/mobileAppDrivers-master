import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
// ignore: unnecessary_import
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get.dart';

const String parkingProductName = 'Parking Space';
const String evProductName = 'EV Charging';
const String carWashProductName = 'Car Wash';

const String homeTitle = 'Home';
const String bookingsTitle = 'Bookings';
const String profileTitle = 'Profile';
const String supportTitle = 'Support';
const String aboutTitle = 'About';
const String notificationsTitle = 'Notifications';
const String paymentHistoryTitle = 'Payment History';
const String tripsTitle = 'Trips';
const String shuttleServiceTitle = 'Shuttle Service';
const String newBookingTitle = 'New Booking';
const String shuttleBookingsTitle = 'Shuttle Bookings';

const double fieldBorderRadius = 10;
Color fieldBorderColor = blueGradient[0];
Color floatingLabelColor = blueGradient[0];

heading1Style(Color color, {double? fontSize, FontWeight? fontWeight}) {
  return GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      fontSize: fontSize ?? 25,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color);
}

heading2Style(Color color, {double? fontSize}) {
  return GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      fontSize: fontSize ?? 15,
      fontWeight: FontWeight.bold,
      color: color);
}

heading2StyleNormal(Color color, {double? fontSize}) {
  return GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      fontSize: fontSize ?? 15,
      fontWeight: FontWeight.normal,
      color: color);
}

paragraph1Style(Color color,
    {FontWeight? fontWeight = FontWeight.normal, double? fontSize}) {
  return GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color,
      fontSize: fontSize ?? 15);
}

paragraphStyle(Color color) {
  return GoogleFonts.roboto(
      fontStyle: FontStyle.normal,
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: color);
}

infoGradient() {
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: orangeGradient,
  );
}

successGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff36D1DC), Color(0xff5B86E5)],
  );
}

errorGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xffFF416C), Color(0xffFF4B2B)],
  );
}

InputDecoration getPasswordInputDecorationSignup(
    String label, bool isPasswordVisible, Function togglePasswordVisibility) {
  return InputDecoration(
    suffixIcon: IconButton(
      icon: Icon(
        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: isPasswordVisible ? blueGradient[1] : Colors.grey,
      ),
      onPressed: () {
        togglePasswordVisibility();
      },
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide(width: 2, color: fieldBorderColor)),
    filled: true,
    labelText: label,
    floatingLabelStyle: TextStyle(color: floatingLabelColor),
    fillColor: whiteShade,
  );
}

InputDecoration getPasswordInputDecorationSignin(
    String label,
    bool isPasswordVisible,
    Function togglePasswordVisibility,
    Function onForgotPassword) {
  return InputDecoration(
    counter: TextButton(
      child: Text(
        'Forgot Password?',
        style: paragraph1Style(blueGradient[0], fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        onForgotPassword();
      },
    ),
    suffixIcon: IconButton(
      icon: Icon(
        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
        color: isPasswordVisible ? blueGradient[0] : Colors.grey,
      ),
      onPressed: () {
        togglePasswordVisibility();
      },
    ),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide(width: 2, color: fieldBorderColor)),
    filled: true,
    labelText: label,
    floatingLabelStyle: TextStyle(color: floatingLabelColor),
    fillColor: whiteShade,
  );
}

InputDecoration getContainerInputDecoration() {
  return InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide(width: 2, color: fieldBorderColor)),
    filled: true,
    labelText: '',
    floatingLabelStyle: const TextStyle(color: Colors.lightGreen),
    fillColor: Colors.transparent,
  );
}

InputDecoration getPhoneInputDecoration(String label) {
  return InputDecoration(
    prefixText: '+61 ',
    prefixStyle: paragraph1Style(blueGradient[0]),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide(width: 2, color: fieldBorderColor)),
    filled: true,
    labelText: label,
    floatingLabelStyle: TextStyle(color: floatingLabelColor),
    fillColor: whiteShade,
  );
}

InputDecoration getPassengerCountDecoration(String label) {
  return InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide(width: 2, color: fieldBorderColor)),
    filled: true,
    labelText: label,
    floatingLabelStyle: TextStyle(color: floatingLabelColor),
    fillColor: Colors.transparent,
  );
}

InputDecoration getProfileInputDecoration(String label) {
  return InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldBorderRadius),
        borderSide: BorderSide(width: 2, color: fieldBorderColor)),
    filled: true,
    labelText: label,
    floatingLabelStyle: TextStyle(color: floatingLabelColor),
    fillColor: whiteShade,
  );
}

showGetSnackbar(String title, String msg, {error = true}) {
  return Get.snackbar(title, msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: primaryAccent,
      backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: error ? redGradient : greenGradient),
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 500),
      icon: error
          ? const Icon(
              Icons.error,
              color: Colors.white,
            )
          : const Icon(
              Icons.check_box,
              color: Colors.white,
            ));
}
