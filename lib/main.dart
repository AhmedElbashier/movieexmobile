import 'package:flutter/material.dart';
import 'package:movieex/models/my_theme.dart';
import 'package:movieex/providers/account.dart';
import 'package:movieex/providers/actor._details.dart';
import 'package:movieex/providers/cart.dart';
import 'package:movieex/providers/genres.dart';
import 'package:movieex/providers/movie.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/show.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/providers/theme.dart';
import 'package:movieex/screens/cart_screen.dart';
import 'package:movieex/screens/nav_screens.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Movie()),
        ChangeNotifierProvider(create: (context) => Movies()),
        ChangeNotifierProvider(create: (context) => Show()),
        ChangeNotifierProvider(create: (context) => Shows()),
        ChangeNotifierProvider(create: (context) => Genres()),
        ChangeNotifierProvider(create: (context) => ActorDetails()),
        ChangeNotifierProvider(create: (context) => AccountData()),
      ],
      child: ChangeNotifierProvider(
          create: (contexr) => ThemeProvider(),
          builder: (context, snapshot) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              title: 'Movieex',
              themeMode: themeProvider.themeMode,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              home: NavScreen(),
              // home: Test(),
              routes: {
                CartScreen.routeName: (ctx) => CartScreen(),
              },
            );
          }),
    );
  }
}
