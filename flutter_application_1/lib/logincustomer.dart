import 'dart:convert';
import 'package:flutter_application_1/Customer/bottomnavigation_customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Customer/searchcaregiver.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'createcustomer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api.dart';

class logincustomer extends StatefulWidget {
  static const routeName = '/logincustomer';
  const logincustomer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return logincustomerState();
  }
}

class logincustomerState extends State<logincustomer> {
  late String Username, pPassword;
  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  final _formKey = GlobalKey<FormState>();

  // กำหนดตัวแปรรับค่า
  final _username = TextEditingController();
  final _password = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  // กำหนดสถานะการแสดงแบบรหัสผ่าน
  bool _isHidden = true;

  // For CircularProgressIndicator.
  bool visible = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Sign In for Customer",
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 35),
                      child: Center(
                          child: Column(children: <Widget>[
                        Text(
                          "Welcome to For Yoü",
                          style: TextStyle(
                              fontSize: 36,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 45, bottom: 0),
                            child: TextFormField(
                              controller: _username,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.grey.shade700),
                                floatingLabelStyle: TextStyle(
                                    fontSize: 25.0, color: Colors.amber),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter your username',
                                hintStyle: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.grey.shade500),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.amber, width: 2.0),
                                ),
                              ),
                              cursorColor: Colors.amber,
                              validator:
                                  RequiredValidator(errorText: '* Required'),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 20, bottom: 0),
                          child: TextFormField(
                            controller: _password,
                            obscureText: _isHidden,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontSize: 25.0, color: Colors.grey.shade700),
                              floatingLabelStyle: TextStyle(
                                  fontSize: 25.0, color: Colors.amber),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Enter your password',
                              suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  },
                                  child: Icon(
                                      _isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey.shade700)),
                              hintStyle: TextStyle(
                                  fontSize: 17.0, color: Colors.grey.shade500),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.amber, width: 2.0),
                              ),
                            ),
                            validator:
                                RequiredValidator(errorText: '* Required'),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        ElevatedButton(
                          onPressed: () async {
                            // เปลี่ยนสถานะเป็นกำลังล็อกอิน
                            if (isLoading) {
                              return;
                            }

                            // อ้างอิงฟอร์มที่กำลังใช้งาน ตรวจสอบความถูกต้องข้อมูลในฟอร์ม
                            if (_formKey.currentState!.validate()) {
                              login(_username.text, _password.text);
                              setState(() {
                                isLoading = true;
                              });
                            }
                          },
                          child: Text("SIGN IN"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            minimumSize: Size(335, 48),
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20, bottom: 0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don’t have account?',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.normal),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const createcustomer()),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.amber,
                                    ),
                                    child: Text(
                                      'Create new account.',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  )
                                ]))
                      ])))))),
      backgroundColor: Colors.white,
    );
  }

  login(Username, Password) async {
    Map data = {'Username': Username, 'Password': Password};
    print(data.toString());
    final response = await http.post(Uri.parse(ApiUrl.logincustomer),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    setState(() {
      isLoading = false;
    });
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> resposne =
            jsonDecode(response.body.toString().replaceAll("\n", ""));
        if (!resposne['error']) {
          Map<String, dynamic> user = resposne['data'];
          print(" User name ${user['CustomerID']}");
          savePref(1, user['Username'], user['CustomerID']);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      bottomnavigation_customer(Username: _username.text)));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: const Text(
                  'Invalid Username or Password Please Try Again',
                  style: TextStyle(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: new Text(
                      "OK",
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
      } else {
        scaffoldMessenger
            .showSnackBar(SnackBar(content: Text("Please try again!")));
      }
    } catch (e) {
      print(e);
    }
  }

  final Future _prefs = SharedPreferences.getInstance();
  savePref(int value, String Username, String CustomerID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("Username", Username);
    preferences.setString("CustomerID", CustomerID.toString());
    preferences.commit();
  }
}
