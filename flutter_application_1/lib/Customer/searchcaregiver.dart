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

class searchcaregiver extends StatefulWidget {
  final String Username;
  const searchcaregiver({required this.Username});

  @override
  searchcaregiverState createState() =>
      searchcaregiverState(Username: Username);
}

class searchcaregiverState extends State<searchcaregiver> {
  final String Username;
  searchcaregiverState({required this.Username});
  String? selectedvalue;
  List citylist = [];
  Future getallcity() async {
    var url = Uri.parse(ApiUrl.selectcity);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body.toString().replaceAll("\n", ""));
      setState(() {
        citylist = jsondata;
      });
      print(citylist);
    }
  }

  Future getpostbycity() async {
    var url = Uri.parse(ApiUrl.selectcityby);

    var response = await http.post(url, body: {"Address": selectedvalue});

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body.toString().replaceAll("\n", ""));
      return jsondata;
    }
  }

  Future getpostalldata() async {
    var url = Uri.parse(ApiUrl.selectall);

    var response = await http.post(url);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body.toString().replaceAll("\n", ""));
      return jsondata;
    }
  }

  @override
  void initState() {
    super.initState();
    getallcity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Text(
              "CARE TO",
              style: TextStyle(
                  color: Colors.yellow[700], fontWeight: FontWeight.bold),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 4, bottom: 0),
                child: DropdownButton(
                  hint: Text("กรุณาเลือกเขตและจังหวัดที่ต้องการ"),
                  value: selectedvalue,
                  items: citylist.map((caregiver) {
                    return DropdownMenuItem(
                        value: caregiver['Address'],
                        child: Text(caregiver['Address']));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedvalue = value.toString();
                    });
                  },
                ))
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
                          selectedvalue != null
                              ? Container(
                                  height: 400,
                                  child: FutureBuilder(
                                      future: getpostbycity(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.separated(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, index) {
                                                final List list = snapshot.data;
                                                return Container(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
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
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    leading: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                'http://192.168.1.42/foryou_project/Profilepicture_caregiver/${list[index]['ProfilePicture']}'),
                                                        radius: 32),
                                                    title: Text(
                                                      list[index]['Firstname'] +
                                                          "\t" +
                                                          list[index]
                                                              ['Lastname'],
                                                      style: const TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(
                                                        "อายุ : " +
                                                            list[index]['Old'] +
                                                            "\tปี\t\n" +
                                                            "อาชีพ : " +
                                                            list[index]
                                                                ['presentjob'] +
                                                            "\n" +
                                                            "ที่อยู่ : " +
                                                            list[index]
                                                                ['Address'] +
                                                            "\nอัตราค่าบริการ :\t" +
                                                            list[index]
                                                                ['RatePrice'] +
                                                            "\tบาท/ชั่วโมง",
                                                        style: const TextStyle(
                                                            fontSize: 17)),
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailPage(
                                                                  list: list,
                                                                  index: index,
                                                                  Username:
                                                                      Username),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (context,
                                                      index) =>
                                                  const SizedBox(height: 10));
                                        }
                                        return Text('No data found');
                                      }),
                                )
                              : Padding(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 400,
                                        child: FutureBuilder(
                                            future: getpostalldata(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.separated(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    itemCount:
                                                        snapshot.data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final List list =
                                                          snapshot.data;
                                                      return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                            boxShadow: [
                                                              const BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                blurRadius: 4,
                                                                offset: Offset(
                                                                    0,
                                                                    4), // Shadow position
                                                              ),
                                                            ]),
                                                        child: ListTile(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          leading: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'http://192.168.1.42/foryou_project/Profilepicture_caregiver/${list[index]['ProfilePicture']}'),
                                                              radius: 32),
                                                          title: Text(
                                                            list[index][
                                                                    'Firstname'] +
                                                                "\t" +
                                                                list[index][
                                                                    'Lastname'],
                                                            style: const TextStyle(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          subtitle: Text(
                                                              "อายุ : " +
                                                                  list[index]
                                                                      ['Old'] +
                                                                  "\tปี\t\n" +
                                                                  "อาชีพ : " +
                                                                  list[index][
                                                                      'presentjob'] +
                                                                  "\n" +
                                                                  "ที่อยู่ : " +
                                                                  list[index][
                                                                      'Address'] +
                                                                  "\nอัตราค่าบริการ :\t" +
                                                                  list[index][
                                                                      'RatePrice'] +
                                                                  "\tบาท/ชั่วโมง",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          17)),
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DetailPage(
                                                                        list:
                                                                            list,
                                                                        index:
                                                                            index,
                                                                        Username:
                                                                            Username),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const SizedBox(
                                                                height: 10));
                                              }
                                              return Text('');
                                            }),
                                      )
                                    ],
                                  ))
                        ],
                      ))))),
      backgroundColor: Colors.white,
    );
  }
}

class DetailPage extends StatelessWidget {
  late final List list;
  late final int index;
  final String Username;
  DetailPage({required this.list, required this.index, required this.Username});
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
                      Reservedatetime(
                          list: list, index: index, Username: Username)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class Reservedatetime extends StatefulWidget {
  late final List list;
  late final int index;
  final String Username;
  Reservedatetime(
      {required this.list, required this.index, required this.Username});

  @override
  _ReservedatetimeState createState() =>
      _ReservedatetimeState(list: list, index: index, Username: Username);
}

class _ReservedatetimeState extends State<Reservedatetime> {
  late final List list;
  late final int index;
  final String Username;
  _ReservedatetimeState(
      {required this.list, required this.index, required this.Username});

  TimeOfDay dateTime = TimeOfDay.now();
  TimeOfDay dateTime1 = TimeOfDay.now();
  DateTime date = DateTime.now();
  TextEditingController timeinput = TextEditingController();
  TextEditingController timeinput1 = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    timeinput.text = "";
    timeinput1.text = ""; //set the initial value of text field
    super.initState();
  }

  showMessage(BuildContext context, String message) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
              ),
              Icon(
                Icons.warning,
                color: Colors.amber,
                size: 56,
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF231F20),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(color: Color(0xFFE8ECF3)))),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Color(0xFF2058CA),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          SizedBox(width: 22),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.yellow[700]),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(primary: Colors.amber),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.now().subtract(Duration(days: 0)),
                  lastDate: DateTime(2100),
                );
                if (newDate == null) return;
                setState(() => date = newDate);
              },
              child: Text("กดเพื่อเลือกวัน",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold))),
          SizedBox(width: 15),
          Text(
            'วันที่เลือก : ${date.day}/${date.month}/${date.year}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
        Container(
            child: Padding(
          padding:
              const EdgeInsets.only(left: 5.0, right: 10.0, top: 10, bottom: 0),
          child: Text(
              "เลือกเวลาที่ต้องการจอง (อัตราค่าจ้าง : " +
                  list[index]['RatePrice'] +
                  "\tบาท/ชั่วโมง)",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        )),
        Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 4, bottom: 0),
            child: TextField(
              controller: timeinput, //editing controller of this TextField
              decoration: InputDecoration(
                icon: Icon(Icons.timer,
                    color: Colors.grey.shade500), //icon of text field
                labelText: 'เลือกเวลาเริ่มต้น',
                labelStyle:
                    TextStyle(fontSize: 25.0, color: Colors.grey.shade700),
                floatingLabelStyle:
                    TextStyle(fontSize: 25.0, color: Colors.grey.shade700),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'กรุณากดเลือกเวลาเริ่มต้น',

                hintStyle:
                    TextStyle(fontSize: 17.0, color: Colors.grey.shade500),
                focusedBorder: UnderlineInputBorder(
                  //<-- SEE HERE
                  borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2), //label text of field
                ),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showCustomTimePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(primary: Colors.amber),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    // It is a must if you provide selectableTimePredicate
                    onFailValidation: (context) =>
                        showMessage(context, 'กรุณาเลือกเวลาใหม่อีกครั้ง'),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    selectableTimePredicate: (time) =>
                        time!.hour > 7 &&
                        time.hour < 22 &&
                        time.minute % 60 == 0);

                if (pickedTime != null) {
                  print(pickedTime.format(context)); //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  print(parsedTime); //output 1970-01-01 22:53:00.000
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    timeinput.text = formattedTime;
                    dateTime1 = pickedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            )),
        Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 4, bottom: 0),
            child: TextField(
              controller: timeinput1, //editing controller of this TextField
              decoration: InputDecoration(
                icon: Icon(Icons.timer,
                    color: Colors.grey.shade500), //icon of text field
                labelText: 'เลือกเวลาสิ้นสุด',
                labelStyle:
                    TextStyle(fontSize: 25.0, color: Colors.grey.shade700),
                floatingLabelStyle:
                    TextStyle(fontSize: 25.0, color: Colors.grey.shade700),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: 'กรุณากดเลือกเวลาสิ้นสุด',

                hintStyle:
                    TextStyle(fontSize: 17.0, color: Colors.grey.shade500),
                focusedBorder: UnderlineInputBorder(
                  //<-- SEE HERE
                  borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 2), //label text of field
                ),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showCustomTimePicker(
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(primary: Colors.amber),
                        ),
                        child: child!,
                      );
                    },
                    context: context,
                    // It is a must if you provide selectableTimePredicate
                    onFailValidation: (context) =>
                        showMessage(context, 'กรุณาเลือกเวลาใหม่อีกครั้ง'),
                    initialTime: TimeOfDay(hour: 8, minute: 0),
                    selectableTimePredicate: (time) =>
                        time!.hour > 7 &&
                        time.hour < 22 &&
                        time.minute % 60 == 0);

                if (pickedTime != null) {
                  print(pickedTime.format(context)); //output 10:51 PM
                  DateTime parsedTime = DateFormat.jm()
                      .parse(pickedTime.format(context).toString());
                  //converting to DateTime so that we can further format on different pattern.
                  print(parsedTime); //output 1970-01-01 22:53:00.000
                  String formattedTime = DateFormat('HH:mm').format(parsedTime);
                  print(formattedTime); //output 14:59:00
                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                  setState(() {
                    timeinput1.text = formattedTime;
                    dateTime = pickedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            )),
        SizedBox(height: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 10, bottom: 10),
                child: Row(children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber),
                        onPressed: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => reserveDetails(
                                    date: date,
                                    timeinput: timeinput.text,
                                    timeinput1: timeinput1.text,
                                    dateTime: dateTime,
                                    dateTime1: dateTime1,
                                    list: list,
                                    index: index,
                                    Username: Username)),
                          );
                        }),
                        child: Text("ถัดไป",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  )
                ]))
          ],
        )
      ],
    );
  }
}

class reserveDetails extends StatelessWidget {
  reserveDetails(
      {super.key,
      required this.date,
      required this.timeinput,
      required this.timeinput1,
      required this.list,
      required this.index,
      required this.Username,
      required this.dateTime,
      required this.dateTime1});
  DateTime date;
  String timeinput;
  String timeinput1;
  TimeOfDay dateTime;
  TimeOfDay dateTime1;
  late final List list;
  late final int index;
  final String Username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "รายละเอียดการจอง",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow[700],
      ),
      body: SingleChildScrollView(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200, width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 300,
                child: Column(children: [
                  Text(
                    "รายละเอียดวันเวลาที่จอง",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "วันที่ทำการจอง : ${date.day}/${date.month}/${date.year}",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "เวลา  ${timeinput} น. ถึง ${timeinput1} น.",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 15),
              reserveForm(
                date: date,
                timeinput: timeinput,
                timeinput1: timeinput1,
                dateTime: dateTime,
                dateTime1: dateTime1,
                list: list,
                index: index,
                Username: Username,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.yellow[700],
    );
  }
}

class reserveForm extends StatefulWidget {
  reserveForm(
      {super.key,
      required this.date,
      required this.timeinput,
      required this.timeinput1,
      required this.list,
      required this.index,
      required this.Username,
      required this.dateTime,
      required this.dateTime1});
  DateTime date;
  String timeinput;
  String timeinput1;
  TimeOfDay dateTime;
  TimeOfDay dateTime1;
  late final List list;
  late final int index;
  final String Username;

  @override
  State<reserveForm> createState() => _reserveFormState(
      date: date,
      timeinput: timeinput,
      timeinput1: timeinput1,
      dateTime: dateTime,
      dateTime1: dateTime1,
      list: list,
      index: index,
      Username: Username);
}

class _reserveFormState extends State<reserveForm> {
  _reserveFormState(
      {required this.date,
      required this.timeinput,
      required this.timeinput1,
      required this.list,
      required this.index,
      required this.Username,
      required this.dateTime,
      required this.dateTime1});
  DateTime date;
  String timeinput;
  String timeinput1;
  late final List list;
  late final int index;
  final String Username;
  TimeOfDay dateTime;
  TimeOfDay dateTime1;
  TextEditingController firstname_elder = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController lastname_elder = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController More = TextEditingController();
  TextEditingController disease = TextEditingController();
  Future getdatacustomer() async {
    var url = Uri.parse(ApiUrl.selectdatacustomer);

    var response = await http.post(url, body: {"Username": Username});

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body.toString().replaceAll("\n", ""));
      return jsondata;
    }
  }

  String dropdownValue = 'Mr.';
  String dropdowngender = 'M';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 400,
          child: Column(
            children: [
              Text(
                "รายละเอียดผู้จอง",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              FutureBuilder(
                  future: getdatacustomer(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index1) {
                              List list2 = snapshot.data;
                              return ListTile(
                                subtitle: Text(
                                  "ชื่อ-นามสกุล : " +
                                      list2[index1]['Firstname'] +
                                      "\t" +
                                      list2[index1]['Lastname'] +
                                      "\n" +
                                      "เบอร์ : " +
                                      "\t" +
                                      list2[index1]['ContactTel'],
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              );
                            })
                        : CircularProgressIndicator();
                  })
            ],
          ),
        ),
        SizedBox(height: 15),
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200, width: 3),
              borderRadius: BorderRadius.circular(15),
            ),
            width: 400,
            child: Column(
              children: [
                Text(
                  "รายละเอียดผู้สูงอายุ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 4.0, right: 4.0, top: 4, bottom: 0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'คำนำหน้า',
                        labelStyle: TextStyle(
                            fontSize: 20.0, color: Colors.grey.shade700),
                        focusedBorder: UnderlineInputBorder(
                          //<-- SEE HERE
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                        ),
                      ),
                      value: dropdownValue,
                      items: [
                        DropdownMenuItem(child: Text("นาย"), value: "Mr."),
                        DropdownMenuItem(
                          child: Text("นางสาว"),
                          value: "Ms.",
                        ),
                        DropdownMenuItem(
                          child: Text("นาง"),
                          value: "Mrs.",
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value.toString();
                        });
                      },
                    )),
                SizedBox(height: 10),
                TextFormField(
                    controller: firstname_elder,
                    decoration: InputDecoration(
                      labelText: 'ชื่อ',
                      labelStyle: TextStyle(
                          fontSize: 20.0, color: Colors.grey.shade700),
                      floatingLabelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.amber),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'กรุณากรอกชื่อเป็นภาษาไทย',
                      hintStyle: TextStyle(
                          fontSize: 15.0, color: Colors.grey.shade500),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.amber, width: 2.0),
                      ),
                    ),
                    cursorColor: Colors.amber,
                    validator: RequiredValidator(errorText: '* Required')),
                SizedBox(height: 10),
                TextFormField(
                    controller: lastname_elder,
                    decoration: InputDecoration(
                      labelText: 'นามสกุล',
                      labelStyle: TextStyle(
                          fontSize: 20.0, color: Colors.grey.shade700),
                      floatingLabelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.amber),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'กรุณากรอกนามสกุลเป็นภาษาไทย',
                      hintStyle: TextStyle(
                          fontSize: 15.0, color: Colors.grey.shade500),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.amber, width: 2.0),
                      ),
                    ),
                    cursorColor: Colors.amber,
                    validator: RequiredValidator(errorText: '* Required')),
                SizedBox(height: 10),
                TextFormField(
                  controller: Age,
                  decoration: InputDecoration(
                    labelText: 'อายุ',
                    labelStyle:
                        TextStyle(fontSize: 20.0, color: Colors.grey.shade700),
                    floatingLabelStyle:
                        TextStyle(fontSize: 20.0, color: Colors.amber),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'กรุณากรอกอายุ',
                    hintStyle:
                        TextStyle(fontSize: 15.0, color: Colors.grey.shade500),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.amber, width: 2.0),
                    ),
                  ),
                  cursorColor: Colors.amber,
                  validator: PatternValidator(r'^([0-9])+$',
                      errorText: 'Only numberic'),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 2.0, right: 2.0, top: 10, bottom: 0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'เพศ',
                        labelStyle: TextStyle(
                            fontSize: 20.0, color: Colors.grey.shade700),
                        focusedBorder: UnderlineInputBorder(
                          //<-- SEE HERE
                          borderSide:
                              BorderSide(color: Colors.grey.shade400, width: 2),
                        ),
                      ),
                      value: dropdowngender,
                      items: [
                        DropdownMenuItem(child: Text("ชาย"), value: "M"),
                        DropdownMenuItem(
                          child: Text("หญิง"),
                          value: "F",
                        ),
                        DropdownMenuItem(
                          child: Text("อื่น ๆ"),
                          value: "O",
                        )
                      ],
                      onChanged: (newgender) {
                        setState(() {
                          dropdowngender = newgender.toString();
                        });
                      },
                    )),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: weight,
                      decoration: InputDecoration(
                        labelText: 'น้ำหนัก',
                        labelStyle: TextStyle(
                            fontSize: 20.0, color: Colors.grey.shade700),
                        floatingLabelStyle:
                            TextStyle(fontSize: 20.0, color: Colors.amber),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'กรุณากรอกน้ำหนัก',
                        hintStyle: TextStyle(
                            fontSize: 15.0, color: Colors.grey.shade500),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2.0),
                        ),
                      ),
                      cursorColor: Colors.amber,
                      validator: PatternValidator(r'^([0-9])+$',
                          errorText: 'Only numberic'),
                    )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: height,
                      decoration: InputDecoration(
                        labelText: 'ส่วนสูง',
                        labelStyle: TextStyle(
                            fontSize: 20.0, color: Colors.grey.shade700),
                        floatingLabelStyle:
                            TextStyle(fontSize: 20.0, color: Colors.amber),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: 'กรุณากรอกส่วนสูง',
                        hintStyle: TextStyle(
                            fontSize: 15.0, color: Colors.grey.shade500),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.amber, width: 2.0),
                        ),
                      ),
                      cursorColor: Colors.amber,
                      validator: PatternValidator(r'^([0-9])+$',
                          errorText: 'Only numberic'),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: disease,
                    decoration: InputDecoration(
                      labelText: 'โรคประจำตัว',
                      labelStyle: TextStyle(
                          fontSize: 20.0, color: Colors.grey.shade700),
                      floatingLabelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.amber),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'กรุณากรอกโรคประจำตัว',
                      hintStyle: TextStyle(
                          fontSize: 15.0, color: Colors.grey.shade500),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.amber, width: 2.0),
                      ),
                    ),
                    cursorColor: Colors.amber,
                    validator: RequiredValidator(errorText: '* Required')),
                TextFormField(
                    controller: More,
                    decoration: InputDecoration(
                      labelText: 'เน้นดูแลเพิ่มเติม',
                      labelStyle: TextStyle(
                          fontSize: 20.0, color: Colors.grey.shade700),
                      floatingLabelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.amber),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'กรุณารายละเอียดเพิ่มเติม',
                      hintStyle: TextStyle(
                          fontSize: 15.0, color: Colors.grey.shade500),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.amber, width: 2.0),
                      ),
                    ),
                    cursorColor: Colors.amber,
                    validator: RequiredValidator(errorText: '* Required')),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: Address,
                    decoration: InputDecoration(
                      labelText: 'ที่อยู่ในการเข้ารับการดูแล',
                      labelStyle: TextStyle(
                          fontSize: 20.0, color: Colors.grey.shade700),
                      floatingLabelStyle:
                          TextStyle(fontSize: 20.0, color: Colors.amber),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'กรุณากรอกที่อยู่',
                      hintStyle: TextStyle(
                          fontSize: 15.0, color: Colors.grey.shade500),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.amber, width: 2.0),
                      ),
                    ),
                    cursorColor: Colors.amber,
                    validator: RequiredValidator(errorText: '* Required')),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 10, bottom: 0),
            child: Row(children: <Widget>[
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700]),
                      onPressed: (() {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => confirmDetails(
                                      date: date,
                                      timeinput: timeinput,
                                      timeinput1: timeinput1,
                                      dateTime: dateTime,
                                      dateTime1: dateTime1,
                                      list: list,
                                      index: index,
                                      Username: Username,
                                      dropdownValue: dropdownValue,
                                      firstname_elder: firstname_elder.text,
                                      lastname_elder: lastname_elder.text,
                                      Age: Age.text,
                                      dropdowngender: dropdowngender,
                                      height: height.text,
                                      disease: disease.text,
                                      More: More.text,
                                      Address: Address.text,
                                      weight: weight.text,
                                    )),
                          );
                        }
                      }),
                      child: Text("ถัดไป",
                          style: TextStyle(fontWeight: FontWeight.bold))))
            ])),
      ],
    );
  }
}

class confirmDetails extends StatelessWidget {
  confirmDetails(
      {super.key,
      required this.date,
      required this.timeinput,
      required this.timeinput1,
      required this.list,
      required this.index,
      required this.Username,
      required this.dropdownValue,
      required this.dropdowngender,
      required this.firstname_elder,
      required this.lastname_elder,
      required this.Age,
      required this.height,
      required this.weight,
      required this.disease,
      required this.More,
      required this.Address,
      required this.dateTime,
      required this.dateTime1});
  DateTime date;
  String timeinput;
  String timeinput1;
  TimeOfDay dateTime;
  TimeOfDay dateTime1;
  final List list;
  final int index;
  final String Username;
  final String dropdowngender;
  final String dropdownValue;
  final String firstname_elder;
  final String lastname_elder;
  final String Age;
  final String height;
  final String weight;
  final String disease;
  final String More;
  final String Address;

  Future getdatacustomer() async {
    var url = Uri.parse(ApiUrl.selectdatacustomer);

    var response = await http.post(url, body: {"Username": Username});

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body.toString().replaceAll("\n", ""));
      return jsondata;
    }
  }

  String calTotalTime(TimeOfDay startTime, TimeOfDay endTime) {
    double totalTime = (endTime.hour + (endTime.minute / 60)) -
        (startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    int minuts = ((totalTime - totalTime.floorToDouble()) * 60).round();
    return (hours == 0)
        ? '${minuts}min'
        : (minuts == 0)
            ? '${hours}hr'
            : '${hours}hr ${minuts}min';
  }

  Time(TimeOfDay startTime, TimeOfDay endTime) {
    double totalTime = (endTime.hour + (endTime.minute / 60)) -
        (startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    return (hours);
  }

  getgender(String dropdowngender) {
    if (dropdowngender == 'M') {
      return ('ชาย');
    } else if (dropdowngender == 'F') {
      return ('หญืง');
    } else if (dropdowngender == 'O') {
      return ('อื่นๆ');
    }
  }

  void successDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "ลงทะเบียนสำเร็จ",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          bottomnavigation_customer(Username: Username)),
                );
              },
            )
          ],
        );
      },
    );
  }

  void _insertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "คุณต้องการลงทะเบียนใช่หรือไม่",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                sendData();
                successDialog(context);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> sendData() async {
    var url = Uri.parse(ApiUrl.reservation);
    var request = http.MultipartRequest("POST", url);

    request.fields['Title'] = dropdownValue;
    request.fields['Firstname'] = firstname_elder;
    request.fields['Lastname'] = lastname_elder;
    request.fields['CaregiverID'] = list[index]['CaregiverID'];

    request.fields['Gender'] = dropdowngender;
    request.fields['Old'] = Age;
    request.fields['Address'] = Address;
    request.fields['Price'] =
        Price(int.parse(list[index]['RatePrice']), dateTime1, dateTime)
            .toString();
    request.fields['Date'] = date.toString();
    request.fields['StartTime'] = dateTime1.toString();
    request.fields['EndTime'] = dateTime.toString();
    request.fields['Username'] = Username;
    request.fields['Disease'] = disease;
    request.fields['MoreDetail'] = More;
    request.fields['height'] = height;
    request.fields['weight'] = weight;

    var response = await request.send();
    if (response.statusCode == 200) {
      print("uploaded successfully");
    } else {
      print("uploaded failed");
    }
  }

  int Price(int Rateprice, TimeOfDay startTime, TimeOfDay endTime) {
    int hour = Time(startTime, endTime);
    int price = Rateprice * hour;
    return (price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "รายละเอียดการจอง",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.yellow[700],
      ),
      body: SingleChildScrollView(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200, width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 300,
                child: Column(children: [
                  Text(
                    "รายละเอียดวันเวลาที่จอง",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "วันที่ทำการจอง : ${date.day}/${date.month}/${date.year}",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "เวลา  ${timeinput} น. ถึง ${timeinput1} น.",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200, width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 400,
                child: Column(
                  children: [
                    Text(
                      "รายละเอียดผู้จอง",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    FutureBuilder(
                        future: getdatacustomer(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index1) {
                                    List list2 = snapshot.data;
                                    return ListTile(
                                      subtitle: Text(
                                        "ชื่อ-นามสกุล : " +
                                            list2[index1]['Firstname'] +
                                            "\t" +
                                            list2[index1]['Lastname'] +
                                            "\n" +
                                            "เบอร์ : " +
                                            "\t" +
                                            list2[index1]['ContactTel'],
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                    );
                                  })
                              : CircularProgressIndicator();
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200, width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 400,
                child: Column(children: [
                  Text(
                    "รายละเอียดผู้สูงอายุ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 3.0, right: 100.0, top: 4, bottom: 0),
                    child: Container(
                      child: Text(
                        "ชื่อ-นามสกุล : ${firstname_elder}\t${lastname_elder}\n" +
                            "เพศ : " +
                            getgender(dropdowngender) +
                            "\n"
                                "อายุ : ${Age}\n" +
                            "น้ำหนัก : ${weight}\n" +
                            "ส่วนสูง : ${height}\n" +
                            "โรคประจำตัว : ${disease}\n" +
                            "เน้นดูเเลเพิ่มเติม : ${More}\n" +
                            "ที่อยู่ในการเข้ารับการดูแล : ${Address}\n",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200, width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 400,
                child: Column(children: [
                  Text(
                    "ค่าใช้จ่ายในการดูแล",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 3.0, right: 100.0, top: 4, bottom: 0),
                    child: Container(
                      child: Text(
                        "จำนวนชั่วโมงที่จอง : " +
                            calTotalTime(dateTime1, dateTime) +
                            "\n"
                                "อัตราค่าจ้างชั่วโมงละ :" +
                            list[index]['RatePrice'] +
                            "\n"
                                "รวมเป็นเงิน : " +
                            Price(int.parse(list[index]['RatePrice']),
                                    dateTime1, dateTime)
                                .toString() +
                            "\n"
                                "สถานะการจ้าง : รอ Caregiver อนุมัติ\n",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 10, bottom: 0),
                  child: Row(children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow[700]),
                            onPressed: (() {
                              _insertDialog(context);
                            }),
                            child: Text("ยืนยันการจอง",
                                style: TextStyle(fontWeight: FontWeight.bold))))
                  ])),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.yellow[700],
    );
  }
}
