import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hemmah/applicantProfile.dart';

import 'cv.dart';
import 'fb_firestore.dart';
import 'model/job_model.dart';
import 'widgets/jobs_custom_card_applicant.dart';

class homepageapplicant extends StatefulWidget {
  const homepageapplicant({super.key});

  @override
  State<homepageapplicant> createState() => _homepageapplicantState();
}

final credintial = FirebaseAuth.instance.currentUser;

class _homepageapplicantState extends State<homepageapplicant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF3E5F5),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Color(0xFF616161),
            ),
          ),
        ],
        title: const Text(
          "Home",
          style: TextStyle(
            fontFamily: ' Playfair Displa',
            color: Color(0xFF616161),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<JobModel>>(
        stream: FbFirestoreController().getAllJobs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemBuilder: (context, index) {
                var jobData = snapshot.data!.docs[index].data();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomJobCardForApplicant(
                    currentJob: jobData,
                  ),
                );
              },
            );
          } else {
            return const Padding(
              padding: EdgeInsets.only(top: 271.0, left: 70.0),
              child: Text(
                'Sorry, No Posted Jobs Yet',
                style: TextStyle(
                  color: Color(0xFF616161),
                  fontSize: 20,
                  fontFamily: 'Playfair Displa',
                  fontWeight: FontWeight.w700,
                  height: 1.88,
                ),
              ),
            );
          }
        },
      ),
      extendBodyBehindAppBar: false,
      bottomNavigationBar: GNav(
        color: const Color.fromARGB(255, 251, 246, 246),
        backgroundColor: const Color.fromARGB(255, 231, 227, 227),
        activeColor: const Color.fromARGB(255, 164, 112, 168),
        selectedIndex: 0,
        tabs: [
          GButton(
            icon: Icons.history_edu,
            iconColor: const Color.fromARGB(255, 135, 108, 139),
            onPressed: () {},
          ),
          const GButton(
            icon: Icons.add_alert_outlined,
            iconColor: Color.fromARGB(255, 135, 108, 139),
          ),
          GButton(
            icon: Icons.assignment,
            iconColor: const Color.fromARGB(255, 135, 108, 139),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const cv()),
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
                  builder: (context) => const applicantProfile(),
                ),
              );
            },
          ),

          // ontapechange: (index) { home i 0 azed ala a5r wa7d}
        ],
      ),
    );
  }
}
