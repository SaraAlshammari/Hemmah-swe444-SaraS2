class CVModel {
  String? education;
  String? skills;
  String? certifications;
  String? workExperience;
  String? volunteeringExperience;
  String? project;
  String? languages;
  String? notificationToken;

  CVModel({
    this.education,
    this.skills,
    this.certifications,
    this.workExperience,
    this.volunteeringExperience,
    this.project,
    this.languages,
    this.notificationToken,
  });

  CVModel.fromJson(Map<String, dynamic> json) {
    education = json['Education'];
    skills = json['Skills'];
    certifications = json['certifications'];
    workExperience = json['WorkExperience'];
    volunteeringExperience = json['VolunteeringExperience'];
    project = json['Project'];
    languages = json['Languages'];
    notificationToken = json['notificationToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['Education'] = education;
    data['Skills'] = skills;
    data['certifications'] = certifications;
    data['WorkExperience'] = workExperience;
    data['VolunteeringExperience'] = volunteeringExperience;
    data['Project'] = project;
    data['Languages'] = languages;
    data['notificationToken'] = notificationToken;
    return data;
  }

  @override
  String toString() {
    return 'CVModel{Education: $education, Skills: $skills, certifications: $certifications, WorkExperience: $workExperience, VolunteeringExperience: $volunteeringExperience, Project: $project, Languages: $languages, notificationToken: $notificationToken}';
  }
}
