import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieex/models/bottom_sheet.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/screens/detail_screen.dart';
import 'package:provider/provider.dart';

enum MView { trending, tRated, popular }
enum ShView { trending, tRated, popular }

class MovieShowScreen extends StatefulWidget {
  @override
  State<MovieShowScreen> createState() => _MovieShowScreenState();
}

class _MovieShowScreenState extends State<MovieShowScreen>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: TabBar(
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
        body: TabBarView(
          controller: _tabController,
          children: [MoviesSc(), ShowsSc()],
        ));
  }
}

class MoviesSc extends StatefulWidget {
  String type;

  MoviesSc({this.type});
  @override
  State<MoviesSc> createState() => _MoviesScState();
}

class _MoviesScState extends State<MoviesSc> {
  MView selectedM = MView.trending;

  var movie;
  int page = 1;

  void mView(tr, tRated, pop) {
    if (widget != null && widget.type == 'trending') {
      selectedM = MView.trending;
      setState(() {
        selectedM = MView.trending;
        movie = tr;
        Provider.of<Movies>(context, listen: false)
            .trendingMovies(page)
            .then((value) {
          if (this.mounted)
            setState(() {
              tr = Provider.of<Movies>(context, listen: false).trendList;
              movie = tr;
            });
        });
      });
    } else if (widget != null && widget.type == 'topRated') {
      setState(() {
        selectedM = MView.tRated;
        movie = tRated;
        Provider.of<Movies>(context, listen: false)
            .topRatedMovies(page)
            .then((value) {
          if (this.mounted)
            setState(() {
              tRated = Provider.of<Movies>(context, listen: false).topRatedList;
              movie = tRated;
            });
        });
      });
    } else if (widget != null && widget.type == 'popular') {
      selectedM = MView.popular;
      setState(() {
        selectedM = MView.popular;
        movie = pop;
        Provider.of<Movies>(context, listen: false)
            .popularMovies(page)
            .then((value) {
          if (this.mounted)
            setState(() {
              pop = Provider.of<Movies>(context, listen: false).popList;
              movie = pop;
            });
        });
      });
    }
  }

  Widget listItem(i, bottomSheet, mediaQueryH, mediaQueryW, trending) {
    var value = movie == null ? trending[i] : movie[i];
    return GestureDetector(
      onTap: () {
        bottomSheet.bottomSheet(
            context,
            mediaQueryH,
            mediaQueryW,
            trending,
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
            value.voteCount);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: mediaQueryH / 70.0, horizontal: mediaQueryW / 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Theme.of(context).cardColor,
            height: mediaQueryH / 4,
            width: double.infinity,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(30)),
                  child: Container(
                    width: mediaQueryW / 2.7,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                            fit: BoxFit.fitHeight)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: mediaQueryW / 50.0,
                      top: mediaQueryH / 100,
                      bottom: mediaQueryH / 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: mediaQueryW / 2,
                            child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 0.9),
                              child: Text(
                                value.title,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaQueryH / 150,
                          ),
                          MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 0.8),
                            child: Text(
                              DateFormat('yyyy')
                                  .format(DateTime.parse(value.releaseDate)),
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
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
                                color: Colors.yellow[700],
                              ),
                              MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 0.8),
                                child: Text(
                                    ' ${value.voteAverage.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mediaQueryH / 150,
                          ),
                          MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 0.75),
                            child: SizedBox(
                              width: mediaQueryW / 2,
                              child: Text(value.overview,
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Theme.of(context).hoverColor,
                          height: mediaQueryH / 33,
                          width: mediaQueryW / 8,
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Theme.of(context).hintColor,
                            size: mediaQueryH / 60,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var trending = Provider.of<Movies>(context).trendList;
    var popular = Provider.of<Movies>(context).popList;
    var topRated = Provider.of<Movies>(context).topRatedList;
    mView(trending, topRated, popular);
    MBottomSheet bottomSheet = MBottomSheet();
    return ListView.builder(
        itemCount: movie == null ? trending.length : movie.length,
        itemBuilder: (ctx, i) {
          return i == 0
              ? Column(
                  children: [
                    widget.type != null
                        ? SizedBox()
                        : MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 0.9),
                            child: Container(
                              height: mediaQueryH / 10,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaQueryW / 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedM = MView.trending;
                                          movie = trending;
                                          page = 1;
                                          Provider.of<Movies>(context,
                                                  listen: false)
                                              .trendingMovies(page)
                                              .then((value) {
                                            setState(() {
                                              trending = Provider.of<Movies>(
                                                      context,
                                                      listen: false)
                                                  .trendList;
                                              movie = trending;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: mediaQueryH / 20,
                                        width: mediaQueryW / 3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: selectedM == MView.trending
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .primaryColor),
                                        child: Center(
                                            child: Text('Trending',
                                                style: TextStyle(
                                                    color: selectedM ==
                                                            MView.trending
                                                        ? Colors.white
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedM = MView.tRated;
                                          movie = topRated;
                                          page = 1;
                                          Provider.of<Movies>(context,
                                                  listen: false)
                                              .topRatedMovies(page)
                                              .then((value) {
                                            setState(() {
                                              topRated = Provider.of<Movies>(
                                                      context,
                                                      listen: false)
                                                  .topRatedList;
                                              movie = topRated;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: mediaQueryH / 20,
                                        width: mediaQueryW / 3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: selectedM == MView.tRated
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .primaryColor),
                                        child: Center(
                                            child: Text('Top Rated',
                                                style: TextStyle(
                                                    color: selectedM ==
                                                            MView.tRated
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedM = MView.popular;
                                          movie = popular;
                                          page = 1;
                                          Provider.of<Movies>(context,
                                                  listen: false)
                                              .popularMovies(page)
                                              .then((value) {
                                            setState(() {
                                              popular = Provider.of<Movies>(
                                                      context,
                                                      listen: false)
                                                  .popList;
                                              movie = popular;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: mediaQueryH / 20,
                                        width: mediaQueryW / 3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: selectedM == MView.popular
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .primaryColor),
                                        child: Center(
                                            child: Text('Popular',
                                                style: TextStyle(
                                                    color: selectedM ==
                                                            MView.popular
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                      child: Container(
                        height: mediaQueryH / 15,
                        child: Padding(
                          padding: EdgeInsets.only(right: mediaQueryW / 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(page.toString() + ' 0f 1000 ',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  )),
                              SizedBox(
                                width: mediaQueryW / 50,
                              ),
                              if (page > 1)
                                GestureDetector(
                                  onTap: () {
                                    if (selectedM == MView.trending) {
                                      setState(() {
                                        page--;
                                        Provider.of<Movies>(context,
                                                listen: false)
                                            .trendingMovies(page)
                                            .then((value) {
                                          setState(() {
                                            trending = Provider.of<Movies>(
                                                    context,
                                                    listen: false)
                                                .trendList;
                                            movie = trending;
                                          });
                                        });
                                      });
                                    } else if (selectedM == MView.tRated) {
                                      setState(() {
                                        page--;
                                        Provider.of<Movies>(context,
                                                listen: false)
                                            .topRatedMovies(page)
                                            .then((value) {
                                          setState(() {
                                            topRated = Provider.of<Movies>(
                                                    context,
                                                    listen: false)
                                                .topRatedList;
                                            movie = topRated;
                                          });
                                        });
                                      });
                                    } else if (selectedM == MView.popular) {
                                      setState(() {
                                        page--;
                                        Provider.of<Movies>(context,
                                                listen: false)
                                            .popularMovies(page)
                                            .then((value) {
                                          setState(() {
                                            popular = Provider.of<Movies>(
                                                    context,
                                                    listen: false)
                                                .popList;
                                            movie = popular;
                                          });
                                        });
                                      });
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).hoverColor,
                                    child: Icon(Icons.arrow_back_ios_sharp,
                                        color: Theme.of(context).hintColor,
                                        size: mediaQueryH / 50),
                                  ),
                                ),
                              SizedBox(
                                width: mediaQueryW / 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (selectedM == MView.trending) {
                                    setState(() {
                                      page++;
                                      Provider.of<Movies>(context,
                                              listen: false)
                                          .trendingMovies(page)
                                          .then((value) {
                                        setState(() {
                                          trending = Provider.of<Movies>(
                                                  context,
                                                  listen: false)
                                              .trendList;
                                          movie = trending;
                                        });
                                      });
                                    });
                                  } else if (selectedM == MView.tRated) {
                                    setState(() {
                                      page++;
                                      Provider.of<Movies>(context,
                                              listen: false)
                                          .topRatedMovies(page)
                                          .then((value) {
                                        setState(() {
                                          topRated = Provider.of<Movies>(
                                                  context,
                                                  listen: false)
                                              .topRatedList;
                                          movie = topRated;
                                        });
                                      });
                                    });
                                  } else if (selectedM == MView.popular) {
                                    setState(() {
                                      page++;
                                      Provider.of<Movies>(context,
                                              listen: false)
                                          .popularMovies(page)
                                          .then((value) {
                                        setState(() {
                                          popular = Provider.of<Movies>(context,
                                                  listen: false)
                                              .popList;
                                          movie = popular;
                                        });
                                      });
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context).hoverColor,
                                  child: Icon(Icons.arrow_forward_ios_sharp,
                                      color: Theme.of(context).hintColor,
                                      size: mediaQueryH / 50),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : listItem(
                  i - 1, bottomSheet, mediaQueryH, mediaQueryW, trending);
        });
  }
}

class ShowsSc extends StatefulWidget {
  String type;

  ShowsSc({this.type});
  @override
  State<ShowsSc> createState() => _ShowsScState();
}

class _ShowsScState extends State<ShowsSc> {
  ShView selectedSh = ShView.trending;

  var show;
  int page = 1;

  void shView(tr, tRated, pop) {
    if (widget != null && widget.type == 'trending') {
      selectedSh = ShView.trending;
      setState(() {
        selectedSh = ShView.trending;
        show = tr;
        Provider.of<Shows>(context, listen: false)
            .trendingShows(page)
            .then((value) {
          if (this.mounted)
            setState(() {
              tr = Provider.of<Shows>(context, listen: false).trendList;
              show = tr;
            });
        });
      });
    } else if (widget != null && widget.type == 'topRated') {
      setState(() {
        selectedSh = ShView.tRated;
        show = tRated;
        Provider.of<Shows>(context, listen: false)
            .topRatedShows(page)
            .then((value) {
          if (this.mounted)
            setState(() {
              tRated = Provider.of<Shows>(context, listen: false).topRatedList;
              show = tRated;
            });
        });
      });
    } else if (widget != null && widget.type == 'popular') {
      selectedSh = ShView.popular;
      setState(() {
        selectedSh = ShView.popular;
        show = pop;
        Provider.of<Shows>(context, listen: false)
            .popularShows(page)
            .then((value) {
          if (this.mounted)
            setState(() {
              pop = Provider.of<Shows>(context, listen: false).popList;
              show = pop;
            });
        });
      });
    }
  }

  Widget listItem(i, bottomSheet, mediaQueryH, mediaQueryW, trending) {
    var value = show == null ? trending[i] : show[i];
    return GestureDetector(
      onTap: () {
        bottomSheet.bottomSheet(
            context,
            mediaQueryH,
            mediaQueryW,
            trending,
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
            value.voteCount);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: mediaQueryH / 70.0, horizontal: mediaQueryW / 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Theme.of(context).cardColor,
            height: mediaQueryH / 4,
            width: double.infinity,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(30)),
                  child: Container(
                    width: mediaQueryW / 2.7,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                            fit: BoxFit.fitHeight)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: mediaQueryW / 50.0,
                      top: mediaQueryH / 100,
                      bottom: mediaQueryH / 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: mediaQueryW / 2,
                            child: MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 0.9),
                              child: Text(
                                value.title,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mediaQueryH / 150,
                          ),
                          MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 0.8),
                            child: Text(
                              DateFormat('yyyy')
                                  .format(DateTime.parse(value.releaseDate)),
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
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
                                color: Colors.yellow[700],
                              ),
                              MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(textScaleFactor: 0.8),
                                child: Text(
                                    ' ${value.voteAverage.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mediaQueryH / 150,
                          ),
                          MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 0.75),
                            child: SizedBox(
                              width: mediaQueryW / 2,
                              child: Text(value.overview,
                                  textAlign: TextAlign.justify,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Theme.of(context).hoverColor,
                          height: mediaQueryH / 33,
                          width: mediaQueryW / 8,
                          child: Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: Theme.of(context).hintColor,
                            size: mediaQueryH / 60,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var trending = Provider.of<Shows>(context).trendList;
    var popular = Provider.of<Shows>(context).popList;
    var topRated = Provider.of<Shows>(context).topRatedList;
    shView(trending, topRated, popular);
    MBottomSheet bottomSheet = MBottomSheet();
    return ListView.builder(
        itemCount: show == null ? trending.length : show.length,
        itemBuilder: (ctx, i) {
          return i == 0
              ? Column(
                  children: [
                    widget.type != null
                        ? SizedBox()
                        : MediaQuery(
                            data: MediaQuery.of(context)
                                .copyWith(textScaleFactor: 0.9),
                            child: Container(
                              height: mediaQueryH / 10,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaQueryW / 40.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSh = ShView.trending;
                                          show = trending;
                                          page = 1;
                                          Provider.of<Shows>(context,
                                                  listen: false)
                                              .trendingShows(page)
                                              .then((value) {
                                            setState(() {
                                              trending = Provider.of<Shows>(
                                                      context,
                                                      listen: false)
                                                  .trendList;
                                              show = trending;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: mediaQueryH / 20,
                                        width: mediaQueryW / 3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: selectedSh == ShView.trending
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .primaryColor),
                                        child: Center(
                                            child: Text('Trending',
                                                style: TextStyle(
                                                    color: selectedSh ==
                                                            ShView.trending
                                                        ? Colors.white
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSh = ShView.tRated;
                                          show = topRated;
                                          page = 1;
                                          Provider.of<Shows>(context,
                                                  listen: false)
                                              .topRatedShows(page)
                                              .then((value) {
                                            setState(() {
                                              topRated = Provider.of<Shows>(
                                                      context,
                                                      listen: false)
                                                  .topRatedList;
                                              show = topRated;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: mediaQueryH / 20,
                                        width: mediaQueryW / 3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: selectedSh == ShView.tRated
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .primaryColor),
                                        child: Center(
                                            child: Text('Top Rated',
                                                style: TextStyle(
                                                    color: selectedSh ==
                                                            ShView.tRated
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedSh = ShView.popular;
                                          show = popular;
                                          page = 1;
                                          Provider.of<Shows>(context,
                                                  listen: false)
                                              .popularShows(page)
                                              .then((value) {
                                            setState(() {
                                              popular = Provider.of<Shows>(
                                                      context,
                                                      listen: false)
                                                  .popList;
                                              show = popular;
                                            });
                                          });
                                        });
                                      },
                                      child: Container(
                                        height: mediaQueryH / 20,
                                        width: mediaQueryW / 3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.red, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: selectedSh == ShView.popular
                                                ? Colors.red
                                                : Theme.of(context)
                                                    .primaryColor),
                                        child: Center(
                                            child: Text('Popular',
                                                style: TextStyle(
                                                    color: selectedSh ==
                                                            ShView.popular
                                                        ? Theme.of(context)
                                                            .hintColor
                                                        : Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                      child: Container(
                        height: mediaQueryH / 15,
                        child: Padding(
                          padding: EdgeInsets.only(right: mediaQueryW / 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(page.toString() + ' 0f 1000 ',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  )),
                              SizedBox(
                                width: mediaQueryW / 50,
                              ),
                              if (page > 1)
                                GestureDetector(
                                  onTap: () {
                                    if (selectedSh == ShView.trending) {
                                      setState(() {
                                        page--;
                                        Provider.of<Shows>(context,
                                                listen: false)
                                            .trendingShows(page)
                                            .then((value) {
                                          setState(() {
                                            trending = Provider.of<Shows>(
                                                    context,
                                                    listen: false)
                                                .trendList;
                                            show = trending;
                                          });
                                        });
                                      });
                                    } else if (selectedSh == ShView.tRated) {
                                      setState(() {
                                        page--;
                                        Provider.of<Shows>(context,
                                                listen: false)
                                            .topRatedShows(page)
                                            .then((value) {
                                          setState(() {
                                            topRated = Provider.of<Shows>(
                                                    context,
                                                    listen: false)
                                                .topRatedList;
                                            show = topRated;
                                          });
                                        });
                                      });
                                    } else if (selectedSh == ShView.popular) {
                                      setState(() {
                                        page--;
                                        Provider.of<Shows>(context,
                                                listen: false)
                                            .popularShows(page)
                                            .then((value) {
                                          setState(() {
                                            popular = Provider.of<Shows>(
                                                    context,
                                                    listen: false)
                                                .popList;
                                            show = popular;
                                          });
                                        });
                                      });
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).hoverColor,
                                    child: Icon(Icons.arrow_back_ios_sharp,
                                        color: Theme.of(context).hintColor,
                                        size: mediaQueryH / 50),
                                  ),
                                ),
                              SizedBox(
                                width: mediaQueryW / 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (selectedSh == ShView.trending) {
                                    setState(() {
                                      page++;
                                      Provider.of<Shows>(context, listen: false)
                                          .trendingShows(page)
                                          .then((value) {
                                        setState(() {
                                          trending = Provider.of<Shows>(context,
                                                  listen: false)
                                              .trendList;
                                          show = trending;
                                        });
                                      });
                                    });
                                  } else if (selectedSh == ShView.tRated) {
                                    setState(() {
                                      page++;
                                      Provider.of<Shows>(context, listen: false)
                                          .topRatedShows(page)
                                          .then((value) {
                                        setState(() {
                                          topRated = Provider.of<Shows>(context,
                                                  listen: false)
                                              .topRatedList;
                                          show = topRated;
                                        });
                                      });
                                    });
                                  } else if (selectedSh == ShView.popular) {
                                    setState(() {
                                      page++;
                                      Provider.of<Shows>(context, listen: false)
                                          .popularShows(page)
                                          .then((value) {
                                        setState(() {
                                          popular = Provider.of<Shows>(context,
                                                  listen: false)
                                              .popList;
                                          show = popular;
                                        });
                                      });
                                    });
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context).hoverColor,
                                  child: Icon(Icons.arrow_forward_ios_sharp,
                                      color: Theme.of(context).hintColor,
                                      size: mediaQueryH / 50),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : listItem(i, bottomSheet, mediaQueryH, mediaQueryW, trending);
        });
  }
}
