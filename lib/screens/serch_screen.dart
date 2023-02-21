import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:movieex/models/bottom_sheet.dart';
import 'package:movieex/providers/cart.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/screens/cart_screen.dart';
import 'package:movieex/widgets/badge.dart';
import 'package:movieex/widgets/drawer.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                      // color: Color(0xFF3A5A98),
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
                  child: Text('Search')),
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
              children: [SearchMovies(), SearchShows()],
            )),
      ),
    );
  }
}

class SearchMovies extends StatefulWidget {
  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  List query = [];
  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var movies = Provider.of<Movies>(context).topRatedList;
    MBottomSheet bottomSheet = MBottomSheet();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: mediaQueryH / 50.0),
          child: Container(
              height: mediaQueryH / 19,
              width: mediaQueryW / 1.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search movies...',
                      prefixIcon: Icon(Icons.search,
                          color: Theme.of(context).hintColor,
                          size: mediaQueryH / 35),
                      hintStyle: TextStyle(color: Theme.of(context).hintColor)),
                  onChanged: (val) {
                    setState(() {
                      print(query.length);
                      Provider.of<Movies>(context, listen: false)
                          .searchMovie(val)
                          .then((value) {
                        setState(() {
                          query = Provider.of<Movies>(context, listen: false)
                              .searchList;
                        });
                        if (val == '') query.clear();
                      });
                      print(val);
                    });
                  },
                ),
              )),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQueryH / 100.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.5,
                  crossAxisSpacing: mediaQueryH / 100,
                  mainAxisSpacing: mediaQueryH / 100,
                ),
                itemCount: query.length == 0 ? movies.length : query.length,
                itemBuilder: (ctx, i) {
                  var value = query.length == 0 ? movies[i] : query[i];
                  return GestureDetector(
                    onTap: () {
                      bottomSheet.bottomSheet(
                          context,
                          mediaQueryH,
                          mediaQueryW,
                          movies,
                          value.id,
                          value.backDropPath,
                          value.lang,
                          value.mediaType,
                          value.genreIds,
                          value.title,
                          value.overview,
                          value.popularity,
                          value.posterPath,
                          value.releaseDate,
                          value.voteAverage,
                          value.voteCount,
                          value);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: value.posterPath == null
                            ? BoxDecoration()
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                                    fit: BoxFit.fitHeight)),
                        alignment: Alignment.bottomCenter,
                        child: MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 0.85),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                height: mediaQueryH / 12,
                                color: Colors.black.withOpacity(0.5),
                                // color: Colors.grey.withOpacity(0.5),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQueryH / 150.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: mediaQueryH / 80.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              value.releaseDate == null ||
                                                      value.releaseDate == ''
                                                  ? ''
                                                  : DateFormat('yyyy').format(
                                                      DateTime.parse(
                                                          value.releaseDate)),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${value.voteAverage.toStringAsFixed(1)} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[700],
                                                  size: mediaQueryH / 40,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}

class SearchShows extends StatefulWidget {
  @override
  State<SearchShows> createState() => _SearchShowsState();
}

class _SearchShowsState extends State<SearchShows> {
  MBottomSheet bottomSheet = MBottomSheet();
  List query = [];

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var shows = Provider.of<Shows>(context).topRatedList;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: mediaQueryH / 50.0),
          child: Container(
              height: mediaQueryH / 19,
              width: mediaQueryW / 1.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10)),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).hintColor,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search shows...',
                      prefixIcon: Icon(Icons.search,
                          color: Theme.of(context).hintColor,
                          size: mediaQueryH / 35),
                      hintStyle: TextStyle(color: Theme.of(context).hintColor)),
                  onChanged: (val) {
                    setState(() {
                      print(query.length);
                      Provider.of<Shows>(context, listen: false)
                          .searchShow(val)
                          .then((value) {
                        setState(() {
                          query = Provider.of<Shows>(context, listen: false)
                              .searchList;
                        });
                        if (val == '') query.clear();
                      });
                      print(val);
                    });
                  },
                ),
              )),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQueryH / 100.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.5,
                  crossAxisSpacing: mediaQueryH / 100,
                  mainAxisSpacing: mediaQueryH / 100,
                ),
                itemCount: query.length == 0 ? shows.length : query.length,
                itemBuilder: (ctx, i) {
                  var value = query.length == 0 ? shows[i] : query[i];
                  return GestureDetector(
                    onTap: () {
                      bottomSheet.bottomSheet(
                          context,
                          mediaQueryH,
                          mediaQueryW,
                          shows,
                          value.id,
                          value.backDropPath,
                          value.lang,
                          value.mediaType,
                          value.genreIds,
                          value.title,
                          value.overview,
                          value.popularity,
                          value.posterPath,
                          value.releaseDate,
                          value.voteAverage,
                          value.voteCount,
                          value);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: value.posterPath == null
                            ? BoxDecoration()
                            : BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                                    fit: BoxFit.fitHeight)),
                        alignment: Alignment.bottomCenter,
                        child: MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 0.85),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                height: mediaQueryH / 12,
                                color: Colors.black.withOpacity(0.5),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQueryH / 150.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value.title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: mediaQueryH / 80.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              value.releaseDate == null ||
                                                      value.releaseDate == ''
                                                  ? ''
                                                  : DateFormat('yyyy').format(
                                                      DateTime.parse(
                                                          value.releaseDate)),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${value.voteAverage.toStringAsFixed(1)} ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow[700],
                                                  size: mediaQueryH / 40,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
