import 'package:flutter/material.dart';
import 'package:movieex/models/custom_page_route.dart';
import 'package:movieex/providers/theme.dart';
import 'package:movieex/screens/contact_us.dart';
import 'package:movieex/screens/favourites_screen.dart';
import 'package:movieex/screens/movies_shows_screen.dart';
import 'package:movieex/screens/nav_screens.dart';
import 'package:movieex/widgets/theme_button.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    final theme = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DrawerHeader(
                  child: Container(
                child: Image.asset('assets/logo.png'),
              )),
              Divider(
                color: Theme.of(context).hintColor,
              ),
              ListTile(
                leading: Icon(Icons.home, color: Theme.of(context).hintColor),
                title: Text(
                  'Home',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return NavScreen();
                  }), (route) => false);
                },
              ),
              Divider(
                color: Theme.of(context).hintColor,
              ),
              ListTile(
                leading: SizedBox(
                  height: mediaQueryH / 35,
                  child: ImageIcon(
                    AssetImage("assets/movie.png"),
                    color: Theme.of(context).hintColor,
                  ),
                ),
                title: Text(
                  'Movies',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.of(context).push(CustomPageRoute(
                      direction: AxisDirection.left,
                      child: Scaffold(
                          backgroundColor: Theme.of(context).primaryColor,
                          appBar: AppBar(
                            centerTitle: true,
                            title: Text(
                              'Movies',
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                          ),
                          body: MoviesSc())));
                },
              ),
              Divider(
                color: Theme.of(context).hintColor,
              ),
              ListTile(
                leading: SizedBox(
                  height: mediaQueryH / 35,
                  child: ImageIcon(
                    AssetImage("assets/tv.png"),
                    color: Theme.of(context).hintColor,
                  ),
                ),
                title: Text(
                  'TV Shows',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.of(context).push(CustomPageRoute(
                      direction: AxisDirection.left,
                      child: Scaffold(
                          backgroundColor: Theme.of(context).primaryColor,
                          appBar: AppBar(
                            centerTitle: true,
                            title: Text(
                              'Shows',
                              style:
                                  TextStyle(color: Theme.of(context).hintColor),
                            ),
                          ),
                          body: ShowsSc())));
                },
              ),
              Divider(
                color: Theme.of(context).hintColor,
              ),
              ListTile(
                leading: Icon(Icons.favorite_border,
                    color: Theme.of(context).hintColor),
                title: Text(
                  'Favorites',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.of(context).push(CustomPageRoute(
                      direction: AxisDirection.left, child: FavsScreen()));
                },
              ),
              Divider(
                color: Theme.of(context).hintColor,
              ),
              ListTile(
                leading: SizedBox(
                  height: mediaQueryH / 30,
                  child: ImageIcon(
                    AssetImage("assets/contact.png"),
                    color: Theme.of(context).hintColor,
                  ),
                ),
                title: Text(
                  'Contact us',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                onTap: () {
                  Navigator.of(context).push(CustomPageRoute(
                      direction: AxisDirection.left, child: ContactUs()));
                },
              ),
              Divider(
                color: Theme.of(context).hintColor,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: mediaQueryH / 100,
                    top: mediaQueryH / 150,
                    left: mediaQueryW / 30),
                child: Text(
                  'Theme Mode',
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              ListTile(
                leading: SizedBox(
                    height: mediaQueryH / 40,
                    child: theme.themeMode == ThemeMode.dark
                        ? ImageIcon(
                            AssetImage('assets/moon.png'),
                            color: Colors.grey,
                          )
                        : ImageIcon(
                            AssetImage('assets/sun.png'),
                            color: Colors.grey,
                          )),
                title: Text(
                  theme.themeMode == ThemeMode.dark ? 'Dark' : 'Light',
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                trailing: ThemeButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
