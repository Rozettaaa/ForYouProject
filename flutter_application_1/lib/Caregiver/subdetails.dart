import 'package:flutter/material.dart';
import 'bottomnavigation_caregiver.dart';

class ReservationDetails {
  String img;
  String CustomerName;
  String Date;
  String StartTime;
  String EndTime;
  String Status;
  ReservationDetails(this.img, this.CustomerName, this.Date, this.EndTime,
      this.StartTime, this.Status);
}

class manageReservation extends StatefulWidget {
  const manageReservation({super.key});

  @override
  State<manageReservation> createState() => _manageReservationState();
}

class _manageReservationState extends State<manageReservation> {
  final List<ReservationDetails> reservation = [
    ReservationDetails("assets/images/picture1.jpg", "สมหมาย ขายหมี",
        "30/11/2022", "18.00", "12.00", "รอการอนุมัติ"),
    ReservationDetails("assets/images/picture1.jpg", "จง หลีฮวน", "28/11/2022",
        "12.00", "08.00", "รอการอนุมัติ"),
    ReservationDetails("assets/images/picture1.jpg", "หมวย มีมี่", "02/12/2022",
        "15.00", "12.00", "รอการอนุมัติ")
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: reservation.length,
          itemBuilder: (BuildContext context, int index) {
            final ReservationDetails reserve = reservation[index];
            return Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ]),
              child: ListTile(
                contentPadding: const EdgeInsets.all(2.0),
                leading: CircleAvatar(
                    backgroundImage: AssetImage(reserve.img), radius: 25),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reserve.CustomerName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          reserve.Date +
                              "\t\t" +
                              reserve.StartTime +
                              " น. - " +
                              reserve.EndTime +
                              " น.",
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                    Text(reserve.Status,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReserveDetailPage(
                              reserve: reserve,
                            )),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10)),
    );
  }
}

class ReserveDetailPage extends StatelessWidget {
  const ReserveDetailPage({super.key, required this.reserve});
  final ReservationDetails reserve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "รายละเอียดการจอง",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundImage: AssetImage(reserve.img), radius: 30),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          reserve.CustomerName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("วันที่จอง " + reserve.Date)
                      ],
                    )
                  ],
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รายละเอียดการจ้าง",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ประเภทการจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เริ่มงาน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("จบงาน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รายละเอียดผู้จอง",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ชื่อ - นามสกุล"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เบอร์โทร"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("สถานที่เข้ารับการดูแล"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รายละเอียดผู้สูงอายุ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ชื่อ - นามสกุล"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เพศ"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("อายุ"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("น้ำหนัก"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ส่วนสูง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("โรคประจำตัว"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ข้อมูลเพิ่มเติม"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ค่าบริการในการดูแล",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("จำนวนวันทีจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("อัตราค่าจ้างวันละ"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("รวมเป็นเงิน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("สถานะการจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("ยกเลิกการจอง",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)), // Background color
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) => Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange[50],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(25.0),
                                      topRight: const Radius.circular(25.0),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  width: 350,
                                  height: 300.0,
                                  child: Column(
                                    children: [
                                      Text(
                                        'อนุมัติการจองสำเร็จ',
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                          onPressed: (() {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const bottomnavigation()));
                                          }),
                                          child: Text("กลับหน้าแรก",
                                              style: TextStyle(
                                                  color: Colors.yellow[800],
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .underline)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text("อนุมัติการจอง",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow[700], // Background color
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.yellow[700],
    );
  }
}

class ViewHistory extends StatefulWidget {
  const ViewHistory({super.key});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  List<ReservationDetails> reservation = [
    ReservationDetails("assets/images/picture1.jpg", "สมหมาย ขายหมี",
        "30/11/2022", "18.00", "12.00", "รอการอนุมัติ"),
    ReservationDetails("assets/images/picture1.jpg", "จง หลีฮวน", "28/11/2022",
        "12.00", "08.00", "รอการอนุมัติ"),
    ReservationDetails("assets/images/picture1.jpg", "หมวย มีมี่", "02/12/2022",
        "15.00", "12.00", "รอการอนุมัติ")
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: reservation.length,
          itemBuilder: (BuildContext context, int index) {
            final ReservationDetails reserve = reservation[index];
            return Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ]),
              child: ListTile(
                contentPadding: const EdgeInsets.all(2.0),
                leading: CircleAvatar(
                    backgroundImage: AssetImage(reserve.img), radius: 25),
                title: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reserve.CustomerName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          reserve.Date +
                              "\t\t" +
                              reserve.StartTime +
                              " น. - " +
                              reserve.EndTime +
                              " น.",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Icon(Icons.arrow_forward_ios_outlined),
                            Text(
                              "เพิ่มเติม",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ))
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubHistoryPage(
                              reserve: reserve,
                            )),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10)),
    );
  }
}

class SubHistoryPage extends StatelessWidget {
  const SubHistoryPage({super.key, required this.reserve});
  final ReservationDetails reserve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "ประวัติของการจอง",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundImage: AssetImage(reserve.img), radius: 30),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          reserve.CustomerName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("วันที่จอง " + reserve.Date)
                      ],
                    )
                  ],
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รายละเอียดการจ้าง",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ประเภทการจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เริ่มงาน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("จบงาน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รายละเอียดผู้จอง",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ชื่อ - นามสกุล"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เบอร์โทร"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("สถานที่เข้ารับการดูแล"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รายละเอียดผู้สูงอายุ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ชื่อ - นามสกุล"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เพศ"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("อายุ"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("น้ำหนัก"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ส่วนสูง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("โรคประจำตัว"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ข้อมูลเพิ่มเติม"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ค่าบริการในการดูแล",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("จำนวนวันทีจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("อัตราค่าจ้างวันละ"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("รวมเป็นเงิน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("สถานะการจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.yellow[700],
    );
  }
}

class checkPayment extends StatefulWidget {
  const checkPayment({super.key});

  @override
  State<checkPayment> createState() => _checkPaymentState();
}

class _checkPaymentState extends State<checkPayment> {
  final List<ReservationDetails> reservation = [
    ReservationDetails("assets/images/picture1.jpg", "สมหมาย ขายหมี",
        "30/11/2022", "18.00", "12.00", "รอยืนยันการชำระเงิน"),
    ReservationDetails("assets/images/picture1.jpg", "จง หลีฮวน", "28/11/2022",
        "12.00", "08.00", "รอยืนยันการชำระเงิน"),
    ReservationDetails("assets/images/picture1.jpg", "หมวย มีมี่", "02/12/2022",
        "15.00", "12.00", "รอยืนยันการชำระเงิน")
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: reservation.length,
          itemBuilder: (BuildContext context, int index) {
            final ReservationDetails reserve = reservation[index];
            return Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ]),
              child: ListTile(
                contentPadding: const EdgeInsets.all(2.0),
                leading: CircleAvatar(
                    backgroundImage: AssetImage(reserve.img), radius: 25),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reserve.CustomerName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          reserve.Date +
                              "\t\t" +
                              reserve.StartTime +
                              " น. - " +
                              reserve.EndTime +
                              " น.",
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    ),
                    Text(reserve.Status,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => checkPaymentDetail(
                              reserve: reserve,
                            )),
                  );
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10)),
    );
  }
}

class checkPaymentDetail extends StatelessWidget {
  const checkPaymentDetail({super.key, required this.reserve});
  final ReservationDetails reserve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "รายละเอียดการจอง",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        width: 400,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundImage: AssetImage(reserve.img), radius: 30),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        Text(
                          reserve.CustomerName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text("วันที่จอง " + reserve.Date)
                      ],
                    )
                  ],
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "รายละเอียดการจ้าง",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ประเภทการจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("เริ่มงาน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("จบงาน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ค่าบริการในการดูแล",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("จำนวนวันทีจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("อัตราค่าจ้างวันละ"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("รวมเป็นเงิน"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("สถานะการจ้าง"),
                            Text(
                              "data",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(0, 0),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ข้อมูลการชำระเงิน",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Proof of Payment",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(
                          Icons.image,
                          size: 100,
                        )
                      ],
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("ปฏิเสธการชำระเงิน",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10)), // Background color
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) => Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange[50],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: const Radius.circular(25.0),
                                      topRight: const Radius.circular(25.0),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  width: 350,
                                  height: 300.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ยืนยันการชำระเงินสำเร็จ',
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'ยืนยันการชำระเงินสำเร็จ\nระบบจะทำการแจ้งเตือนไปยังลูกค้า',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      TextButton(
                                          onPressed: (() {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const bottomnavigation()));
                                          }),
                                          child: Text("กลับหน้าแรก",
                                              style: TextStyle(
                                                  color: Colors.yellow[800],
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .underline)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text("ยืนยันการชำระเงิน",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow[700], // Background color
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.yellow[700],
    );
  }
}
