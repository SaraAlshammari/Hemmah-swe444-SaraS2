import 'package:hemmah/model/cv_model.dart';

class ApplicantModel {
  String? uId;
  String? email;
  String? fullName;
  String? pass;
  String? notificationToken;
  CVModel? cvModel;

  ApplicantModel({
    this.uId,
    this.email,
    this.fullName,
    this.pass,
    this.notificationToken,
    this.cvModel,
  });

  ApplicantModel.fromJson(Map<String, dynamic> json, id) {
    uId = id;
    email = json['Email'];
    fullName = json['fullName'];
    pass = json['password'];
    notificationToken = json['notificationToken'];
    cvModel = json['cvModel'] != null
        ? CVModel.fromJson(json['cvModel'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['Email'] = email;
    data['fullName'] = fullName;
    data['password'] = pass;
    data['notificationToken'] = notificationToken;
    if (cvModel != null) {
      data['cvModel'] = cvModel!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ApplicantModel{uId: $uId, email: $email, fullName: $fullName, pass: $pass, notificationToken: $notificationToken, cvModel: $cvModel}';
  }
}
