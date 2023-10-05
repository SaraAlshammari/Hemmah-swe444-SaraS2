import 'package:flutter/material.dart';

import 'SettingsC.dart';

class aboutus extends StatefulWidget {
  const aboutus({super.key});

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3E5F5),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF616161),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsC()),
            );
          },
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontFamily: ' Playfair Displa',
            color: Color(0xFF616161),
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 400),
            const SizedBox(height: 60),
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.grey.shade200,
                  child: const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("img/HEEMMA.png"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(60),
              ),
              alignment: Alignment.bottomLeft,
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Hemmah is an application that connects employee in the public and private sectors and people with special needs, In order to contribute to their empowerment by participating in the development of the homelands, so that people with special needs can be empowered by developing their abilities and skills  , It is an application that helps people with special needs to find jobs that suit them.   As mentioned above, Hemma's goal is to save time and effort for job seekers with special needs and companies that wish to hire this category.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF616161),
                    fontFamily: 'Playfair Displa',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
