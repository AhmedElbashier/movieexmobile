import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieex/screens/cart_screen.dart';
import 'package:movieex/screens/main_screen.dart';
import 'package:movieex/screens/menu_screen.dart';
import 'package:movieex/screens/movies_shows_screen.dart';
import 'package:movieex/screens/serch_screen.dart';

class NavScreen extends StatefulWidget {
  int currentIndex;
  NavScreen({this.currentIndex});
  static const routeName = './nav-screen';
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  static List<Widget> _options = <Widget>[
    MainScreen(),
    CartScreen(),
    MovieShowScreen(),
    SearchScreen(),
    MenuScreen()
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.currentIndex == 0) {
      _selectedIndex = 0;
    } else if (widget.currentIndex == 1) {
      _selectedIndex = 1;
    } else if (widget.currentIndex == 2) {
      _selectedIndex = 2;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    return Scaffold(
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
        child: Container(
          child: _options.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
        child: SizedBox(
          height: mediaQueryH / 12,
          child: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: 'Cart',
                    backgroundColor: Theme.of(context).primaryColor),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: mediaQueryW / 12,
                    child: ImageIcon(
                      AssetImage("assets/movie.png"),
                      // color: Color(0xFF3A5A98),
                    ),
                  ),
                  label: 'Movies & TV',
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Genres',
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ],
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).hintColor,
              unselectedItemColor: Colors.grey[600],
              iconSize: 30,
              selectedLabelStyle: TextStyle(
                fontSize: mediaQueryH / 70,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).hintColor,
              ),
              unselectedLabelStyle: TextStyle(
                  fontSize: mediaQueryH / 70,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).hintColor),
              selectedFontSize: mediaQueryH / 60,
              unselectedFontSize: mediaQueryH / 60,
              onTap: _onItemTap,
              elevation: 5),
        ),
      ),
    );
  }
}
