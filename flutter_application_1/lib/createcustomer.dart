import 'package:flutter/material.dart';
import 'package:flutter_application_1/logincustomer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'logincustomer.dart';
import 'package:path/path.dart';
import 'api.dart';
class createcustomer extends StatefulWidget {
  const createcustomer({super.key});

  @override
  State<createcustomer> createState() => createcustomerState();
}

class createcustomerState extends State<createcustomer> {

   late double screenHeight, screenWidth, ctrwidth;
   TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController firstname = TextEditingController();
    TextEditingController lastname = TextEditingController();
    TextEditingController district = TextEditingController();
    TextEditingController province = TextEditingController();
    TextEditingController IDCard = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController dob = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String dropdownValue = 'Mr.';  
  String dropdowngender = 'M';  
  
  File? _image = null;
  late final _picker = ImagePicker();
  
  File? _copy = null;
  late final _copypicker = ImagePicker();

  Future getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (image != null) {
          _image = File(image.path);
          
        } else {
          print('No image selected.');
        }
      },
    );
  }
  Future getcopy() async {
    final XFile? copy = await _copypicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (copy != null) {
          _copy = File(copy.path);
          
        } else {
          print('No image selected.');
        }
      },
    );
  }
 void successDialog(BuildContext context) {
    if (_formKey.currentState!.validate()!= null) {
      _formKey.currentState!.save();
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
                    MaterialPageRoute(builder: (context) => const logincustomer()),
                  );
                },
              )
            ],
          );
        },
      );
    }
  }
void _insertDialog(BuildContext context) {
    if (_formKey.currentState!.validate()!= null) {
      _formKey.currentState!.save();
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
  }
  @override
   
  Future<void> sendData() async {

    var url = Uri.parse(ApiUrl.registercustomer);
    var request = http.MultipartRequest("POST",url);
    var pic = await http.MultipartFile.fromPath("Profilepicture", _image!.path);
    var copy = await http.MultipartFile.fromPath("Copy_IDCard", _copy!.path);
    request.fields['Email'] = email.text;
    request.fields['Username'] = username.text;
    request.fields['Password'] = password.text;
    request.fields['Title'] = dropdownValue;
    request.fields['Firstname'] = firstname.text;
    request.fields['Lastname'] = lastname.text;
    request.fields['Gender'] = dropdowngender;
    request.fields['District'] = district.text;
    request.fields['Province'] = province.text;
    request.fields['IDCard'] = IDCard.text;
    request.fields['ContactTel'] = phone.text;
    request.fields['DOB'] = dob.text;
    request.files.add(pic);
    request.files.add(copy);
     var response = await request.send();
    if (response.statusCode == 200) {
      print("uploaded successfully");
    }else{
      print("uploaded failed");
    }
    email.text = "";
    username.text = "";
    password.text = "";
    dropdownValue = "";
    firstname.text = "";
    lastname.text = "";
    dropdowngender = "";
    district.text = "";
    province.text = "";
    IDCard.text = "";
    phone.text = "";
    dob.text = "";
  }
  @override
  Widget build(BuildContext context) {
      screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth / 1.1;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,elevation: 0,
        leading: const BackButton(
        color: Colors.black, 
         ),
          title: Text("Sign Up for Customer",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),),
        
      centerTitle: true, 
        ),
      body: SingleChildScrollView(
        child : Form(  
               key: _formKey,
        child: SafeArea(
        child : Padding(
       padding: EdgeInsets.symmetric(vertical: 7),
       child: 
            Column(
            children: <Widget>[
            Text("Create Account",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                                 Text("กรุณากรอกข้อมูลให้ครบถ้วน",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.normal),),
            
             Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 20, bottom: 0),
  child:                           
 TextFormField(
   controller: email,
      decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอก Email',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
        validator: EmailValidator(errorText: '* Required')
      )),
             Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
  controller: username,
      decoration: InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอก Username',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator: RequiredValidator(errorText: '* Required')
      )),
          Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
  controller: password,
      decoration: InputDecoration(
          labelText: 'Password',
      
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอก Password',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      
      validator: RequiredValidator(errorText: '* Required')
      )),
      SizedBox(
              height: 25,
            ),
              Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
     DropdownButtonFormField(
 
  decoration: InputDecoration(
     labelText: 'คำนำหน้า',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
    
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
    ),
  ),
  value: dropdownValue,
  
  items:[
       DropdownMenuItem(
                            child: Text("นาย"),
                            value: "Mr."
                          ),
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
             
             
              Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
   controller: firstname,
      decoration: InputDecoration(
          labelText: 'ชื่อ',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอกชื่อเป็นภาษาไทย',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator: RequiredValidator(errorText: '* Required')
      )),
          Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
   controller: lastname,
      decoration: InputDecoration(
          labelText: 'นามสกุล',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอกนามสกุลเป็นภาษาไทย',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator: RequiredValidator(errorText: '* Required')
      )),
      Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child: 
      TextField(
        controller: dob, //editing controller of this TextField
          decoration: InputDecoration( 
                    suffixIcon: IconButton(icon: Icon(Icons.calendar_today,color: Colors.grey.shade500),
                    onPressed: () async {
                 DateTime? pickedDate = await showDatePicker(builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme:
                            ColorScheme.light(primary: Colors.amber),
                      ),
                      child: child!,
                    );},
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate:DateTime(1900), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  if(pickedDate != null ){
                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                      setState(() {
                         dob.text = formattedDate; 
                          //set foratted date to TextField value. 
                      });
                  }
                  
            }), //icon of text field
                    labelText: 'วัน/เดือน/ปีเกิด',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: 'กรุณากดเลือกวัน/เดือน/ปีเกิด',
   
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),
           
            ),
            
           readOnly: true,  // when true user cannot edit text 
           
  ) ),
   Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
     DropdownButtonFormField(
  decoration: InputDecoration(
     labelText: 'เพศ',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
    
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
    ),
  ),
  value: dropdowngender,
  items:[
       DropdownMenuItem(
                            child: Text("ชาย"),
                            value: "M"
                          ),
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
 Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
  controller: district,
      decoration: InputDecoration(
          labelText: 'ที่อยู่ (เขต)',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอกเขตเป็นภาษาไทย',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator: RequiredValidator(errorText: '* Required')
      )),
      Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
  controller: province,
      decoration: InputDecoration(
          labelText: 'ที่อยู่ (จังหวัด)',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอกจังหวัดเป็นภาษาไทย',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator: RequiredValidator(errorText: '* Required')
      )),
       Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
  controller: phone,
      decoration: InputDecoration(
          labelText: 'เบอร์โทรศัพท์',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอกเบอร์โทรศัพท์',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator:  MultiValidator([   
    MinLengthValidator(10, errorText: 'Please enter 10 digit'),  
    PatternValidator(r'^([0-9])+$', errorText: 'Only numberic'),
 ])
      )),
      SizedBox(
              height: 25,
            ),

             Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
  controller: IDCard,
      decoration: InputDecoration(
          labelText: 'เลขบัตรประชาชน',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'กรุณากรอกเลขบัตรประชาชน',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator:  MultiValidator([   
    MinLengthValidator(13, errorText: 'Please enter 13 digit'),  
    PatternValidator(r'^([0-9])+$', errorText: 'Only numberic'),
 ])
      )),

    Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
      child: TextFormField(
       //editing controller of this TextField
          decoration: InputDecoration( 
                    suffixIcon: Icon(Icons.upload_file,color: Colors.grey.shade500,), //icon of text field
                    labelText: 'รูปสำเนาบัตรประชาชน',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: 'กดเลือกรูป',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),//label text of field
            ),
           readOnly: true,  // when true user cannot edit text 
           onTap: () async {
                            getcopy();
      
            }
  )), 
              SizedBox(
              height: 2,
            ),
            Container(  //show image here after choosing image
                            child: _copy == null? 
                  Text('ไม่มีรูปที่เลือก') 
                                          
                : Stack(
                children: <Widget>[
                  Container(
                    width: 250.0,
                    height: 320.0,
                    child: new Image.file(_copy!),
                  ),
                  Positioned(
                    right: 5.0,
                    child: InkWell(
                      child: Icon(
                        Icons.remove_circle,
                        size: 30,
                        color: Colors.red,
                      ),
                      // This is where the _image value sets to null on tap of the red circle icon
                      onTap: () {
                        setState(
                          () {
                           _copy = null;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

                        ),
    SizedBox(
              height: 2,
            ),
      Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:
      TextField(
     //editing controller of this TextField
          decoration: InputDecoration( 
                    suffixIcon: Icon(Icons.upload_file,color: Colors.grey.shade500,), //icon of text field
                    labelText: 'รูปโปรไฟล์',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: 'กดเลือกรูป',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),//label text of field
            ),
           readOnly: true,  // when true user cannot edit text 
           onTap: () async { 
              getImage();
            }
            
  ) ),
            
      SizedBox(
              height: 2,
            ),
            Container(  //show image here after choosing image
                            child: _image == null? 
                Text('ไม่มีรูปที่เลือก') 
                                          
 : Stack(
                children: <Widget>[
                  Container(
                    width: 250.0,
                    height: 320.0,
                    child: new Image.file(_image!),
                  ),
                  Positioned(
                    right: 5.0,
                    child: InkWell(
                      child: Icon(
                        Icons.remove_circle,
                        size: 30,
                        color: Colors.red,
                      ),
                      // This is where the _image value sets to null on tap of the red circle icon
                      onTap: () {
                        setState(
                          () {
                           _image = null;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 27, bottom: 36),
child: Row(
  children: <Widget>[
    Expanded(child: ElevatedButton(
      onPressed: ()=>{  if (_formKey.currentState!.validate()) { 
                              _insertDialog(context)
                              }
                     
                }
      , 
      
      child: Text("ลงทะเบียน"),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
        minimumSize: Size(335, 48), 
        textStyle: const TextStyle(
                color: Colors.white,
                 fontSize: 12, 
                 fontStyle: FontStyle.normal),
      ),)
      )
            ])) 
                 ]
        )
        )))
    ),backgroundColor: Colors.white,);
  }
  


 
}