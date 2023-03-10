import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'logincaregiver.dart';
import 'api.dart';

class createcaregiver extends StatefulWidget {
  const createcaregiver({super.key});

  @override
  State<createcaregiver> createState() => createcaregiverState();
  
}


class createcaregiverState extends State<createcaregiver> {
  
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
     TextEditingController detail = TextEditingController();
 TextEditingController presentjob = TextEditingController();
 TextEditingController ability = TextEditingController();
  TextEditingController rate= TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String dropdownValue = 'Mr.';  
  String dropdowngender = 'M';  
  
  File? _image = null;
  late final _picker = ImagePicker();
  
  File? _copy = null;
  late final _copypicker = ImagePicker();

 File? _resume = null;
  late final _resumepicker = ImagePicker();

File? _criminal = null;
  late final _criminalpicker = ImagePicker();

  File? _qr = null;
  late final _qrpicker = ImagePicker();
  
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
    Future getqr() async {
    final XFile? qr = await _qrpicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (qr != null) {
          _qr = File(qr.path);
          
        } else {
          print('No image selected.');
        }
      },
    );
  }
  Future getresume() async {
    final XFile? resume = await _resumepicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (resume != null) {
          _resume = File(resume.path);
          
        } else {
          print('No image selected.');
        }
      },
    );
  }
   Future getcriminal() async {
    final XFile? criminal = await _criminalpicker.pickImage(source: ImageSource.gallery);

    setState(
      () {
        if (criminal != null) {
          _criminal = File(criminal.path);
          
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
              "?????????????????????????????????????????????",
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
                    MaterialPageRoute(builder: (context) => const logincaregiver()),
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
              "???????????????????????????????????????????????????????????????????????????????????????",
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

    var url = Uri.parse(ApiUrl.registercaregiver);
    var request = http.MultipartRequest("POST",url);
    var pic = await http.MultipartFile.fromPath("Profilepicture", _image!.path);
    var copy = await http.MultipartFile.fromPath("Copy_IDCard", _copy!.path);
    var resum = await http.MultipartFile.fromPath("Resume", _resume!.path);
    var qrcode = await http.MultipartFile.fromPath("QRCodePayment", _qr!.path);
    var crim = await http.MultipartFile.fromPath("Criminalpicture", _criminal!.path);
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
    request.fields['RatePrice'] = rate.text;
    request.fields['Work'] = detail.text;
    request.fields['presentjob'] = presentjob.text;
    request.fields['moreability'] = ability.text;
    request.fields['DOB'] = dob.text;
    request.files.add(pic);
    request.files.add(copy);
    request.files.add(crim);
    request.files.add(resum);
    request.files.add(qrcode);
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
    rate.text = "";
    detail.text="";
    presentjob.text="";
    ability.text="";
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
          title: Text("Sign Up for Caregiver",
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
                                 Text("???????????????????????????????????????????????????????????????????????????",
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
          hintText: '??????????????????????????? Email',
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
          hintText: '??????????????????????????? Username',
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
          hintText: '??????????????????????????? Password',
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
     labelText: '????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
    
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
    ),
  ),
  value: dropdownValue,
  
  items:[
       DropdownMenuItem(
                            child: Text("?????????"),
                            value: "Mr."
                          ),
                          DropdownMenuItem(
                            child: Text("??????????????????"),
                            value: "Ms.",
                          ),
                          DropdownMenuItem(
                            child: Text("?????????"),
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
          labelText: '????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '????????????????????????????????????????????????????????????????????????',
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
          labelText: '?????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '?????????????????????????????????????????????????????????????????????????????????',
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
                    labelText: '?????????/???????????????/??????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: '?????????????????????????????????????????????/???????????????/??????????????????',
   
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
     labelText: '?????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
    
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
    ),
  ),
  value: dropdowngender,
  items:[
       DropdownMenuItem(
                            child: Text("?????????"),
                            value: "M"
                          ),
                          DropdownMenuItem(
                            child: Text("????????????"),
                            value: "F",
                          ),
                          DropdownMenuItem(
                            child: Text("???????????? ???"),
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
          labelText: '????????????????????? (?????????)',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '?????????????????????????????????????????????????????????????????????',
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
          labelText: '????????????????????? (?????????????????????)',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '?????????????????????????????????????????????????????????????????????????????????',
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
          labelText: '???????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '??????????????????????????????????????????????????????????????????',
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
          labelText: '??????????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '?????????????????????????????????????????????????????????????????????',
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
                    labelText: '?????????????????????????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: '??????????????????????????????',
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
                  Text('????????????????????????????????????????????????') 
                                          
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
                    labelText: '??????????????????????????????????????????????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: '??????????????????????????????',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),//label text of field
            ),
           readOnly: true,  // when true user cannot edit text 
           onTap: () async { 
              getcriminal();
            }
            
  ) ),
            
      SizedBox(
              height: 2,
            ),
            Container(  //show image here after choosing image
                            child: _criminal == null? 
                Text('????????????????????????????????????????????????') 
                                          
 : Stack(
                children: <Widget>[
                  Container(
                    width: 250.0,
                    height: 320.0,
                    child: new Image.file(_criminal!),
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
                           _criminal = null;
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
      left: 30.0, right: 30.0, top: 20, bottom: 0),
  child:                           
 TextFormField(
   controller: presentjob,
      decoration: InputDecoration(
          labelText: '???????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '??????????????????????????????????????????????????????????????????',
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
      left: 30.0, right: 30.0, top: 20, bottom: 0),
  child:                           
 TextFormField(
   controller: ability,
      decoration: InputDecoration(
          labelText: '???????????????????????????????????????????????????????????????????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
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
      left: 30.0, right: 30.0, top: 20, bottom: 0),
  child:                           
 TextFormField(
   controller: detail,
      decoration: InputDecoration(
          labelText: '????????????????????????????????????????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '????????????????????????????????????????????? ????????????,?????????????????????????????????',
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
      child: TextFormField(
       //editing controller of this TextField
          decoration: InputDecoration( 
                    suffixIcon: Icon(Icons.upload_file,color: Colors.grey.shade500,), //icon of text field
                    labelText: 'Resume ??????????????????????????????????????????????????????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: '??????????????????????????????',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),//label text of field
            ),
           readOnly: true,  // when true user cannot edit text 
           onTap: () async {
                            getresume();
      
            }
  )), 
              SizedBox(
              height: 2,
            ),
            Container(  //show image here after choosing image
                            child: _resume == null? 
                  Text('????????????????????????????????????????????????') 
                                          
                : Stack(
                children: <Widget>[
                  Container(
                    width: 250.0,
                    height: 320.0,
                    child: new Image.file(_resume!),
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
                           _resume = null;
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
      left: 30.0, right: 30.0, top: 4, bottom: 0),
      child: TextFormField(
       //editing controller of this TextField
          decoration: InputDecoration( 
                    suffixIcon: Icon(Icons.upload_file,color: Colors.grey.shade500,), //icon of text field
                    labelText: '????????? QRcode Payment',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: '??????????????????????????????',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),//label text of field
            ),
           readOnly: true,  // when true user cannot edit text 
           onTap: () async {
                            getqr();
      
            }
  )), 
              SizedBox(
              height: 2,
            ),
            Container(  //show image here after choosing image
                            child: _qr == null? 
                  Text('????????????????????????????????????????????????') 
                                          
                : Stack(
                children: <Widget>[
                  Container(
                    width: 250.0,
                    height: 320.0,
                    child: new Image.file(_qr!),
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
                           _qr = null;
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
      left: 30.0, right: 30.0, top: 4, bottom: 0),
      child: TextFormField(
       //editing controller of this TextField
          decoration: InputDecoration( 
                    suffixIcon: Icon(Icons.upload_file,color: Colors.grey.shade500,), //icon of text field
                    labelText: '??????????????????????????????',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelBehavior: FloatingLabelBehavior.always,
    hintText: '??????????????????????????????',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
    focusedBorder: UnderlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
          ),//label text of field
            ),
           readOnly: true,  // when true user cannot edit text 
           onTap: () async {
                            getImage();
      
            }
  )), 
              SizedBox(
              height: 2,
            ),
            Container(  //show image here after choosing image
                            child: _image == null? 
                  Text('????????????????????????????????????????????????') 
                                          
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
      left: 30.0, right: 30.0, top: 4, bottom: 0),
  child:                           
 TextFormField(
  controller: rate,
      decoration: InputDecoration(
          labelText: '?????????????????????????????????????????? (??????????????????????????????)',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: '??????????????????????????????????????????????????????',
          hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
          ),
      ),
      cursorColor: Colors.amber, 
      validator:  MultiValidator([   
    MaxLengthValidator(4, errorText: 'Please enter 13 digit'),  
    PatternValidator(r'^([0-9])+$', errorText: 'Only numberic'),
 ])
      )),                   
                
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
      
      child: Text("???????????????????????????"),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
        minimumSize: Size(335, 48), 
        textStyle: const TextStyle(
                color: Colors.white,
                 fontSize: 12, 
                 fontStyle: FontStyle.normal),
      ),)
      )]))
        
                 ]
        )
        )))
    ),backgroundColor: Colors.white,);
  }


}