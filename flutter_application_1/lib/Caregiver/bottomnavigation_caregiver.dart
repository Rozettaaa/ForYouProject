import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'editprofile.dart';
import 'finishtask.dart';
import 'accountsettingcaregiver.dart';
  
class bottomnavigation extends StatefulWidget {
    static const routeName = '/';
 
    const bottomnavigation({Key? key}) : super(key: key);
  
    @override
    State<StatefulWidget> createState() {
        return bottomnavigationState();
    }
}
  
class bottomnavigationState extends State<bottomnavigation> {
    int _selectedIndex = 0;
    final List<Widget> _pageWidget = <Widget>[
        const home(),
        const editprofile(),
        const finishtask(),
        const accountsettingcaregiver()
    ];

    final List<BottomNavigationBarItem> _menuBar
    =  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home),
            label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.edit),
            label: 'Edit Info',
        ),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.check),
            label: 'Finish Task',
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