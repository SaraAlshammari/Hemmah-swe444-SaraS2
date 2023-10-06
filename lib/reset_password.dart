import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'auth_exception_handler.dart';
import 'start.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
          (e) => _status = AuthExceptionHandler.handleAuthException(e),
        );

    return _status;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password reset link sent!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(' Check your email please ')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Start(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF3E5F5),
        title: const Text(
          "Forget Password",
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
              MaterialPageRoute(builder: (context) => const Start()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF616161),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 50.0,
            bottom: 25.0,
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 100.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("img/reset.jpeg"),
                    ),
                  ),
                ),
                //    const SizedBox(height: 25),

                const Text(
                  'Please enter your email address to reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 13,
                    fontFamily: 'Playfair Displa',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),

                //   const SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    obscureText: false,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Empty email';
                      }
                      return null;
                    },
                    autofocus: false,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            30.0,
                          ),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            30.0,
                          ),
                        ),
                      ),

                      isDense: true,
                      // fillColor: kPrimaryColor,
                      filled: true,
                      errorStyle: TextStyle(fontSize: 15),
                      hintText: 'email address',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Expanded(child: SizedBox()),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(18), //هنا
                    color: const Color(0xFFD1C4E9),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          final status = await resetPassword(
                            email: _emailController.text.trim(),
                          );
                          if (status == AuthStatus.successful) {
                            QuickAlert.show(
                            context: context,
                            text: "Successfully Send",
                            type: QuickAlertType.success,
                          );
                            //_showMyDialog();
                            //your logic
                          } else {  QuickAlert.show(
                            context: context,
                            text: "Error",
                            type: QuickAlertType.success,
                          );}
                        }
                      },
                      minWidth: double.infinity,
                      child: const Text(
                        'RECOVER PASSWORD',
                        style: TextStyle(
                          color: Color(0xFFF5F5F5),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Playfair Displa',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
