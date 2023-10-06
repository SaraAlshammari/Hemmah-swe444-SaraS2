import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hemmah/global/global.dart';
import 'package:hemmah/settingsApplicant.dart';
import 'package:password_field_validator/password_field_validator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'login.dart';

class ChangePasswordA extends StatefulWidget {
  const ChangePasswordA({Key? key}) : super(key: key);

  @override
  State<ChangePasswordA> createState() => _ChangePasswordAState();
}

class _ChangePasswordAState extends State<ChangePasswordA> {
  final _formkey = GlobalKey<FormState>();
  final _newpassController = TextEditingController();
  final _passController = TextEditingController();

  //final currentUser = FirebaseAuth.instance.currentUser!;
  var uid;
  var usersRef;

  @override
  void dispose() {
    _newpassController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<bool> _changePassword(
      String currentPassword,
      String newPassword,
      ) async {
    bool success = false;

    var user = FirebaseAuth.instance.currentUser!;

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(cred).then((value) async {
      if (value.user != null) {
        await Future.wait([
          componyCollection.doc(kCompanyModel?.uId).update({
            'password': newPassword,
          }),
          user.updatePassword(newPassword),
        ]).then((_) {

          success = true;
          _showMyDialog("Pasword cahnge!");

        }).catchError((error) {
          _showMyDialog("Please Enter Your New Password");
        });
      }
    }).catchError((err) {
      _showMyDialog("Empty Or Wrong Passwors!");
    });

    return success;
  }
//سارة حطي دايولق

  Future<void> _showMyDialog(String str) async {
    QuickAlert.show(
                          context: context,
                          text: str,
                          type: QuickAlertType.warning,
                        );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF3E5F5),
        title: const Text(
          "Change  Password ",
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
              MaterialPageRoute(
                builder: (context) => const SettingsApplicant(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF616161),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              height: 170,
              width: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/change.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(),
            TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.visibility),
                hintText: 'Enter old password',
                labelText: 'old password ',
              ),
              controller: _passController,

            ),
            const SizedBox(),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.visibility),
                hintText: 'Enter New password',
                labelText: 'New password ',
              ),
              controller: _newpassController,

            ),
           PasswordFieldValidator(minLength: 6,
                uppercaseCharCount: 1,
                lowercaseCharCount: 1,
                numericCharCount: 1,
                specialCharCount: 1,
                defaultColor: Colors.black,
                successColor: Colors.green,
                failureColor: Colors.red,
                controller: _newpassController),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1C4E9),
              ),
              onPressed: () {
                _changePassword(_passController.text, _newpassController.text);

              }


              ,
              child: const Text(
                "change password",
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Playfair Displa',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}