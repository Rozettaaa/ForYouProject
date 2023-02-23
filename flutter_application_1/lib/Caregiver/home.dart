import 'package:flutter/material.dart';
import 'bottomnavigation_caregiver.dart';
import 'subdetails.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.yellow[700],
          elevation: 0,
          title: Text(
            "Care Center",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              height: 100,
              width: 350,
              child: Row(children: [
                const FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/picture2.jpg"),
                    )),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Caregiver Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    Text("Other Details"),
                  ],
                ),
                SizedBox(width: 80),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    Text("Rating 5")
                  ],
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              width: 380,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(25)),
              child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(25)),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Athiti'),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: 'อนุมัติการจอง'),
                    Tab(text: 'เช็คการชำระเงิน'),
                    Tab(text: 'ประวัติการทำงาน'),
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: TabBarView(children: [
              Center(
                child: manageReservation(),
              ),
              Center(
                child: checkPayment(),
              ),
              Center(
                child: ViewHistory(),
              ),
            ])),
          ],
        ),
        backgroundColor: Colors.yellow[700],
      ),
    );
  }
}
