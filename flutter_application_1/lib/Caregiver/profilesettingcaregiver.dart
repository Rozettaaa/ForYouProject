import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '/createcustomer.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

class profilesettingcaregiver extends StatefulWidget {
  const profilesettingcaregiver({super.key});

  @override
  State<profilesettingcaregiver> createState() =>
      profilesettingcaregiverState();
}

class profilesettingcaregiverState extends State<profilesettingcaregiver> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'นาย';
  String dropdowngender = 'ชาย';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Profile Setting",
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
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 25, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your Email',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: RequiredValidator(
                                    errorText: '* Required'))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
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
                                validator: RequiredValidator(
                                    errorText: '* Required'))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle:
                                      TextStyle(color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: RequiredValidator(
                                    errorText: '* Required'))),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.grey.shade700),
                                focusedBorder: UnderlineInputBorder(
                                  //<-- SEE HERE
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400, width: 2),
                                ),
                              ),
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'นาย',
                                'นางสาว',
                                'นาง'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Firstname',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter yor thai firstname',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: RequiredValidator(
                                    errorText: '* Required'))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Surname',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter yor thai surname.',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: RequiredValidator(
                                    errorText: '* Required'))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your age',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: MultiValidator([
                                  RequiredValidator(errorText: '* Required'),
                                  PatternValidator(r'^([0-9])+$',
                                      errorText: 'Only numberic'),
                                ]))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextField(
                                controller:
                                    dateController, //editing controller of this TextField
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey.shade500,
                                  ), //icon of text field
                                  labelText: 'Date of birth',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your date of birth',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 2),
                                  ),
                                ),
                                readOnly:
                                    true, // when true user cannot edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          DateTime.now(), //get today's date
                                      firstDate: DateTime(
                                          1900), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));
                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(
                                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2022-07-04
                                    //You can format date as per your need

                                    setState(() {
                                      dateController.text =
                                          formattedDate; //set foratted date to TextField value.
                                    });
                                  } else {
                                    RequiredValidator(errorText: '* Required');
                                  }
                                })),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                labelStyle: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.grey.shade700),
                                focusedBorder: UnderlineInputBorder(
                                  //<-- SEE HERE
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400, width: 2),
                                ),
                              ),
                              value: dropdowngender,
                              onChanged: (String? newgender) {
                                setState(() {
                                  dropdowngender = newgender!;
                                });
                              },
                              items: <String>[
                                'ชาย',
                                'หญิง',
                                'อื่นๆ'
                              ].map<DropdownMenuItem<String>>((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(
                                    gender,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                );
                              }).toList(),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'District',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your District in Thai',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: RequiredValidator(
                                    errorText: '* Required'))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Province',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your Province in Thai',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: RequiredValidator(
                                    errorText: '* Required'))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Telephone Number',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your telephone number',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: MultiValidator([
                                  MinLengthValidator(10,
                                      errorText: 'Please enter 10 digit'),
                                  PatternValidator(r'^([0-9])+$',
                                      errorText: 'Only numberic'),
                                ]))),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'ID Card',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0, color: Colors.amber),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your ID Card',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.amber, width: 2.0),
                                  ),
                                ),
                                cursorColor: Colors.amber,
                                validator: MultiValidator([
                                  MinLengthValidator(13,
                                      errorText: 'Please enter 13 digit'),
                                  PatternValidator(r'^([0-9])+$',
                                      errorText: 'Only numberic'),
                                ]))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextField(
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.upload_file,
                                    color: Colors.grey.shade500,
                                  ), //icon of text field
                                  labelText: 'ID Card copy file',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Press to select an image/file',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 2),
                                  ), //label text of field
                                ),
                                readOnly:
                                    true, // when true user cannot edit text
                                onTap: () async {
                                  final picked =
                                      await FilePicker.platform.pickFiles();

                                  if (picked != null) {
                                    print(picked.files.first.name);
                                  }
                                })),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 4, bottom: 0),
                            child: TextField(
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  suffixIcon: Icon(
                                    Icons.upload_file,
                                    color: Colors.grey.shade500,
                                  ), //icon of text field
                                  labelText: 'Criminal Background Check File',
                                  labelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelStyle: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.grey.shade700),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Press to select an image/file',
                                  hintStyle: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.grey.shade500),
                                  focusedBorder: UnderlineInputBorder(
                                    //<-- SEE HERE
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400, width: 2),
                                  ), //label text of field
                                ),
                                readOnly: true,
                                onTap: () async {
                                  var picked =
                                      await FilePicker.platform.pickFiles();
                                  if (picked != null) {
                                    print(picked.files.first.name);
                                  }
                                })),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 10, bottom: 0),
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: ElevatedButton(
                                onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      )
                                    }
                                },
                                child: Text("Confirm"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.amber,
                                  minimumSize: Size(335, 48),
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal),
                                ),
                              ))
                            ]))
                      ])))))),
      backgroundColor: Colors.white,
    );
  }
}
