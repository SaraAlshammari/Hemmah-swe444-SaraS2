import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hemmah/login.dart';
import 'package:hemmah/userchoice.dart';
import 'package:password_field_validator/password_field_validator.dart';
import 'package:quickalert/quickalert.dart';

TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailc = TextEditingController();
  final cname = TextEditingController();
  final pass = TextEditingController();
  bool isLoading = false;
  String passvalue1 = "";
  String passvalue2 = "";
   bool _obscureText = true;

  bool _obscureText2 = true;
  final passc = TextEditingController();

  @override
  void dispose() {
    emailc.dispose();
    passc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  String validate = "";
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
  @override
  Widget build(BuildContext context) {
    String validate() {
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
      } else if (cname.text == "") {
        return "emptyC";
      } else if (passc.text == "") {
        return "emptyP";
      } else if (pass.text == "") {
        return "emptycc";
      } else if (yy == "weak") {
        return "weak";
      } else if (pass.text != passc.text) {
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
          password: passc.text,
        );
        CollectionReference users =
            FirebaseFirestore.instance.collection('Compony');

        users
            .doc(credential.user!.uid)
            .set(
              {
                'ComponyName': cname.text,
                'Email': emailc.text,
                'password': passc.text,
              },
            )
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        s = "D";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          QuickAlert.show(
            context: context,
            text: "The password provided is too weak.",
            type: QuickAlertType.warning,
          );
        } else if (e.code == 'email-already-in-use') {
          QuickAlert.show(
            context: context,
            text: "The account already exists for that email.",
            type: QuickAlertType.warning,
          );

          s = "exist";
        }
      } catch (e) {
        QuickAlert.show(
                          context: context,
                          text: "Error",
                          type: QuickAlertType.warning,
                        );
        s = "F";
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
            "Sign up as compony",
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
                    controller: cname,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: const InputDecoration(
                      hintText: "Enter the compony name : ",
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
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passc,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _obscureText,
                    decoration:  InputDecoration(
                      hintText: "Enter Your password : ",
                      suffixIcon:IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ), onPressed: () { _toggle(); }, 
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                   PasswordFieldValidator(minLength: 8,
                  uppercaseCharCount: 1,
                  lowercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  defaultColor: Colors.black,
                  successColor: Colors.green,
                  failureColor: Colors.red,
                  controller: passc),
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
                    controller: pass,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: _obscureText2,
                    decoration:  InputDecoration(
                      hintText: "confirm your password : ",
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
                          QuickAlert.show(
                            context: context,
                            text: "Successfully Register",
                            type: QuickAlertType.success,
                          );

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
                          text: "The account already exists for that email.",
                          type: QuickAlertType.warning,
                        );
                      } else if (validate() == "weak" || s == "w") {
                        QuickAlert.show(
                          context: context,
                          text:
                              "provided password is weak , please add lowercase and uppercase letters and special characters and must contains at least eight characters ",
                          type: QuickAlertType.warning,
                        );
                      } else if (validate() == "incorrectEmailF") {
                        QuickAlert.show(
                          context: context,
                          text: "email address format is not correct",
                          type: QuickAlertType.warning,
                        );
                      } else if (validate() == "emptycc") {
                        QuickAlert.show(
                          context: context,
                          text: "some of the field is empty",
                          type: QuickAlertType.warning,
                        );
                      }else if (validate() == "emptyE") {
                        QuickAlert.show(
                          context: context,
                          text: "the email is empty",
                          type: QuickAlertType.warning,
                        );
                      }
                      else if (validate() == "emptyC") {
                        QuickAlert.show(
                          context: context,
                          text: "the compony name is empty",
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
                       else if (validate() == "notMatch") {
                        QuickAlert.show(
                          context: context,
                          text: "Password is not identical",
                          type: QuickAlertType.warning,
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          text: "Erorr",
                          type: QuickAlertType.error,
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
                    margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
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
                              fontFamily: 'Playfair Displa',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
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
