class JobModel {
  String? jId;
  String? position;
  String? workplaceType;
  String? jobType;
  String? location;
  String? description;
  String? companyEmail;
  String? companyName;
  bool? isAvailable;
  String? notifyToken;
  DateTime? startTime;
  DateTime? endTime;
  List? applicants;

  JobModel({
    this.jId,
    required this.position,
    required this.workplaceType,
    required this.jobType,
    required this.location,
    required this.description,
    required this.companyEmail,
    required this.companyName,
    required this.isAvailable,
    required this.notifyToken,
    required this.startTime,
    required this.endTime,
    required this.applicants,
  });

  JobModel.fromMap(Map<String, dynamic> map, id) {
    jId = id;
    position = map['position'];
    workplaceType = map['workplaceType'];
    jobType = map['jobType'];
    location = map['location'];
    description = map['description'];
    companyEmail = map['companyEmail'];
    companyName = map['companyName'];
    isAvailable = map['isAvailable'];
    notifyToken = map['notifyToken'];
    startTime =
        map['startTime'] != null ? DateTime.parse(map['startTime']) : null;
    endTime = map['endTime'] != null ? DateTime.parse(map['endTime']) : null;
    applicants = map['applicants'] != null ? List.from(map['applicants']) : [];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['position'] = position;
    map['workplaceType'] = workplaceType;
    map['jobType'] = jobType;
    map['location'] = location;
    map['description'] = description;
    map['companyName'] = companyName;
    map['isAvailable'] = isAvailable;
    map['companyEmail'] = companyEmail;
    map['notifyToken'] = notifyToken;
    map['startTime'] = startTime.toString();
    map['endTime'] = endTime.toString();
    map['applicants'] = applicants;
    return map;
  }

  @override
  String toString() {
    return 'JobModel{position: $position, workplaceType: $workplaceType, jobType: $jobType, location: $location, description: $description, companyEmail: $companyEmail, companyName: $companyName, isAvailable: $isAvailable, notifyToken: $notifyToken, startTime: $startTime, endTime: $endTime, applicants: $applicants}';
  }
}
