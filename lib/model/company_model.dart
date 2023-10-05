class CompanyModel {
  String? uId;
  String? email;
  String? componyName;
  String? pass;
  String? notificationToken;

  CompanyModel({
    this.uId,
    this.email,
    this.componyName,
    this.pass,
    this.notificationToken,
  });

  CompanyModel.fromJson(Map<String, dynamic> json, id) {
    uId = id;
    email = json['Email'];
    componyName = json['ComponyName'];
    pass = json['password'];
    notificationToken = json['notificationToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Email'] = email;
    data['fullName'] = componyName;
    data['password'] = pass;
    data['notificationToken'] = notificationToken;
    return data;
  }

  @override
  String toString() {
    return 'ApplicantModel{email: $email, ComponyName: $componyName, pass: $pass, notificationToken: $notificationToken}';
  }
}
