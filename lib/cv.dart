import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hemmah/applicantProfile.dart';
import 'package:hemmah/global/global.dart';
import 'package:hemmah/model/cv_model.dart';
import 'package:quickalert/quickalert.dart';

import 'multiselect.dart';
 
class cv extends StatefulWidget {
  const cv({super.key});

  @override
  State<cv> createState() => _cvState();
}

class _cvState extends State<cv> {
  List<String> dropList = [
    'Arabic',
    'English',
    'Spanish',
    'chinees',
    'korean',
  ];

  final credintial = FirebaseAuth.instance.currentUser;
  final edu = TextEditingController();
  final major = TextEditingController();
  final cert = TextEditingController();
  final workexp = TextEditingController();
  final ve = TextEditingController();
  final skill = TextEditingController();
  final lang = TextEditingController();
   final String dropdown="";
  String eduu = "";
  List<String> _selectedItems = [];
  @override
  void initState() {
    if (kApplicantModel?.cvModel != null) {
      edu.text = kApplicantModel!.cvModel!.education ?? "";
      major.text = kApplicantModel!.cvModel!.skills ?? "";
      cert.text = kApplicantModel!.cvModel!.certifications ?? "";
      workexp.text = kApplicantModel!.cvModel!.workExperience ?? "";
      ve.text = kApplicantModel!.cvModel!.volunteeringExperience ?? "";
      skill.text = kApplicantModel!.cvModel!.project ?? "";
      lang.text = kApplicantModel!.cvModel!.languages ?? "";
    }
    super.initState();
  }

  String dropdownvalue = 'Bechelor Degree';

  // List of items in our dropdown menu
  var items = [
    'Doctorate Degree',
    'Master degree',
    'Bechelor Degree',
    'High school degree',
    'less than high school degree',
  ];
  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
      'ENGLISH',
      'ARABIC',
      'SPANISH',
      'GERMAN',
      'CHINESE',
      'JAPANESE',
      'FRENCH' ,
      'KOREAN',
      'TURKISH'
    ];

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }

  String validate() {
     if (major.text == "")
      return "empty";
    else if (cert.text == "")
      return "empty";
    else if (workexp.text == "")
      return "empty";
    else if (ve.text == "")
      return "empty";
    else if (skill.text == "")
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
            onPressed: () {
              Navigator.pushNamed(context, '/homepageapplicant');
            },
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
                height: 50,
              ),
              Row(
                children: [
                  Text("Education :",style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          eduu = newValue.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Your Major :",style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: major,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "software engineer",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Certifications :",style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: cert,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Certifications",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Work Experience :",style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      // we return "null" when something is valid

                      controller: workexp,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Work Experience",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Volunteer Experience :",style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold)),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      // we return "null" when something is valid

                      controller: ve,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Volunteer Experience",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Skills :" ,style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      // we return "null" when something is valid

                      controller: skill,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Computer skills ...",
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               ElevatedButton(
              onPressed:_showMultiSelect, 
              child: const Text('Select Your spoken languages'),
            ),
            const Divider(
              height: 30,
            ),
            // display selected items
            Wrap(
              children: _selectedItems
                  .map((e) => Chip(
                        label: Text(e),
                      ))
                  .toList(),),
            
              
            
              Container(
                width: 120,
                margin: const EdgeInsets.only(left: 0),
                child: ElevatedButton(
                  onPressed: () async {
                     var stringList = _selectedItems.join(" , ");
                      print(stringList);
                      print(eduu.toString());

                    if (validate() == "Done") {

                      CVModel cv = CVModel(
                        education: eduu.toString(),
                        skills: major.text,
                        certifications: cert.text,
                        workExperience: workexp.text,
                        volunteeringExperience: ve.text,
                        project: skill.text,
                        languages: stringList,
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
