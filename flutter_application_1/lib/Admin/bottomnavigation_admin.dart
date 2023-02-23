import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'confirmregistercaregiver.dart';
import 'confirmreport.dart';
import 'accountsetting_admin.dart';
  
class bottomnavigation_customer extends StatefulWidget {
    static const routeName = '/';
 
    const bottomnavigation_customer({Key? key}) : super(key: key);
  
    @override
    State<StatefulWidget> createState() {
        return bottomnavigation_customerState();
    }
}
  
class bottomnavigation_customerState extends State<bottomnavigation_customer> {
    int _selectedIndex = 0;
    final List<Widget> _pageWidget = <Widget>[
        const confirmregistercaregiver(),
        const confirmreport(),
        const accountsetting_admin()
    ];
    final List<BottomNavigationBarItem> _menuBar
    =  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.search),
            label: 'Cornfirm Register of Caregiver',
        ),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.listOl),
            label: 'Confirm Report',
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
        return Scaffold(
            body: _pageWidget.elementAt(_selectedIndex),
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