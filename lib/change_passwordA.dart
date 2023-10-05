import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hemmah/settingsApplicant.dart';

import 'start.dart';

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

    //Create an instance of the current user.
    var user = FirebaseAuth.instance.currentUser!;
    //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

    final cred = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        success = true;
      }).catchError((error) {
        print(error);
      });
    }).catchError((err) {
      print(err);
    });

    return success;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Changed!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
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

  Future<void> _showErorrDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Password!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  _showErorrDialog();
                }
                return null;
              },
            ),
            const SizedBox(),
            TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.visibility),
                hintText: 'Enter New password',
                labelText: 'New password ',
              ),
              controller: _newpassController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  _showErorrDialog();
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1C4E9),
              ),
              onPressed: () {
                if (_passController.text != "" ||
                    _newpassController.text != "") {
                  _changePassword(
                    _passController.text,
                    _newpassController.text,
                  );
                  _showMyDialog();
                } else {
                  _showErorrDialog();
                }
              }

              //   _showErorrDialog();

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
