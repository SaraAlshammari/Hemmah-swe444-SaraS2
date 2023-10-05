import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hemmah/global/global.dart';
import 'package:hemmah/utils/utils.dart';

import '../model/job_model.dart';

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

class CustomJobCardForApplicant extends StatelessWidget {
  final JobModel currentJob;

  const CustomJobCardForApplicant({
    super.key,
    /*required this.job,*/
    required this.currentJob,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            Text(
              // job.position,
              currentJob.position ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: 'Playfair Displa',
                fontWeight: FontWeight.w600,
                height: 1.88,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              // job.position,
              currentJob.companyName ?? "",
              style: const TextStyle(
                color: Color(0xFF585858),
                fontSize: 14,
                fontFamily: 'Playfair Displa',
                fontWeight: FontWeight.w600,
                height: 1.88,
              ),
              textAlign: TextAlign.left,
            ),
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
                    currentJob.jobType ?? "",
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
                    currentJob.workplaceType ?? '',
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
              currentJob.location ?? "",
              style: const TextStyle(
                color: Color.fromARGB(255, 62, 6, 245),
                fontSize: 20,
                fontFamily: 'Playfair Displa',
                fontWeight: FontWeight.w500,
                height: 2.14,
              ),
              textAlign: TextAlign.left,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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
                              const SizedBox(height: 6),
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
                                currentJob.description ?? "",
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 135, 108, 139),
                    ),
                    // foregroundColor: MaterialStateProperty.all(
                    //   const Color.fromARGB(255, 135, 108, 139),
                    // ),
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
                    "View Description",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFF5F5F5),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: kApplicantModel?.cvModel == null ||
                          currentJob.applicants!.contains(kApplicantModel?.uId)
                      ? null
                      : () async {
                          log("currentJob.id ${currentJob.jId}");
                          await postCollection.doc(currentJob.jId).update({
                            "applicants": currentJob.applicants!
                              ..add(kApplicantModel?.uId),
                          });
                          Utils.sendNotificationToDriverNow(
                            context: context,
                            deviceRegistrationToken: currentJob.notifyToken,
                            body:
                                "${kApplicantModel?.fullName} applied for your job",
                            title: "You have a new applicant for your job",
                          );
                        },
                  style: ButtonStyle(
                    backgroundColor: kApplicantModel?.cvModel == null ||
                            currentJob.applicants!
                                .contains(kApplicantModel?.uId)
                        ? null
                        : MaterialStateProperty.all(
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
                  child: Text(
                    currentJob.applicants!.contains(kApplicantModel?.uId)
                        ? "Applied"
                        : "Apply",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFF5F5F5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
