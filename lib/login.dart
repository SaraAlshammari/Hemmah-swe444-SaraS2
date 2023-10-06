import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hemmah/global/global.dart';
import 'package:hemmah/model/company_model.dart';
import 'package:password_field_validator/password_field_validator.dart';
import 'package:quickalert/quickalert.dart';

import 'model/applicant_model.dart';
import 'reset_password.dart';

final credintial = FirebaseAuth.instance.currentUser;

class Login extends StatefulWidget {
  final bool? isApplicant;
  const Login({
    super.key,
    this.isApplicant,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool? isApplicant = widget.isApplicant;
  final emailp = TextEditingController();

  bool isLoading = false;
  bool _obscureText = false;

  String _password = "";

  var state;
  String u = "";
  String vv = "";

  final passp = TextEditingController();

  @override
  void dispose() {
    emailp.dispose();
    passp.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String validate() {
    if (emailp.text == "") {
      return "emptyE";
    } else if (passp.text == "") {
      return "emptyP";
    } else {
      return "done";
    }
  }

  Future<bool> login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailp.text,
        password: passp.text,
      );

      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      u = user!.uid;
      var collection = FirebaseFirestore.instance.collection('Applicants');
      var collection1 = FirebaseFirestore.instance.collection('Compony');

      collection.snapshots().listen((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          //     kApplicantModel = ApplicantModel.fromJson(doc.data(), doc.id);
          //     log("kApplicantModel $kApplicantModel");

          if (doc.id == u) {
            state = "A";
          }

          //     // <-- Retrieving the value.
        }
      });
      collection1.snapshots().listen((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          //     kCompanyModel = CompanyModel.fromJson(doc.data(), doc.id);
          //     kIsApplicant = false;
          //     log("kCompanyModel $kCompanyModel");
          if (doc.id == u) {
            state = "C";
          }

          //     // <-- Retrieving the value.
        }
      });
      if (isApplicant == true) {
        state = "A";
        try {
          final response = await applicantsCollection.doc(u).get();

          if (response.exists) {
            kApplicantModel =
                ApplicantModel.fromJson(response.data()!, response.id);

            if (kApplicantModel?.notificationToken != kNotificationToken) {
              await applicantsCollection.doc(u).update({
                "notificationToken": kNotificationToken,
              });
            }
            log("kApplicantModel $kApplicantModel");
          }
        } catch (e) {
          log("error $e");
        }
      } else {
        state = "C";
        try {
          final response = await componyCollection.doc(u).get();

          if (response.exists) {
            kCompanyModel =
                CompanyModel.fromJson(response.data()!, response.id);
            isApplicant = false;
            if (kCompanyModel?.notificationToken != kNotificationToken) {
              await componyCollection.doc(u).update({
                "notificationToken": kNotificationToken,
              });
            }

            log("kCompanyModel $kCompanyModel");
          }
        } catch (e) {
          log("error $e");
        }
      }

      vv = "D";
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        QuickAlert.show(
          context: context,
          text: "No user found for that email.",
          type: QuickAlertType.warning,
        );

        vv = "notfound";
        return false;
      } else if (e.code == 'wrong-password') {
        QuickAlert.show(
          context: context,
          text: "Wrong password provided for that user.",
          type: QuickAlertType.warning,
        );

        vv = "wrong";
        return false;
      } else {
         QuickAlert.show(
          context: context,
          text: "Error",
          type: QuickAlertType.warning,
        );
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: const SizedBox(
                      width: 349,
                      child: Text(
                        'Welcome Back!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          color: Color(0xFF616161),
                          fontFamily: 'Playfair Displa',
                          fontWeight: FontWeight.w700,
                          height: 1.44,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // we return "null" when something is valid
                    validator: (value) {
                      return value.toString().isNotEmpty ? null : "Empty";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailp,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: "Enter Your Email : ",
                      suffixIcon: Icon(Icons.email_outlined),
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
                    onSaved: (val) => _password = val!,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passp,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Enter Your password : ",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _toggle();
                        },
                      ),
                    ),
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (validate() == "done") {
                        bool x;
                        x = await login();

                        if (!mounted) return;
                        if (x) {
                          if (state == "C") {
                            final snackBar = SnackBar(
                              content:
                                  const Text('Succesfully log in as Compony'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            Navigator.pushNamed(context, '/homepage');
                          }
                          if (state == "A") {
                            final snackBar = SnackBar(
                              content:
                                  const Text('Succesfully log in as applicant'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                           
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushNamed(context, '/homepageapplicant');
                          }
                        }
                      } else if (validate() == "emptyE") {
                        QuickAlert.show(
                          context: context,
                          text: "the email is empty",
                          type: QuickAlertType.warning,
                        );
                      }
                      else if (validate() == "emptyP") {
                        QuickAlert.show(
                          context: context,
                          text: "the password is empty",
                          type: QuickAlertType.warning,
                        );
                      }  else if (vv == "wrong") {
                        QuickAlert.show(
                          context: context,
                          text: "Wrong password provided for that user.",
                          type: QuickAlertType.warning,
                        );
                      } else if (vv == "notfound") {
                        QuickAlert.show(
                          context: context,
                          text: "No user found for this email.",
                          type: QuickAlertType.warning,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFD1C4E9)),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.only(left: 23, right: 23),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xFFF5F5F5),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 30,
                    margin: const EdgeInsets.fromLTRB(15, 20, 0, 0),
                    child: Row(
                      children: [
                        const Text(
                          'you dont have an account ? ',
                          style: TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 18,
                            fontFamily: 'Playfair Displa',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(151, 97, 97, 97),
                              fontFamily: 'Playfair Displa',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/userchoice');
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: TextButton(
                      child: const Text(
                        "Forget Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(151, 97, 97, 97),
                          fontFamily: 'Playfair Displa',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
