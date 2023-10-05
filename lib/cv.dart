import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hemmah/applicantProfile.dart';
import 'package:hemmah/global/global.dart';
import 'package:hemmah/model/cv_model.dart';
import 'package:quickalert/quickalert.dart';

class cv extends StatefulWidget {
  const cv({super.key});

  @override
  State<cv> createState() => _cvState();
}

class _cvState extends State<cv> {
  final credintial = FirebaseAuth.instance.currentUser;
  final edu = TextEditingController();
  final skil = TextEditingController();
  final cert = TextEditingController();
  final workexp = TextEditingController();
  final vol = TextEditingController();
  final proj = TextEditingController();
  final lang = TextEditingController();
  @override
  void initState() {
    if (kApplicantModel?.cvModel != null) {
      edu.text = kApplicantModel!.cvModel!.education ?? "";
      skil.text = kApplicantModel!.cvModel!.skills ?? "";
      cert.text = kApplicantModel!.cvModel!.certifications ?? "";
      workexp.text = kApplicantModel!.cvModel!.workExperience ?? "";
      vol.text = kApplicantModel!.cvModel!.volunteeringExperience ?? "";
      proj.text = kApplicantModel!.cvModel!.project ?? "";
      lang.text = kApplicantModel!.cvModel!.languages ?? "";
    }
    super.initState();
  }

  String validate() {
    if (edu.text == "") {
      return "empty";
    } else if (skil.text == "")
      return "empty";
    else if (cert.text == "")
      return "empty";
    else if (workexp.text == "")
      return "empty";
    else if (vol.text == "")
      return "empty";
    else if (proj.text == "")
      return "empty";
    else if (lang.text == "") return "empty";

    return "Done";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF3E5F5),
        actions: const [],
        title: const Text(
          "CV",
          style: TextStyle(
            fontFamily: ' Playfair Displa',
            color: Color(0xFF616161),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: GNav(
        color: const Color.fromARGB(255, 251, 246, 246),
        backgroundColor: const Color.fromARGB(255, 231, 227, 227),
        activeColor: const Color.fromARGB(255, 164, 112, 168),
        selectedIndex: 0,
        tabs: [
          GButton(
            icon: Icons.history_edu,
            iconColor: const Color.fromARGB(255, 135, 108, 139),
            onPressed: () {Navigator.pushNamed(context, '/homepageapplicant');},
          ),
          const GButton(
            icon: Icons.add_alert_outlined,
            iconColor: Color.fromARGB(255, 135, 108, 139),
          ),
          const GButton(
            icon: Icons.assignment,
            iconColor: Color.fromARGB(255, 135, 108, 139),
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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              Container(
                height: 150,
                width: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(110)),
                  image: DecorationImage(
                    image: AssetImage('img/cv.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                // we return "null" when something is valid
                validator: (value) {
                  return value.toString().isNotEmpty ? null : "Empty";
                },
                controller: edu,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "Education",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  return value.toString().isNotEmpty ? null : "Empty";
                },
                controller: skil,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "Skills",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // we return "null" when something is valid
                validator: (value) {
                  return value.toString().isNotEmpty ? null : "Empty";
                },
                controller: cert,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "Certifications",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // we return "null" when something is valid
                validator: (value) {
                  return value.toString().isNotEmpty ? null : "Empty";
                },
                controller: workexp,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "Work Experience",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // we return "null" when something is valid
                validator: (value) {
                  return value.toString().isNotEmpty ? null : "Empty";
                },
                controller: vol,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "Volunteering Experience",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // we return "null" when something is valid
                validator: (value) {
                  return value.toString().isNotEmpty ? null : "Empty";
                },
                controller: proj,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "Projects",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // we return "null" when something is valid
                validator: (value) {
                  return value.toString().isNotEmpty ? null : "Empty";
                },
                controller: lang,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: const InputDecoration(
                  hintText: "Languages",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 120,
                margin: const EdgeInsets.only(left: 0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (validate() == "Done") {
                      CVModel cv = CVModel(
                        education: edu.text,
                        skills: skil.text,
                        certifications: cert.text,
                        workExperience: workexp.text,
                        volunteeringExperience: vol.text,
                        project: proj.text,
                        languages: lang.text,
                        notificationToken: kNotificationToken,
                      );

                      await applicantsCollection
                          .doc(kApplicantModel?.uId)
                          .update({
                        "cvModel": cv.toJson(),
                      }).then((value) {
                        kApplicantModel?.cvModel = cv;
                      });

                      QuickAlert.show(
                        context: context,
                        text: "Successfully saved",
                        type: QuickAlertType.success,
                      );
                    } else {
                      QuickAlert.show(
                        context: context,
                        text: "Something went wrong ",
                        type: QuickAlertType.error,
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 189, 171, 224),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.only(left: 23, right: 23),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  child: Text(
                    kApplicantModel?.cvModel != null ? "Update" : "Save",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFFF5F5F5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
