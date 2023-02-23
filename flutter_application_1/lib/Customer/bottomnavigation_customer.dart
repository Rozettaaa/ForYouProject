import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'searchcaregiver.dart';
import 'history.dart';
import 'historywaitconfirm.dart';
import 'payment.dart';
import 'accountsetting.dart';
  
class bottomnavigation_customer extends StatefulWidget {
    static const routeName = '/';
    final String Username;
    const bottomnavigation_customer({Key? key,required this.Username})
      : super(key: key);
  
    @override
    State<StatefulWidget> createState() {
        return bottomnavigation_customerState();
    }
}
  
class bottomnavigation_customerState extends State<bottomnavigation_customer> {
    int _selectedIndex = 0;
    List<Widget> _pageWidget()=>[
         searchcaregiver(Username : widget.Username),
  historywaitconfirm(Username : widget.Username),
  history(Username : widget.Username),
    payment(Username : widget.Username),
     account(Username : widget.Username),
    ];
    final List<BottomNavigationBarItem> _menuBar
    =  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            label: 'Search Caregiver',
        ),
            BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.listCheck),
            label: 'Wait Confirm',
        ),
      
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.listOl),
            label: 'Orders',
        ),
              BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.paypal),
            label: 'Payment',
        ),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cog),
            label: 'Account Setting',
        ),
    ];
  
    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }
  
    @override
    Widget build(BuildContext context) {
      final List<Widget>pageWidget = _pageWidget();
        return Scaffold(
            body: pageWidget.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
                items: _menuBar,
                selectedItemColor: Colors.amber,
                unselectedItemColor: Colors.grey,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
            ),
        );
    }
}