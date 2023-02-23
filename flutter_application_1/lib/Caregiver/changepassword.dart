import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '/createcustomer.dart';

class changepassword extends StatefulWidget {
  const changepassword({super.key});

  @override
  State<changepassword> createState() => changepasswordState();
}

class changepasswordState extends State<changepassword> {

  final TextEditingController password = TextEditingController();
  final TextEditingController new_password = TextEditingController();
  final TextEditingController confirm_password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,elevation: 0,
        leading: const BackButton(
        color: Colors.black, 
         ),
        title: Text("Change Password",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),),
        
      centerTitle: true, ),
       body: SingleChildScrollView( child : Form(  
              key: _formKey,
        child: SafeArea(
        child : Padding(
       padding: EdgeInsets.symmetric(vertical: 35),
      
          child: Center(
            child: Column(
            children: <Widget>[                           
Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 20, bottom: 0),
  child: TextFormField(
    controller: password,
      obscureText: true,
      decoration: InputDecoration(

          labelText: 'Password',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Enter your password',
            hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
            focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
         ),
      ), validator: RequiredValidator(errorText: '* Required')
  ),
),
Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 20, bottom: 0),
  child: TextFormField(
    controller: new_password,
      obscureText: true,
      decoration: InputDecoration(

          labelText: 'New Password',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
             hintText: 'Enter your password',
             hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
         ),
      ), validator: (newPassword) {
                                  if (newPassword!.isEmpty) {
                                    return "*Required";
                                  } else if (newPassword.length < 8) {
                                    return "Password must be at least 8 characters long";
                                  } else if (newPassword == password.text) {
                                    return 'Please enter new password'; 
                                  } else {
                                    return null;
                                  }
                                }
  ),
),

Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 20, bottom: 0),
  child: TextFormField(
    controller: confirm_password,
      obscureText: true,
      decoration: InputDecoration(

          labelText: 'Confirm Password',
          labelStyle: TextStyle(fontSize: 25.0,color: Colors.grey.shade700),
            floatingLabelStyle: TextStyle(fontSize: 25.0,color: Colors.amber),
            floatingLabelBehavior: FloatingLabelBehavior.always,
             hintText: 'Enter your password',
             hintStyle: TextStyle(fontSize: 17.0,color: Colors.grey.shade500),
   focusedBorder:UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber, width: 2.0),
         ),
      ), validator: (confirmPassword) {
                                  if (confirmPassword!.isEmpty) {
                                    return "*Required";
                                  } else if (confirmPassword.length < 8) {
                                    return "Password must be at least 8 characters long";
                                  } else if (confirmPassword != new_password.text) {
                                    return 'The passwords do not match'; 
                                  }  else {
                                    return null;
                                  }
                                }
            
  ),
),
 SizedBox(height: 50,),
Padding(
  padding: const EdgeInsets.only(
      left: 30.0, right: 30.0, top: 10, bottom: 0),
child: Row(
  children: <Widget>[
    Expanded(child: ElevatedButton(
      onPressed: ()=>{
                      if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
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
      ),)
      )
            ]))
        ]
        )
          )
        )
        ))),backgroundColor: Colors.white,);
  }
}
