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


class history extends StatefulWidget {
  final String Username;
    const history({required this.Username});
  
      @override
  historyState createState() =>historyState(Username: Username);
}
  



class historyState extends State<history> {
  final String Username;
    historyState ({required this.Username});

  Future getreservation() async{
    var url = Uri.parse(ApiUrl.getreservation);
    
    var response = await http.post(url);
    try{
    if (response.statusCode == 200) {
      var jsondata= jsonDecode(response.body.toString().replaceAll("\n",""));
      return jsondata;
    }
    }
    catch(e){print(e);}
  }
  
    
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children:<Widget>[
              Text(
                "ประวัติการจองที่รออนุมัติ",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
             
            ],
          ),       backgroundColor: Colors.white,
          elevation: 0,
         ), body: SingleChildScrollView(
        child : Form(  
             
        child: SafeArea(
        child : Padding(
       padding: EdgeInsets.symmetric(vertical: 7),
       child: 
            Column(
            children: <Widget>[
            Container(
              height : 400,
              child: FutureBuilder(
                future : getreservation(),
                builder: (context, snapshot){
                  if(snapshot.hasData)
                  {
                    
                    return ListView.separated(
            padding: const EdgeInsets.all(8.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                       final List list =snapshot.data;
                        return Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(0, 4), // Shadow position
                      ),
                    ]),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage('http://192.168.1.105/foryou_project/Profilepicture_caregiver/${list[index]['ProfilePicture']}'), radius: 32),
                  title: Text(
                    list[index]['Firstname']+"\t"+list[index]['Lastname'],
                    style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("อาชีพ : " +
                      list[index]['presentjob'] +
                      "\n" +
                        "อาชีพ : " +list[index]['presentjob'] +"\n" +
                      "ที่อยู่ : " +list[index]['Address'] +"\nวันที่เริ่มงาน :\t" +list[index]['StratTime'] +list[index]['StratTime'] +"\n""รวมเป็นเงิน : " +list[index]['Price'] +"\nสถานะการจ้าง : รอ Caregiver อนุมัติ",
                    style: const TextStyle(fontSize: 17)),
                  
                  
                  onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(list: list,index: index),),);
                  },
                ),
              );
            },
                    separatorBuilder: (context, index) => const SizedBox(height: 10));
                  }return Text('No data found');
                }),
            )
            ],))))),
              backgroundColor: Colors.white,);}}

              class DetailPage extends StatelessWidget {
  late final List list;
  late final int index;
 DetailPage({required this.list,required this.index});
  @override
   String calTotalTime(TimeOfDay startTime, TimeOfDay endTime) {
    double totalTime = (endTime.hour + (endTime.minute / 60)) -
        (startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    int minuts = ((totalTime - totalTime.floorToDouble()) * 60).round();
    return (hours == 0)
        ? '${minuts}min'
        : (minuts == 0) ? '${hours}hr' : '${hours}hr ${minuts}min';
}
 Time(TimeOfDay startTime, TimeOfDay endTime) {
    double totalTime = (endTime.hour + (endTime.minute / 60)) -
        (startTime.hour + (startTime.minute / 60));
    int hours = totalTime.floor();
    return(hours);
    
}
getgender(String dropdowngender)
{
  if(dropdowngender=='M'){
    return('ชาย');
  }
  else if(dropdowngender=='F'){
    return('หญืง');
  }
  else if(dropdowngender=='O'){
    return('อื่นๆ');
  }
}
  int Price(int Rateprice, TimeOfDay startTime, TimeOfDay endTime)
{
  int hour = Time(startTime, endTime);
  int price = Rateprice*hour;
  return(price);
}
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
                        "วันที่ทำการจอง : "+list[index]['Date'],
                    style: const TextStyle(fontSize: 15,color: Colors.black),),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        "เวลา\t"+  list[index]['StartTime']+"น. ถึง\t"+list[index]['EndTime']+" น.",
                    style: const TextStyle(fontSize: 15,color: Colors.black),),
                  ),
                ]),
              ),SizedBox(height:10 ,),
                 Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 400,
          child: Column(
              children: [Text(
                "รายละเอียดผู้จอง",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
       Text("ชื่อ-นามสกุล : "+list[index]['Firstname']+"\t"+list[index]['Lastname']+"\n"+"เบอร์ : "+"\t"+list[index]['ContactTel'],
                    style: const TextStyle(fontSize: 15,color: Colors.black),),
               
                

          
   SizedBox(height: 10,),
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
                        
                    child: Container(child: Text(
                        "ชื่อ-นามสกุล : "+list[index]['Firstnameelder']+"\t"+list[index]['Lastnameelder']+"\n"+
                       "เพศ : "+getgender(list[index]['Gender'])+"\n"+
                        "อายุ :"+list[index]['Old']+"\n"+
                        "น้ำหนัก : "+list[index]['weight']+"\n"+
                         "ส่วนสูง : "+list[index]['height']+"\n"+
                          "โรคประจำตัว :"+list[index]['Disease']+"\n"+
                           "เน้นดูเเลเพิ่มเติม : "+list[index]['MoreDetail']+"\n"+
                            "ที่อยู่ในการเข้ารับการดูแล :"+list[index]['Address']+"\n",
                       
                    style: const TextStyle(fontSize: 15,color: Colors.black),),
                  ),
                 )
          ]),
              ),SizedBox(height:10 ,),
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
                        
                    child: Container(child: Text(
                       "จำนวนชั่วโมงที่จอง : "+calTotalTime(list[index]['StartTime'], list[index]['EndTime'])+"\n"
                       "อัตราค่าจ้างชั่วโมงละ :"+list[index]['RatePrice']+"\n"
                       "รวมเป็นเงิน : "+ Price(int.parse(list[index]['RatePrice']), list[index]['StartTime'], list[index]['EndTime']).toString()+"\n"
                       "สถานะการจ้าง : รอ Caregiver อนุมัติ\n"
                       ,
                    style: const TextStyle(fontSize: 15,color: Colors.black),),
                  ),
                 )
          ]),
          )],
          ),
        )]))));
  }
}