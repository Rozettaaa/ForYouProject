import 'package:flutter/material.dart';
import '/logincaregiver.dart';
import 'changepassword.dart';
import '/main.dart';
import 'profilesettingcaregiver.dart';

class accountsettingcaregiver extends StatefulWidget {
  const accountsettingcaregiver({super.key});

  @override
  State<accountsettingcaregiver> createState() => accountsettingcaregiverState();
}


class accountsettingcaregiverState extends State<accountsettingcaregiver> {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,elevation: 0,
         
        ),
        body: SingleChildScrollView(
        child : Form(  
               
        child: SafeArea(
        child : Padding(
       padding: const EdgeInsets.only(
      left: 27.0, right: 27.0, top: 24, bottom: 0),
       child: 
            Column(
            children: <Widget>[
            const Center(child: Text("Account Setting",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),)),
            const Text("Update your settings like notifications, payments, profile edit etc.",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.grey,
                            /*fontWeight: FontWeight.bold*/),),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.person,),
              title: Text('Profile Information',),
              subtitle: Text('Change your account information'),
              trailing: Icon(Icons.arrow_forward_ios,),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const profilesettingcaregiver()),
                  );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock,),
              title: Text('Change Password',),
              subtitle: Text('Change your password'),
              trailing: Icon(Icons.arrow_forward_ios,),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const changepassword()),
                  );
              },
            ),
            
            ListTile(
              leading: Icon(Icons.logout,),
              title: Text('Logout',),
              trailing: Icon(Icons.arrow_forward_ios,),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const firstpagelogin()),
                  );
              },
            ),
            ]
            )
        )
        )))
            
           ,backgroundColor: Colors.white, );}}