/*import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     body: Container(
  width: double.infinity,
  height: double.infinity,
  clipBehavior: Clip.antiAlias,
  decoration: ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: Stack(
    children: [
      
        Container(
         margin: EdgeInsets.fromLTRB(35, 400, 0, 0),
          child: SizedBox(
            width: 349,
            child: Text(
              'Welcome to Hemmah',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontFamily: 'El Messiri',
                fontWeight: FontWeight.w700,
                height: 1.44,
              ),
            ),
          ),
        ),
      
      
         Positioned(
          left: 45,
          right: 45,
          top: 516,
          child: SizedBox(
            width: 324,
            child: Text(
              'Hemmah app helps special needs to find jobs easly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'El Messiri',
                fontWeight: FontWeight.w500,
                height: 1.38,
              ),
            ),
          ),
        ),
      
      InkWell(
        
        child: Container(
          margin: EdgeInsets.fromLTRB(120, 600, 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: ShapeDecoration(
            color: Color(0xFF2d365c),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Get started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'El Messiri',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      onTap: () {
         Navigator.pushNamed(context, '/userchoice');
      },),
      
      Positioned(
        left: 26,
        top: 76,
        child: Container(
          width: 300,
          height: 300,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Container(
                margin: EdgeInsets.only(left: 50),
                width: 250,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/HEEMAH.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
)
             
      );
  }
}
*/

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(30, 400, 0, 0),
              child: const SizedBox(
                width: 300,
                child: Text(
                  'Lets start your career with us now!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 28,
                    fontFamily: 'Playfair Displa',
                    fontWeight: FontWeight.w700,
                    height: 1.44,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 420,
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),

                    // margin: EdgeInsets.fromLTRB(120, 600, 0, 0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    width: 250,
                    height: 65,

                    decoration: ShapeDecoration(
                      color: const Color(0xFFD1C4E9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),

                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Get started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF5F5F5),
                            fontSize: 20,
                            fontFamily: 'Playfair Displa',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ],
            ),
            Positioned(
              left: 40,
              top: 160,
              child: SizedBox(
                width: 300,
                height: 250,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(left: 50),
                      width: 300,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("img/HEEMMA.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
