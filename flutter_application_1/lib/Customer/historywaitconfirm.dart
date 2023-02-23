import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:time_picker_widget/time_picker_widget.dart';
import '../api.dart';
import 'package:http/http.dart' as http;
import 'bottomnavigation_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logincustomer.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/editable_text.dart';

class historywaitconfirm extends StatefulWidget {
  final String Username;
  const historywaitconfirm({required this.Username});

  @override
  historywaitconfirmState createState() =>
      historywaitconfirmState(Username: Username);
}

class historywaitconfirmState extends State<historywaitconfirm> {
  final String Username;
  historywaitconfirmState({required this.Username});
  Future getreservation() async {
    var url = Uri.parse(ApiUrl.getreservation);

    var response = await http.post(url, body: {"Username": Username});
    try {
      if (response.statusCode == 200) {
        var jsondata =
            jsonDecode(response.body.toString().replaceAll("\n", ""));
        print(jsondata);
        return jsondata;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Text(
              "ประวัติการจองที่รอ Caregiver อนุมัติ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Form(
              child: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 400,
                            child: FutureBuilder(
                                future: getreservation(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.separated(
                                        padding: const EdgeInsets.all(8.0),
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          final List list = snapshot.data;
                                          return Container(
                                            padding: const EdgeInsets.all(15.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                boxShadow: [
                                                  const BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        4), // Shadow position
                                                  ),
                                                ]),
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(10.0),
                                              leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      'http://192.168.1.42/foryou_project/Profilepicture_caregiver/${list[index]['ProfilePicture']}'),
                                                  radius: 32),
                                              title: Text(
                                                list[index]['Firstname'] +
                                                    "\t" +
                                                    list[index]['Lastname'],
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                  "อาชีพ : " +
                                                      list[index]
                                                          ['presentjob'] +
                                                      "\n" +
                                                      "อาชีพ : " +
                                                      list[index]
                                                          ['presentjob'] +
                                                      "\n" +
                                                      "ที่อยู่ : " +
                                                      list[index]['District'] +
                                                      "\t" +
                                                      list[index]['Province'] +
                                                      "\nวันที่เริ่มงาน :\t" +
                                                      list[index]['StratTime'] +
                                                      list[index]['StratTime'] +
                                                      "\n" "รวมเป็นเงิน : " +
                                                      list[index]['Price'] +
                                                      "\nสถานะการจ้าง : รอ Caregiver อนุมัติ",
                                                  style: const TextStyle(
                                                      fontSize: 17)),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPage(
                                                            list: list,
                                                            index: index),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 10));
                                  }
                                  return Container(
                                    child:
                                        Center(child: Text("Hello Container")),
                                  );
                                }),
                          )
                        ],
                      ))))),
      backgroundColor: Colors.white,
    );
  }
}

class DetailPage extends StatelessWidget {
  late final List list;
  late final int index;
  DetailPage({required this.list, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Column(
            children: [
              const Text(
                "Reservation Caregiver",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.amber,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://192.168.1.42/foryou_project/Profilepicture_caregiver/${list[index]['ProfilePicture']}'),
                          radius: 50,
                        ),
                        const SizedBox(height: 5),
                        Container(
                            decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ))
                      ],
                    ),
                    const SizedBox(width: 15),
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      width: 250,
                      height: 125,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            list[index]['Firstname'] +
                                "\t" +
                                list[index]['Lastname'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text("อายุ : " +
                              list[index]['Old'] +
                              "\tปี\t\n" +
                              "ที่อยู่ : " +
                              list[index]['Address'] +
                              "\nเบอร์ : " +
                              list[index]['ContactTel'])
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ประวัตืด้านการทำงาน",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.amber),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "\t\tปัจจุบัน : " + list[index]['presentjob'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 10.0, top: 3, bottom: 0),
                          child: Text(
                            list[index]['Work'],
                            style: const TextStyle(fontSize: 15),
                          )),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "\t\tความสามารถเพิ่มเติม",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 10.0, top: 3, bottom: 0),
                          child: Text(
                            list[index]['moreability'],
                            style: const TextStyle(fontSize: 15),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 20, bottom: 0),
                          child: Text(
                            "เลือกวันในการจอง",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
