import 'package:flutter/material.dart';
import 'package:flutter_application_1/Caregiver/bottomnavigation_caregiver.dart';
import 'logincustomer.dart';
import 'logincaregiver.dart';
import 'splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foryou',
      home: SplashPage(),
      theme: ThemeData(
        fontFamily: 'Athiti',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class firstpagelogin extends StatefulWidget {
  const firstpagelogin({super.key});

  @override
  State<firstpagelogin> createState() => firstpageloginState();
}

class firstpageloginState extends State<firstpagelogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 90),
              child: Center(
                  child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo_foryou.jpg',
                    height: 245,
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Text(
                    "ดูแลคนที่เรารัก",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "ฝากเราดูแลคนที่คุณรัก Caregiver form For you ;)",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const logincustomer()),
                        );
                      }, // Handle your callback
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(15)),
                        height: 60,
                        width: 335,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "เริ่มต้นเป็น CUSTOMER",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      )),
                  SizedBox(height: 7),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const logincaregiver()),
                        );
                      }, // Handle your callback
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(15)),
                        height: 60,
                        width: 335,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "เริ่มต้นเป็น CAREGIVER",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      )),
                  SizedBox(height: 7),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const bottomnavigation()),
                        );
                      }, // Handle your callback
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: Colors.grey.shade600),
                            borderRadius: BorderRadius.circular(15)),
                        height: 60,
                        width: 335,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "TEST DEMO CAREGIVER",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                      )),
                ],
              )))),
      backgroundColor: Colors.white,
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
