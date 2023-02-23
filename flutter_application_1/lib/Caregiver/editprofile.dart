import 'package:flutter/material.dart';

class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.yellow[700],elevation: 0,
          title: Text("Edit Info",
                style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true, 
        ),
        backgroundColor: Colors.yellow[700],
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
                          backgroundImage:
                              AssetImage("assets/images/picture2.jpg"),
                          radius: 50,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          width: 75,
                          height: 25,
                          child: Text(
                            "Rating", //${details.rating}
                            textAlign: TextAlign.center,
                          ),
                        )
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
                            'AAAAAA',
                            //details.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text('BBBBBB'
                              //"อายุ ${details.age} ปี  จังหวัด ${details.city}"
                              ),
                          Text('CCCCCC'
                              //details.phonenumber
                              )
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
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("More Information...\n\n\n"),
                      //reservedatetime()
                      Text("อัตราค่าบริการ\n"),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: TextField(
                              textAlign: TextAlign.center,
                              //controller: _controller,
                              //enabled: _isEnable,
                            ),
                          ),
                          IconButton(icon: Icon(Icons.edit), onPressed: () {})
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
