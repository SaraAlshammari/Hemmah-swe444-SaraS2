import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hemmah/contex_extenssion.dart';
import 'package:hemmah/global/global.dart';
import 'package:hemmah/job_list.dart';
import 'package:hemmah/text_style.dart';

import 'app.colors.dart';
import 'app_text_button.dart';
import 'app_text_field.dart';
import 'drop_down.dart';
import 'fb_firestore.dart';
import 'model/job_model.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({
    Key? key,
    /*this.job*/
  }) : super(key: key);

  // Job? job;

  @override
  State<PostJobScreen> createState() => _PostJobScreenState();
}

class _PostJobScreenState extends State<PostJobScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController dateRangeController = TextEditingController();
  final credintial = FirebaseAuth.instance.currentUser;

  bool loading = false;
  String workplace = 'On-site work';
  String job = 'Full time';
  String location = 'Riyadh';
  String position = 'Manager';
  DateTime startTime = DateTime.now();
  DateTime? endTime;

  var selectedWorkplaceType;
  var selectedJobType;
  var selectedLocation;
  var selectedPosition;

  List workplaceType = [
    {"id": 1, "name": "On site work"},
    {"id": 2, "name": "Part time on-site work"},
    {"id": 3, "name": "Remote work"},
  ];

  List jobType = [
    {"id": 4, "name": "Full time"},
    {"id": 5, "name": "Part time"},
    {"id": 6, "name": "Training"},
  ];

  List locations = [
    {"id": 7, "name": "Riyadh"},
    {"id": 8, "name": "Jeddah"},
    {"id": 9, "name": "Dammam"},
    {"id": 10, "name": "Abha"},
  ];

  List positions = [
    {"id": 11, "name": "Manager"},
    {"id": 12, "name": "Assistant"},
    {"id": 13, "name": "Analyst"},
    {"id": 14, "name": "Engineer"},
    {"id": 15, "name": "Accountant"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF3E5F5),
        title: const Text(
          'Let\'s Post Job',
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
              MaterialPageRoute(builder: (context) => JobList()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF616161),
        ),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(
          start: 15,
          end: 25,
          top: 10,
          bottom: 40,
        ),
        children: [
          CustomDropdownButton(
            hint: 'Position',
            title: 'Position',
            valueTitle: selectedPosition,
            items: positions
                .map(
                  (map) => DropdownMenuItem(
                    value: map['id'],
                    child: Row(
                      children: [
                        Text(
                          map['name'],
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const Spacer(),
                        IgnorePointer(
                          child: Radio(
                            activeColor: AppColors.primary,
                            value: map['id'].toString(),
                            groupValue: position,
                            onChanged: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (Object? value) {
              setState(() {
                selectedPosition = value;
                position = value.toString();
              });
            },
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 28),
            child: CustomDropdownButton(
              hint: 'Workplace Type',
              title: 'Workplace Type',
              valueTitle: selectedWorkplaceType,
              items: workplaceType
                  .map(
                    (map) => DropdownMenuItem(
                      value: map['id'],
                      child: Row(
                        children: [
                          Text(
                            map['name'],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          const Spacer(),
                          IgnorePointer(
                            child: Radio(
                              activeColor: AppColors.primary,
                              value: map['id'].toString(),
                              groupValue: workplace,
                              onChanged: (String? value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (Object? value) {
                setState(() {
                  selectedWorkplaceType = value;
                  workplace = value.toString();
                });
              },
            ),
          ),
          CustomDropdownButton(
            hint: 'Job Type',
            title: 'Job Type',
            valueTitle: selectedJobType,
            items: jobType
                .map(
                  (map) => DropdownMenuItem(
                    value: map['id'],
                    child: Row(
                      children: [
                        Text(
                          map['name'],
                          style: AppTextStyle.inputText,
                        ),
                        const Spacer(),
                        IgnorePointer(
                          child: Radio(
                            activeColor: AppColors.primary,
                            value: map['id'].toString(),
                            groupValue: job,
                            onChanged: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (Object? value) {
              setState(() {
                selectedJobType = value;
                job = value.toString();
              });
            },
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 28),
            child: CustomDropdownButton(
              hint: 'Location',
              title: 'Location',
              valueTitle: selectedLocation,
              items: locations
                  .map(
                    (map) => DropdownMenuItem(
                      value: map['id'],
                      child: Row(
                        children: [
                          Text(
                            map['name'],
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          const Spacer(),
                          IgnorePointer(
                            child: Radio(
                              activeColor: AppColors.primary,
                              value: map['id'].toString(),
                              groupValue: location,
                              onChanged: (String? value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (Object? value) {
                setState(() {
                  selectedLocation = value;
                  location = value.toString();
                });
              },
            ),
          ),
          CustomTextField(
            title: 'Brief Description',
            keyboardType: TextInputType.text,
            controller: _descriptionController,
            minLines: 4,
            maxLines: 6,
            contentPadding: const EdgeInsetsDirectional.symmetric(vertical: 10),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'End Date',
                  style: AppTextStyle.subTitle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () async {
              endTime = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate:
                    DateTime.now().copyWith(year: DateTime.now().year + 1),
                initialDate: DateTime.now(),
              );

              if (endTime != null) {
                dateRangeController.text =
                    '${startTime.day}/${startTime.month}/${startTime.year} - ${endTime?.day}/${endTime?.month}/${endTime?.year}';
              }
            },
            child: TextField(
              enabled: false,
              controller: dateRangeController,
              decoration: InputDecoration(
                hintText: 'Expire After',
                hintStyle: AppTextStyle.hintText,
                filled: true,
                fillColor: AppColors.lightGrey,
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  text: 'Cancel',
                  backgroundColor: Colors.grey,
                  onPressed: () {
                    // Navigate to Home Screen
                    Navigator.pushNamed(context, '/jobs_screen');
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppTextButton(
                  text: 'Post',
                  backgroundColor: const Color(0xFFD1C4E9),
                  onPressed: () async {
                    await _performSave();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _performSave() async {
    if (_checkData()) {
      await _save();
    }
  }

  bool _checkData() {
    if (selectedWorkplaceType != null &&
        selectedJobType != null &&
        selectedPosition != null &&
        selectedLocation != null) {
      return true;
    }
    context.showSnackBar(message: 'Please Enter Required Data', error: true);
    return false;
  }

  Future<void> _save() async {
    String workplaceName = workplaceType.firstWhere(
      (element) => element['id'] == selectedWorkplaceType,
      orElse: () => null,
    )?['name'];

    String jobTypeName = jobType.firstWhere(
      (element) => element['id'] == selectedJobType,
      orElse: () => null,
    )?['name'];

    String locationName = locations.firstWhere(
      (element) => element['id'] == selectedLocation,
      orElse: () => null,
    )?['name'];

    String positionName = positions.firstWhere(
      (element) => element['id'] == selectedPosition,
      orElse: () => null,
    )?['name'];

    workplace = workplaceName;
    job = jobTypeName;
    location = locationName;
    position = positionName;
    await FbFirestoreController().create(post, context);
    // Navigate to All Jobs Screen
  }

  JobModel get post => JobModel(
        position: position,
        workplaceType: workplace,
        jobType: job,
        location: location,
        description: _descriptionController.text,
        companyEmail: credintial!.email.toString(),
        startTime: startTime,
        endTime: endTime,
        companyName: kCompanyModel?.componyName,
        notifyToken: kNotificationToken,
        isAvailable: true,
        applicants: [],
      );
}
