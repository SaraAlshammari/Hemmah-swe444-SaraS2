import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hemmah/change_passwordA.dart';
import 'package:hemmah/start.dart';

import 'aboutusApplicant.dart';
import 'applicantProfile.dart';

class SettingsApplicant extends StatefulWidget {
  const SettingsApplicant({super.key});

  @override
  State<SettingsApplicant> createState() => _SettingsApplicant();
}

class _SettingsApplicant extends State<SettingsApplicant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF616161),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const applicantProfile()),
            );
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: ' Playfair Displa',
            color: Color(0xFF616161),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: const Color(0xFFF4F4F4),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Icon(
                    Icons.info,
                    color: Color(0xFFD1C4E9),
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const aboutusApplicant(),
                        ),
                      );
                      // Navigator.pushNamed(context, aboutUs());
                    },
                    child: const Text(
                      'About us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF616161),
                        fontFamily: 'Playfair Displa',
                        fontWeight: FontWeight.w700,
                        height: 1.88,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: const Color(0xFFF4F4F4),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Icon(
                    Icons.password_rounded,
                    color: Color(0xFFD1C4E9),
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordA(),
                        ),
                      );
                    },
                    child: const Text(
                      'Change Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF616161),
                        fontFamily: 'Playfair Displa',
                        fontWeight: FontWeight.w700,
                        height: 1.88,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: const Color(0xFFF4F4F4),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const SizedBox(
                    width: 27,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (!mounted) return;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Start()),
                      );
                    },

                    label: const Text(
                      'Logout',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF616161),
                        fontFamily: 'Playfair Displa',
                        fontWeight: FontWeight.w700,
                        height: 1.88,
                      ),
                    ),

                    icon: const Icon(
                      Icons.logout,
                      color: Color(0xFFD1C4E9),
                      size: 30,
                    ),
                    // SizedBox(width: 10,),

                    /*  Icon(
        Icons.login_outlined,
        color: Color.fromARGB(255, 25, 5, 83),
        size:30,
         ),
         SizedBox(width: 10,),
         new GestureDetector(
  onTap: () {
    Navigator.pushNamed(context, "");
  },
  child: new
        Text(
          'Logout',
          textAlign: TextAlign.center,
          style: TextStyle(
            color:Color.fromARGB(205, 0, 0, 0) ,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 1.88,
          ),
        ),
        */
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
