import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hemmah/componyProfile.dart';
import 'package:hemmah/job_list.dart';
import 'package:hemmah/post_job_screen.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

final credintial = FirebaseAuth.instance.currentUser;

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: GNav(
        color: const Color.fromARGB(255, 251, 246, 246),
        backgroundColor: const Color.fromARGB(255, 231, 227, 227),
        activeColor: const Color.fromARGB(255, 164, 112, 168),
        selectedIndex: 0,
        tabs: [
          GButton(
            icon: Icons.ad_units_outlined,
            iconColor: const Color.fromARGB(255, 135, 108, 139),
            onPressed: () {},
          ),
          const GButton(
            icon: Icons.add_alert_outlined,
            iconColor: Color.fromARGB(255, 135, 108, 139),
          ),
          GButton(
            icon: Icons.add_box_outlined,
            iconColor: const Color.fromARGB(255, 135, 108, 139),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostJobScreen()),
              );
            },
          ),
          GButton(
            icon: Icons.account_box,
            iconColor: const Color.fromARGB(255, 135, 108, 139),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const componyProfile(),
                ),
              );
            },
          ),

          // ontapechange: (index) { home i 0 azed ala a5r wa7d}
        ],
      ),
      body: JobList(),
    );
  }
}
