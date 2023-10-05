import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hemmah/global/global.dart';
import 'package:hemmah/model/applicant_model.dart';
import 'package:hemmah/model/job_model.dart';

// class Job {
//   final String id;
//   final String position;
//   final String workplaceType;
//   final String jobType;
//   final String location;
//   final String companyId;
//   Job({
//     required this.id,
//     required this.position,
//     required this.workplaceType,
//     required this.jobType,
//     required this.location,
//     required this.companyId,
//
//   });
// }

class CustomJobCard extends StatefulWidget {
  final void Function() onDelete;
  final JobModel jobData;

  const CustomJobCard({
    super.key,
    /*required this.job,*/
    required this.onDelete,
    required this.jobData,
  });

  @override
  State<CustomJobCard> createState() => _CustomJobCardState();
}

class _CustomJobCardState extends State<CustomJobCard> {
  List<ApplicantModel> applicants = [];

  Future<void> getAllApplicantData() async {
    try {
      for (var i = 0; i < widget.jobData.applicants!.length; i++) {
        await applicantsCollection
            .doc(widget.jobData.applicants![i])
            .get()
            .then((value) {
          applicants.add(ApplicantModel.fromJson(value.data()!, value.id));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  delete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this job?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: widget.onDelete,
              // () {
              // onDelete; // Call the onDelete callback with the job parameter
              // Navigator.of(context).pop(); // Close the dialog
              // },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getAllApplicantData();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () async {
      await getAllApplicantData();
      setState(() {});
    });
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dragDismissible: false,
        // dragDismissible: true,
        // dismissible: DismissiblePane(onDismissed: () {
        //   delete(context);
        // }),
        children: [
          SlidableAction(
            onPressed: (context) {
              delete(context);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        elevation: 3,
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    // job.position,
                    widget.jobData.position ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'Playfair Displa',
                      fontWeight: FontWeight.w600,
                      height: 1.88,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 189, 171, 224),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.only(left: 23, right: 23),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () {
                      showBottomSheet(
                        elevation: 6,
                        constraints: const BoxConstraints(
                          maxHeight: 500,
                          minHeight: 200,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        context: context,
                        builder: (_) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 6),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.grey, // Grey line
                                    ),
                                    height: 8,
                                    width: 40,
                                  ),
                                ),
                                const Text(
                                  "Job Description",
                                  style: TextStyle(
                                    color: Color(0xFF585858),
                                    fontSize: 20,
                                    fontFamily: 'Playfair Displa',
                                    fontWeight: FontWeight.w500,
                                    height: 1.88,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.jobData.description ?? "",
                                  style: const TextStyle(
                                    color: Color(0xFF585858),
                                    fontSize: 15,
                                    fontFamily: 'Playfair Displa',
                                    height: 1.88,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("View Details"),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                color: Colors.grey[300], // Grey line
                height: 1,
                width: double.infinity,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.jobData.jobType ?? "",
                      style: const TextStyle(
                        color: Color(0xFF585858),
                        fontSize: 20,
                        fontFamily: 'Playfair Displa',
                        fontWeight: FontWeight.w500,
                        height: 1.88,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.jobData.workplaceType ?? "",
                      style: const TextStyle(
                        color: Color(0xFF585858),
                        fontSize: 20,
                        fontFamily: 'Playfair Displa',
                        fontWeight: FontWeight.w500,
                        height: 1.88,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Text(
                widget.jobData.location ?? "",
                style: const TextStyle(
                  color: Color.fromARGB(255, 62, 6, 245),
                  fontSize: 20,
                  fontFamily: 'Playfair Displa',
                  fontWeight: FontWeight.w500,
                  height: 2.14,
                ),
                textAlign: TextAlign.left,
              ),
              if (applicants.isNotEmpty)
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(
                          applicants[index].fullName ?? "",
                          style: const TextStyle(
                            color: Color(0xFF585858),
                            fontSize: 20,
                            fontFamily: 'Playfair Displa',
                            fontWeight: FontWeight.w500,
                            height: 1.88,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            showBottomSheet(
                              elevation: 6,
                              constraints: const BoxConstraints(
                                maxHeight: 500,
                                minHeight: 200,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              context: context,
                              builder: (_) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 6),
                                        Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.grey, // Grey line
                                            ),
                                            height: 8,
                                            width: 40,
                                          ),
                                        ),
                                        _returnRowCV(
                                          title: "Name",
                                          value:
                                              applicants[index].fullName ?? "",
                                        ),
                                        _returnRowCV(
                                          title: "Email",
                                          value: applicants[index].email ?? "",
                                        ),
                                        _returnRowCV(
                                          title: "Certifications",
                                          value: applicants[index]
                                                  .cvModel
                                                  ?.certifications ??
                                              "",
                                        ),
                                        _returnRowCV(
                                          title: "Education",
                                          value: applicants[index]
                                                  .cvModel
                                                  ?.education ??
                                              "",
                                        ),
                                        _returnRowCV(
                                          title: "Skills",
                                          value: applicants[index]
                                                  .cvModel
                                                  ?.skills ??
                                              "",
                                        ),
                                        _returnRowCV(
                                          title: "Languages",
                                          value: applicants[index]
                                                  .cvModel
                                                  ?.languages ??
                                              "",
                                        ),
                                        _returnRowCV(
                                          title: "Project",
                                          value: applicants[index]
                                                  .cvModel
                                                  ?.project ??
                                              "",
                                        ),
                                        _returnRowCV(
                                          title: "Volunteering Experience",
                                          value: applicants[index]
                                                  .cvModel
                                                  ?.volunteeringExperience ??
                                              "",
                                        ),
                                        _returnRowCV(
                                          title: "Work Experience",
                                          value: applicants[index]
                                                  .cvModel
                                                  ?.workExperience ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 189, 171, 224),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.only(left: 23, right: 23),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          child: const Text(
                            "See CV",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFF5F5F5),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: widget.jobData.applicants!.length,
                  shrinkWrap: true,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _returnRowCV({
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF585858),
              fontSize: 20,
              fontFamily: 'Playfair Displa',
              fontWeight: FontWeight.w500,
              height: 1.88,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF585858),
              fontSize: 15,
              fontFamily: 'Playfair Displa',
              height: 1.88,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
