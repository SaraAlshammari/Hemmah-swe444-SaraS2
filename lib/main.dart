import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hemmah/SettingsC.dart';
import 'package:hemmah/aboutus.dart';
import 'package:hemmah/cv.dart';
import 'package:hemmah/signup.dart';
import 'package:hemmah/start.dart';
import 'package:hemmah/userchoice.dart';

import 'SignupAsApplicants.dart';
import 'aboutusApplicant.dart';
import 'applicantProfile.dart';
import 'change_password.dart';
import 'change_passwordA.dart';
import 'componyProfile.dart';
import 'homepage.dart';
import 'homepageapplicant.dart';
import 'login.dart';
import 'settingsApplicant.dart';
import 'utils/notification_service.dart';

NotificationService notify = NotificationService.instance();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the background notification in a separate isolate.
  Isolate.spawn(
    (message) {
      // Do something with the background notification.
    },
    message,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await notify.initializeFCM();
  // Listen for background notifications.
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Start(),
        '/login': (context) => const Login(),
        "/signup": (context) => const Signup(),
        "/userchoice": (context) => const UserChoice(),
        "/SignupAsApplicants": (context) => const SignupAsApplicants(),
        "/homepage": (context) => const homepage(),
        "/homepageapplicant": (context) => const homepageapplicant(),
        "/componyProfile": (context) => const componyProfile(),
        "/Settings": (context) => const SettingsC(),
        "/aboutus": (context) => const aboutus(),
        "/aboutusApplicant": (context) => const aboutusApplicant(),
        "/applicantProfile": (context) => const applicantProfile(),
        "/SettingsApplicant": (context) => const SettingsApplicant(),
        "/change_password": (context) => const ChangePassword(),
        "/change_passwordA": (context) => const ChangePasswordA(),
        "/cv": (context) => const cv(),
      },
    );
  }
}
