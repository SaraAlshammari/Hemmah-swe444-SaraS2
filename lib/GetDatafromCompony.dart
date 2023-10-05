import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDatafromCompony extends StatelessWidget {
  final String documentId;

  const GetDatafromCompony({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Compony');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            " ${data['ComponyName']}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'Playfair Displa',
              fontWeight: FontWeight.w500,
              height: 1.88,
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
