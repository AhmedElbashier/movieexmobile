import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieex/models/bottom_sheet.dart';
import 'package:movieex/models/custom_page_route.dart';
import 'package:movieex/providers/account.dart';
import 'package:movieex/providers/cart.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/screens/detail_screen.dart';
import 'package:movieex/screens/movies_shows_screen.dart';
import 'package:movieex/screens/nav_screens.dart';
import 'package:movieex/widgets/badge.dart';
import 'package:movieex/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Movies>(
        context,
      ).trendingMovies(1).then((value) {
        Provider.of<Movies>(context, listen: false)
            .upcomingMovies(1)
            .then((value) {
          Provider.of<AccountData>(context, listen: false)
              .getAccount()
              .then((value) {
            Provider.of<Movies>(context, listen: false)
                .popularMovies(1)
                .then((value) {
              Provider.of<Movies>(context, listen: false)
                  .topRatedMovies(1)
                  .then((value) {
                Provider.of<Shows>(context, listen: false)
                    .trendingShows(1)
                    .then((value) {
                  Provider.of<Shows>(context, listen: false)
                      .popularShows(1)
                      .then((value) {
                    Provider.of<Shows>(context, listen: false)
                        .topRatedShows(1)
                        .then((value) {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  });
                });
              });
            });
          });
        });
      });
    }
    _isInit = false;
  }

  Widget shimmerLoading(mediaQueryH, mediaQueryW) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Container(
            color: Theme.of(context).cardColor, height: mediaQueryH / 3.2),
        ListTile(
          tileColor: Theme.of(context).primaryColor,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: Theme.of(context).cardColor,
              height: mediaQueryH / 50,
              width: mediaQueryW / 2,
            ),
          ),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: Theme.of(context).cardColor,
              height: mediaQueryH / 50,
              width: mediaQueryW / 7,
            ),
          ),
        ),
        Container(
          height: mediaQueryH / 2.5,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: mediaQueryW / 2.5,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: mediaQueryH / 3.2,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: mediaQueryH / 90),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: mediaQueryH / 70,
                                color: Theme.of(context).cardColor,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
        Container(
          height: mediaQueryH / 2.5,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: mediaQueryW / 2.5,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: mediaQueryH / 3.2,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: mediaQueryH / 90),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: mediaQueryH / 70,
                                color: Theme.of(context).cardColor,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget dropfilter(mediaQueryH, mediaQueryW, value) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: mediaQueryH / 30,
          color: Colors.black.withOpacity(0.1),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaQueryW / 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy').format(DateTime.parse(value.releaseDate)),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: mediaQueryH / 65),
                ),
                Row(
                  children: [
                    Text(
                      value.voteAverage.toStringAsFixed(1),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: mediaQueryH / 65),
                    ),
                    Icon(
                      Icons.star,
                      size: mediaQueryH / 50,
                      color: Colors.yellow[800],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget container(mediaQueryH, mediaQueryW, trendList, type) {
    MBottomSheet bottomSheet = MBottomSheet();
    return Container(
      height: mediaQueryH / 2.5,
      child: ListView.builder(
          itemCount: 7,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) {
            var value = trendList[i];
            return GestureDetector(
              onTap: () {
                bottomSheet.bottomSheet(
                    context,
                    mediaQueryH,
                    mediaQueryW,
                    trendList,
                    value.id,
                    value.backDropPath,
                    value.lang,
                    type,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: mediaQueryW / 2.5,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: mediaQueryH / 3.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                                    fit: BoxFit.fitHeight)),
                            alignment: Alignment.bottomCenter,
                            child: dropfilter(mediaQueryH, mediaQueryW, value)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: mediaQueryH / 90),
                        child: Text(
                          value.title,
                          style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: mediaQueryH / 65),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var trending = Provider.of<Movies>(context).trendList;
    var popular = Provider.of<Movies>(context).popList;
    var topRated = Provider.of<Movies>(context).topRatedList;
    var latest = Provider.of<Movies>(context).upcoming;
    var trendingSh = Provider.of<Shows>(context).trendList;
    var popularSh = Provider.of<Shows>(context).popList;
    var topRatedSh = Provider.of<Shows>(context).topRatedList;

    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movieex'),
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return NavScreen(
                    currentIndex: 1,
                  );
                }), (route) => false);
              },
            ),
          ),
        ],
      ),
      drawer: SizedBox(width: mediaQueryW / 1.4, child: AppDrawer()),
      body: _isLoading
          ? shimmerLoading(mediaQueryH, mediaQueryW)
          : Container(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider.builder(
                      itemCount: latest.length,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 1,
                          height: mediaQueryH / 3.2),
                      itemBuilder:
                          (BuildContext context, int ind, int pageViewIndex) {
                        var value = latest[ind];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                direction: AxisDirection.up,
                                child: DeatailScreen(
                                  id: value.id,
                                  backDropPath: value.backDropPath,
                                  lang: value.lang,
                                  mediaType: value.mediaType,
                                  genreIds: value.genreIds,
                                  title: value.title,
                                  overview: value.overview,
                                  popularity: value.popularity,
                                  posterPath: value.posterPath,
                                  releaseDate: value.releaseDate,
                                  voteAverage: value.voteAverage,
                                  voteCount: value.voteCount,
                                  object: value,
                                )));
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500${value.backDropPath}'),
                                    fit: BoxFit.fitHeight)),
                            child: Container(
                              color: Colors.black.withOpacity(0.4),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: mediaQueryW / 40.0,
                                    bottom: mediaQueryH / 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(textScaleFactor: 1.0),
                                      child: Text(
                                        value.title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQueryH / 150,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: mediaQueryH / 50,
                                          color: Colors.yellow[800],
                                        ),
                                        MediaQuery(
                                          data: MediaQuery.of(context)
                                              .copyWith(textScaleFactor: 0.9),
                                          child: Text(
                                            value.voteAverage
                                                .toStringAsFixed(1),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mediaQueryH / 70,
                                    ),
                                    SizedBox(
                                      width: mediaQueryW / 1.5,
                                      child: MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 0.7),
                                        child: Text(
                                          value.overview,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // child: Image.network(
                            //   '',
                            //   fit: BoxFit.fitHeight,
                            // ),
                          ),
                        );
                      }),
                  ListTile(
                    leading: Text(
                      'Trending Movies',
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: mediaQueryH / 40),
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            direction: AxisDirection.left,
                            child: Scaffold(
                                backgroundColor: Theme.of(context).primaryColor,
                                appBar: AppBar(
                                  centerTitle: true,
                                  title: Text(
                                    'Movies',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                                body: MoviesSc(
                                  type: 'trending',
                                ))));
                      },
                      child: Text(
                        'Explore all',
                        style: TextStyle(
                            color: Colors.red[700], fontSize: mediaQueryH / 65),
                      ),
                    ),
                  ),
                  container(mediaQueryH, mediaQueryW, trending, 'movie'),
                  ListTile(
                    leading: Text(
                      'Popular Movies',
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: mediaQueryH / 40),
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            direction: AxisDirection.left,
                            child: Scaffold(
                                backgroundColor: Theme.of(context).primaryColor,
                                appBar: AppBar(
                                  centerTitle: true,
                                  title: Text(
                                    'Movies',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                                body: MoviesSc(
                                  type: 'popular',
                                ))));
                      },
                      child: Text(
                        'Explore all',
                        style: TextStyle(
                            color: Colors.red[700], fontSize: mediaQueryH / 65),
                      ),
                    ),
                  ),
                  container(mediaQueryH, mediaQueryW, popular, 'movie'),
                  ListTile(
                    leading: Text(
                      'Top Rated Movies',
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: mediaQueryH / 40),
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            direction: AxisDirection.left,
                            child: Scaffold(
                                backgroundColor: Theme.of(context).primaryColor,
                                appBar: AppBar(
                                  centerTitle: true,
                                  title: Text(
                                    'Movies',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                                body: MoviesSc(
                                  type: 'topRated',
                                ))));
                      },
                      child: Text(
                        'Explore all',
                        style: TextStyle(
                            color: Colors.red[700], fontSize: mediaQueryH / 65),
                      ),
                    ),
                  ),
                  container(mediaQueryH, mediaQueryW, topRated, 'movie'),
                  ListTile(
                    leading: Text(
                      'Trending TV Shows',
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: mediaQueryH / 40),
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            direction: AxisDirection.left,
                            child: Scaffold(
                                backgroundColor: Theme.of(context).primaryColor,
                                appBar: AppBar(
                                  centerTitle: true,
                                  title: Text(
                                    'Shows',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                                body: ShowsSc(
                                  type: 'popular',
                                ))));
                      },
                      child: Text(
                        'Explore all',
                        style: TextStyle(
                            color: Colors.red[700], fontSize: mediaQueryH / 65),
                      ),
                    ),
                  ),
                  container(mediaQueryH, mediaQueryW, trendingSh, 'show'),
                  ListTile(
                    leading: Text(
                      'Popular TV Shows',
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: mediaQueryH / 40),
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            direction: AxisDirection.left,
                            child: Scaffold(
                                backgroundColor: Theme.of(context).primaryColor,
                                appBar: AppBar(
                                  centerTitle: true,
                                  title: Text(
                                    'Shows',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                                body: ShowsSc(
                                  type: 'popular',
                                ))));
                      },
                      child: Text(
                        'Explore all',
                        style: TextStyle(
                            color: Colors.red[700], fontSize: mediaQueryH / 65),
                      ),
                    ),
                  ),
                  container(mediaQueryH, mediaQueryW, popularSh, 'show'),
                  ListTile(
                    leading: Text(
                      'Top Rated TV Shows',
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: mediaQueryH / 40),
                    ),
                    trailing: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(CustomPageRoute(
                            direction: AxisDirection.left,
                            child: Scaffold(
                                backgroundColor: Theme.of(context).primaryColor,
                                appBar: AppBar(
                                  centerTitle: true,
                                  title: Text(
                                    'Shows',
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                                body: ShowsSc(
                                  type: 'topRated',
                                ))));
                      },
                      child: Text(
                        'Explore all',
                        style: TextStyle(
                            color: Colors.red[700], fontSize: mediaQueryH / 65),
                      ),
                    ),
                  ),
                  container(mediaQueryH, mediaQueryW, topRatedSh, 'show'),
                ],
              ),
            )),
    );
  }
}
