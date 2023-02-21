import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movieex/models/custom_page_route.dart';
import 'package:movieex/providers/cart.dart';
import 'package:movieex/providers/genres.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/screens/cart_screen.dart';
import 'package:movieex/screens/movies_screen.dart';
import 'package:movieex/widgets/badge.dart';
import 'package:movieex/widgets/drawer.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
      child: Scaffold(
          key: _key,
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.all(
                mediaQueryH / 45,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _key.currentState.openDrawer();
                  });
                },
                child: SizedBox(
                  height: mediaQueryH / 50,
                  child: ImageIcon(
                    AssetImage("assets/list.png"),
                  ),
                ),
              ),
            ),
            actions: [
              Consumer<Cart>(
                builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                ),
                child: IconButton(
                  icon: SizedBox(
                      height: mediaQueryH / 35,
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.grey[600],
                      )),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ],
            title: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
                child: Text('Genres')),
            bottom: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(
                  text: 'Movies',
                ),
                Tab(
                  text: 'Tv Shows',
                ),
              ],
            ),
          ),
          drawer: SizedBox(width: mediaQueryW / 1.4, child: AppDrawer()),
          body: TabBarView(
            controller: _tabController,
            children: [MoviesGenre(), ShowsGenre()],
          )),
    );
  }
}

class MoviesGenre extends StatefulWidget {
  @override
  State<MoviesGenre> createState() => _MoviesGenreState();
}

class _MoviesGenreState extends State<MoviesGenre> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Genres>(context).getMovieGenres().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var genres = Provider.of<Genres>(context).movieGenres;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mediaQueryH / 100.0, vertical: mediaQueryH / 80),
      child: _isLoading
          ? SpinKitDoubleBounce(size: 40, color: Colors.red[700])
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: mediaQueryH / 100,
                mainAxisSpacing: mediaQueryH / 100,
              ),
              itemCount: 10,
              itemBuilder: (ctx, i) {
                var value = genres[i];
                return GestureDetector(
                  onTap: () {
                    var list = Provider.of<Movies>(context, listen: false)
                        .findBy(value.id);
                    Navigator.of(context).push(CustomPageRoute(
                        direction: AxisDirection.left,
                        child: MoviesScreen(
                          id: value.id,
                          list: list,
                          type: value.genre,
                          k: 'movie',
                        )));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.2),
                        child: Container(
                          color: Colors.pink[700],
                          alignment: Alignment.bottomCenter,
                          child: Center(
                            child: Text(value.genre,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )),
                );
              }),
    );
  }
}

class ShowsGenre extends StatefulWidget {
  @override
  State<ShowsGenre> createState() => _ShowsGenreState();
}

class _ShowsGenreState extends State<ShowsGenre> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Genres>(context).getShowGenres().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var genres = Provider.of<Genres>(context).showGenres;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mediaQueryH / 100.0, vertical: mediaQueryH / 80),
      child: _isLoading
          ? SpinKitDoubleBounce(size: 40, color: Colors.red[700])
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: mediaQueryH / 100,
                mainAxisSpacing: mediaQueryH / 100,
              ),
              itemCount: 10,
              itemBuilder: (ctx, i) {
                var value = genres[i];
                return GestureDetector(
                  onTap: () {
                    var list = Provider.of<Shows>(context, listen: false)
                        .findBy(value.id);
                    Navigator.of(context).push(CustomPageRoute(
                        direction: AxisDirection.left,
                        child: MoviesScreen(
                          id: value.id,
                          list: list,
                          type: value.genre,
                          k: 'show',
                        )));
                  },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.2),
                        child: Container(
                          color: Colors.pink[700],
                          alignment: Alignment.bottomCenter,
                          child: Center(
                            child: Text(value.genre,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      )),
                );
              }),
    );
  }
}
