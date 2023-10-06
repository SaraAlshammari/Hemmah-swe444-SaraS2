import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hemmah/login.dart';
import 'package:hemmah/userchoice.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

class SignupAsApplicants extends StatefulWidget {
  const SignupAsApplicants({super.key});

  @override
  State<SignupAsApplicants> createState() => _SignupAsApplicantsState();
}

class _SignupAsApplicantsState extends State<SignupAsApplicants> {
  final emailc = TextEditingController();
  bool isLoading = false;

  final fullname = TextEditingController();
  final passcc = TextEditingController();
  final passc = TextEditingController();
   bool _obscureText = true;

  bool _obscureText2 = true;
  @override
  void dispose() {
    emailc.dispose();
    passc.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
  String encryptPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  return hash.toString();
}
   quicka(String s)async{
   QuickAlert.show(
                          context: context,
                          text:s,
                          type: QuickAlertType.warning,
                        );
  }

  @override
  Widget build(BuildContext context) {
    validate() {
      var yy = passc.text.contains(
        RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
        ),
      )
          ? null
          : "weak";
      var y = emailc.text.contains(
        RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ),
      )
          ? null
          : "Enter a valid email";
      print(y);
      if (emailc.text == "") {
        return "emptyE";
      } else if (y == "Enter a valid email") {
        return "incorrectEmailF";
      } else if (fullname.text == "") {
        return "emptyF";
      } else if (passc.text == "") {
        return "emptyP";
      } else if (passcc.text == "") {
        return "emptyPP";
      } else if (yy == "weak") {
        return "weak";
      } else if (passcc.text != passc.text) {
        return "notMatch";
      } else {
        return "done";
      }
    }

    String s = "F";
    register() async {
      setState(() {
        isLoading = true;
      });
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailc.text,
          password: passc.text ,
        );
        CollectionReference users =
            FirebaseFirestore.instance.collection('Applicants');

        users
            .doc(credential.user!.uid)
            .set(
              {
                'fullName': fullname.text,
                'Email': emailc.text,
                'password': encryptPassword(passc.text) ,
              },
            )
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        s = "D";
      } on FirebaseAuthException catch (e) {
       
        if (e.code == 'weak-password') {
          QuickAlert.show(
                          context: context,
                          text: "the password is weak , A password must contains at least eight characters, including at least one number and includes both lower and uppercase letters and special characters",
                          type: QuickAlertType.warning,
                        );
         
      
          s = "w";
        } else if (e.code == 'email-already-in-use') {
           
                          QuickAlert.show(
                          context: context,
                          text: "The account already exists for that email.",
                          type: QuickAlertType.warning,
                        );
          
          s = "exist";
        }
      } catch (e) {
        print(e);
      }
      setState(() {
        isLoading = false;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFFF3E5F5),
          title: const Text(
            "Sign Up As Applicant",
            style: TextStyle(
              fontFamily: ' Playfair Displa',
              color: Color(0xFF616161),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => const UserChoice()),
              );
            },
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xFF616161),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    // we return "null" when something is valid
                    validator: (value) {
                      return value.toString().isNotEmpty ? null : "Empty";
                    },
                    controller: fullname,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: "Enter your full name : ",
                      suffixIcon: Icon(Icons.person_2_outlined),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // we return "null" when something is valid
                    validator: (email) {
                      return email!.contains(
                        RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        ),
                      )
                          ? null
                          : "Enter a valid email";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailc,
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
                    validator: (passc) {
                      return passc!.contains(
                        RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                        ),
                      )
                          ? null
                          : "Enter a valid password (should contain at least one upper case \n,at least one lower case , at least one digit ,\n at least one Special character , at least 8 characters in length )";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passc,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _obscureText,
                    decoration:  InputDecoration(
                      hintText: "Enter Your password : ",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ), onPressed: () { _toggle(); }, 
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // we return "null" when something is valid
                    validator: (value) {
                      return passc.text.compareTo(value.toString()) == 0
                          ? null
                          : "Password is not identical";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passcc,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _obscureText2,
                    decoration:  InputDecoration(
                      hintText: "Confirm Your password : ",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ), onPressed: () { _toggle2(); }, 
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String x = validate();
                      print(x);
                      if (validate() == "done") {
                        await register();
                        if (!mounted) return;
                        if (s == "D") {
                         
                         final snackBar = SnackBar(
            content: const Text('Successfully Register'),
            action: SnackBarAction(
              label: 'close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          
                           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(
                                isApplicant: false,
                              ),
                            ),
                          );
                        }
                      } else if (s == "exist") {
                        QuickAlert.show(
                          context: context,
                          text: "The account already exists for that email. ",
                          type: QuickAlertType.warning,
                        );
                        
                      } else if (validate() == "weak" || s == "w") {
                        QuickAlert.show(
                          context: context,
                          text: "the password is weak , A password must contains at least eight characters, including at least one number and includes both lower and uppercase letters and special characters ",
                          type: QuickAlertType.warning,
                        );
                        
                      } else if (validate() == "incorrectEmailF") {
                         QuickAlert.show(
                          context: context,
                          text: "email address format is not correct ",
                          type: QuickAlertType.warning,
                        );
                        
                      }else if (validate() == "emptyE") {
                        QuickAlert.show(
                          context: context,
                          text: "the email is empty",
                          type: QuickAlertType.warning,
                        );
                      }
                      else if (validate() == "emptyF") {
                        QuickAlert.show(
                          context: context,
                          text: "the applicant full name is empty",
                          type: QuickAlertType.warning,
                        );
                      }
                        else if (validate() == "emptyP") {
                        QuickAlert.show(
                          context: context,
                          text: "the password is empty",
                          type: QuickAlertType.warning,
                        );
                      }
                       else if (validate() == "emptyPP") {
                        QuickAlert.show(
                          context: context,
                          text: "the confirm password is empty",
                          type: QuickAlertType.warning,
                        );
                      } else if (validate() == "notMatch") {
                       
                        QuickAlert.show(
                          context: context,
                          text: "Password is not identical ",
                          type: QuickAlertType.warning,
                        );
                      } else {
                         QuickAlert.show(
                          context: context,
                          text: "Error ",
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
                            "Register",
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
                    margin: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                    child: Row(
                      children: [
                        const Text(
                          'Already have an account ? ',
                          style: TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 18,
                            fontFamily: 'Playfair Displa',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(151, 97, 97, 97),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Login(
                                  isApplicant: true,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
