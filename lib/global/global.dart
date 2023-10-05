import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hemmah/model/applicant_model.dart';
import 'package:hemmah/model/company_model.dart';

final applicantsCollection =
    FirebaseFirestore.instance.collection('Applicants');
final componyCollection = FirebaseFirestore.instance.collection('Compony');
final postCollection = FirebaseFirestore.instance.collection('Posts');

const serverNotificationToken =
    "key=AAAAIk28FE8:APA91bFMjFyDXfSiwm4h4LuxBZdUel1AZhX8HBy8UaohO2xkmmEnmZJRwoGnMWlVq5qJf7afJXRtUMfd1yTsP2zTcKUtQ35sZBk8aEbKwCJlYvtJubzTtVTxoDClQ5Z5eoRoCbStAc46";

String? kNotificationToken;

ApplicantModel? kApplicantModel;
CompanyModel? kCompanyModel;

bool kIsApplicant = true;
