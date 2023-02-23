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

class finishtask extends StatefulWidget {
  const finishtask({super.key});

  @override
  State<finishtask> createState() => finishtaskState();
}

class finishtaskState extends State<finishtask> {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "รายการงานที่ต้องทำ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow[700],
        elevation: 2,
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: reservation.length,
          itemBuilder: (BuildContext context, int index) {
            final ReservationDetails reserve = reservation[index];
            return ListTile(
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
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                  Text("สถานที่ : data"),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkDetailPage(
                            reserve: reserve,
                          )),
                );
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10)),
      backgroundColor: Colors.white,
    );
  }
}

class WorkDetailPage extends StatelessWidget {
  const WorkDetailPage({super.key, required this.reserve});
  final ReservationDetails reserve;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: Column(
            children: [
              const Text(
                "รายละเอียดงาน",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.yellow[700],
        ),
        body: Padding(
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
                      width: 5,
                    ),
                    SizedBox(
                      width: 300,
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
                                        'เสร็จสิ้นการทำงาน',
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Icon(Icons.content_paste_go,
                                          size: 80, color: Colors.grey),
                                      Text(
                                        'รอลูกค้าทำการชำระค่าบริการ',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
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
                        child: Text("จบการทำงาน",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow[700],
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
        backgroundColor: Colors.white);
  }
}
