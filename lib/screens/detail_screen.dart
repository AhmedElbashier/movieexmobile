import 'dart:convert';
import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:movieex/models/custom_page_route.dart';
import 'package:movieex/providers/cart.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/screens/actor_screen.dart';
import 'package:movieex/screens/movies_screen.dart';
import 'package:movieex/screens/nav_screens.dart';
import 'package:movieex/screens/trailers_screen.dart';
import 'package:movieex/widgets/badge.dart';
import 'package:movieex/widgets/trailer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeatailScreen extends StatefulWidget {
  int id;
  String posterPath;
  String overview;
  String releaseDate;
  String lang;
  String title;
  List genreIds;
  String mediaType;
  String backDropPath;
  var popularity;
  var voteCount;
  var voteAverage;
  var object;

  DeatailScreen(
      {this.id,
      this.backDropPath,
      this.genreIds,
      this.lang,
      this.mediaType,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.voteAverage,
      this.voteCount,
      this.object});
  @override
  State<DeatailScreen> createState() => _DeatailScreenState();
}

class _DeatailScreenState extends State<DeatailScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  var credits;
  var images;
  var similarMovies;
  var shImages;
  var similarShows;
  var shCredits;
  var detailMovie;
  var detailShow;

  Widget shimmer(mediaQueryH, mediaQueryW) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mediaQueryW / 30, vertical: mediaQueryH / 50),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: mediaQueryH / 30,
                  width: mediaQueryW / 1.5,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: mediaQueryH / 50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: mediaQueryH / 80,
                  width: mediaQueryW / 2,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: mediaQueryH / 50),
              child: SizedBox(
                height: mediaQueryH / 17,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3, vertical: mediaQueryH / 80),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            color: Theme.of(context).cardColor,
                            width: mediaQueryW / 7,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: mediaQueryH / 16,
                    width: mediaQueryW / 1.7,
                    color: Theme.of(context).cardColor,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                )
              ],
            ),
            MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
              child: Padding(
                padding: EdgeInsets.only(top: mediaQueryH / 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: mediaQueryH / 80,
                    width: mediaQueryW / 1.2,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Movies>(context).getMovieCredits(widget.id).then((value) {
        Provider.of<Movies>(context, listen: false)
            .getMovieDetails(widget.id)
            .then((value) {
          Provider.of<Shows>(context, listen: false)
              .getShowsDetails(widget.id)
              .then((value) {
            Provider.of<Movies>(context, listen: false)
                .getSimilerMovies(widget.id)
                .then((value) {
              Provider.of<Movies>(context, listen: false)
                  .geTrailer(widget.id)
                  .then((value) {
                Provider.of<Movies>(context, listen: false)
                    .getMovieImages(widget.id)
                    .then((value) {
                  Provider.of<Shows>(context, listen: false)
                      .getShowCredits(widget.id)
                      .then((value) {
                    Provider.of<Shows>(context, listen: false)
                        .geTrailer(widget.id)
                        .then((value) {
                      Provider.of<Shows>(context, listen: false)
                          .getSimilerShows(widget.id)
                          .then((value) {
                        Provider.of<Shows>(context, listen: false)
                            .getShowImages(widget.id)
                            .then((value) {
                          credits = Provider.of<Movies>(context, listen: false)
                              .mCredits;
                          images = Provider.of<Movies>(context, listen: false)
                              .mImages;
                          similarMovies =
                              Provider.of<Movies>(context, listen: false)
                                  .similarMList;
                          detailMovie =
                              Provider.of<Movies>(context, listen: false)
                                  .detailsMovies;
                          detailShow =
                              Provider.of<Shows>(context, listen: false)
                                  .detailsShows;
                          shCredits = Provider.of<Shows>(context, listen: false)
                              .shCredits;
                          shImages = Provider.of<Shows>(context, listen: false)
                              .shImages;
                          similarShows =
                              Provider.of<Shows>(context, listen: false)
                                  .similarShList;
                          getGenres();
                          if (this.mounted)
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
        });
      });
    }
    _isInit = false;
  }

  void showTopSnackbar(context) => Flushbar(
        icon: Icon(Icons.check,
            size: MediaQuery.of(context).size.height / 50,
            color: Theme.of(context).hintColor),
        shouldIconPulse: false,
        message: 'added to cart',
        duration: Duration(seconds: 1),
        borderRadius: 15,
        margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
        backgroundColor: Colors.red[700],
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);

  List<String> genres = [];
  void getGenres() {
    if (widget.mediaType == 'movie') {
      for (int i = 0; i < detailMovie.genreIds.length; i++) {
        genres.add(detailMovie.genreIds[i]['name']);
      }
      print('movie $genres');
    } else {
      for (int i = 0; i < detailShow.genreIds.length; i++) {
        genres.add(detailShow.genreIds[i]['name']);
      }
      print('show ${widget.id}');
      print('show ${widget.title}');
      print('show $genres');
    }
  }

  void saveList() async {
    SharedPreferences data = await SharedPreferences.getInstance();
    var encodedList = json.encode(favs);
    data.setString('favs', encodedList);
    print(favs.toString());
  }

  List favs = [];
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var cart = Provider.of<Cart>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              expandedHeight: mediaQueryH / 1.6,
              floating: false,
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.grey[800],
                      child: Icon(
                        Icons.clear,
                        color: Colors.grey[100],
                      )),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: mediaQueryW / 30),
                  child: Consumer<Cart>(
                    builder: (_, cart, ch) => Badge(
                      child: ch,
                      value: cart.itemCount.toString(),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: CircleAvatar(
                          radius: mediaQueryH / 35,
                          backgroundColor: Colors.transparent,
                          child: IconButton(
                            icon: SizedBox(
                                height: mediaQueryH / 35,
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.grey[900],
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
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                  background: widget.posterPath == null
                      ? Container(
                          color: Colors.grey[900],
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${widget.posterPath}'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${widget.posterPath}',
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        )),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQueryW / 30, vertical: mediaQueryH / 50),
                child: _isLoading
                    ? shimmer(mediaQueryH, mediaQueryW)
                    : MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 1.5),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: mediaQueryH / 50),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.voteAverage.toStringAsFixed(1)} ',
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.grey[600],
                                        size: mediaQueryH / 45,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: mediaQueryW / 40),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[600],
                                      radius: 2,
                                    ),
                                  ),
                                  Text(
                                    widget.mediaType == 'movie'
                                        ? '${detailMovie.runtime.toString()} m'
                                        : '${detailShow.seasonNum.toString()} s',
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: mediaQueryW / 40),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[600],
                                      radius: 2,
                                    ),
                                  ),
                                  widget.mediaType == 'movie'
                                      ? SizedBox()
                                      : Text(
                                          '${detailShow.episodeNum.toString()} ep',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.bold),
                                        ),
                                  widget.releaseDate == null ||
                                          widget.releaseDate.isEmpty
                                      ? SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: mediaQueryW / 40),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[600],
                                            radius: 2,
                                          ),
                                        ),
                                  widget.releaseDate == null ||
                                          widget.releaseDate.isEmpty
                                      ? SizedBox()
                                      : Text(
                                          DateFormat('yyyy').format(
                                              DateTime.parse(
                                                  widget.releaseDate)),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: mediaQueryH / 50),
                              child: SizedBox(
                                height: mediaQueryH / 17,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: genres.length,
                                    itemBuilder: (ctx, i) {
                                      var value = genres[i];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3,
                                            vertical: mediaQueryH / 80),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            color: Colors.blueGrey[500],
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: mediaQueryW / 50),
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                    height: mediaQueryH / 16,
                                    width: mediaQueryW / 1.7,
                                    child: RaisedButton(
                                        color: Colors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.play_arrow,
                                                color: Colors.white),
                                            MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      textScaleFactor: 1.1),
                                              child: Text(
                                                '  Watch trailer',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              CustomPageRoute(
                                                  direction: AxisDirection.left,
                                                  child: TrailerScreen(
                                                      widget.mediaType)));
                                        }),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      cart.addItem(
                                          widget.id.toString(),
                                          100,
                                          widget.title,
                                          widget.posterPath,
                                          widget.voteAverage,
                                          widget.releaseDate);
                                      showTopSnackbar(context);
                                    },
                                    icon: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.red[800],
                                      size: mediaQueryH / 25,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        fav = !fav;
                                        if (fav == true) {
                                          print(
                                              '${widget.object.toString()} widget.object');
                                          favs.add(widget.object);
                                          print(favs);
                                        } else {
                                          favs.remove(widget.object);
                                        }
                                      });
                                    },
                                    icon: fav == true
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red[800],
                                            size: mediaQueryH / 25,
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            color: Colors.red[800],
                                            size: mediaQueryH / 25,
                                          )),
                              ],
                            ),
                            MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 0.9),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: mediaQueryH / 20.0),
                                child: SizedBox(
                                  child: Text(
                                    widget.overview,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            credits.isEmpty || shCredits.isEmpty
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQueryH / 50),
                                    child: SizedBox(
                                      height: mediaQueryH / 5,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: widget.mediaType == 'movie'
                                              ? credits.length
                                              : shCredits.length,
                                          itemBuilder: (ctx, i) {
                                            var value =
                                                widget.mediaType == 'movie'
                                                    ? credits[i]
                                                    : shCredits[i];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    CustomPageRoute(
                                                        direction:
                                                            AxisDirection.up,
                                                        child: ActorScreen(
                                                            id: value.id)));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        mediaQueryW / 30,
                                                    vertical:
                                                        0), //mediaQueryH / 80),
                                                child: Column(
                                                  children: [
                                                    value.profilePath == null
                                                        ? CircleAvatar(
                                                            radius:
                                                                mediaQueryW / 7,
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[800],
                                                          )
                                                        : CircleAvatar(
                                                            radius:
                                                                mediaQueryW / 7,
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[800],
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    'https://image.tmdb.org/t/p/w500${value.profilePath}'),
                                                          ),
                                                    SizedBox(
                                                      height: mediaQueryH / 80,
                                                    ),
                                                    MediaQuery(
                                                      data: MediaQuery.of(
                                                              context)
                                                          .copyWith(
                                                              textScaleFactor:
                                                                  0.9),
                                                      child: Text(
                                                        value.name,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                      ),
                                                    ),
                                                    MediaQuery(
                                                      data: MediaQuery.of(
                                                              context)
                                                          .copyWith(
                                                              textScaleFactor:
                                                                  0.7),
                                                      child: Text(
                                                        value.character,
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                            images.isEmpty || shImages.isEmpty
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQueryH / 50),
                                    child: images.length == 0
                                        ? SizedBox()
                                        : SizedBox(
                                            height: mediaQueryH / 5,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    widget.mediaType == 'movie'
                                                        ? images.length
                                                        : shImages.length,
                                                itemBuilder: (ctx, i) {
                                                  var value =
                                                      widget.mediaType ==
                                                              'movie'
                                                          ? images[i]
                                                          : shImages[i];
                                                  return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  mediaQueryW /
                                                                      30,
                                                              vertical: 0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Container(
                                                          height:
                                                              mediaQueryH / 7,
                                                          width:
                                                              mediaQueryW / 1.4,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                      'https://image.tmdb.org/t/p/w500${value.filePath}'),
                                                                  fit: BoxFit
                                                                      .fitWidth)),
                                                        ),
                                                      ));
                                                }),
                                          ),
                                  ),
                            widget.mediaType == null
                                ? SizedBox()
                                : ListTile(
                                    leading: MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(textScaleFactor: 1.45),
                                      child: Text(
                                        widget.mediaType == 'movie'
                                            ? 'Similer Movies'
                                            : 'Similer Shows',
                                        style: TextStyle(
                                            color: Theme.of(context).hintColor),
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            CustomPageRoute(
                                                direction: AxisDirection.up,
                                                child: MoviesScreen()));
                                      },
                                      child: MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CustomPageRoute(
                                                    direction:
                                                        AxisDirection.left,
                                                    child: MoviesScreen(
                                                      type: widget.mediaType,
                                                      list: widget.mediaType ==
                                                              'movie'
                                                          ? similarMovies
                                                          : similarShows,
                                                    )));
                                          },
                                          child: Card(
                                            elevation: 0,
                                            color: Colors.transparent,
                                            child: Text(
                                              'See all ',
                                              style: TextStyle(
                                                  color: Colors.red[700]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            widget.mediaType == null
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQueryH / 50),
                                    child: SizedBox(
                                      height: mediaQueryH / 3,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 5,
                                          itemBuilder: (ctx, i) {
                                            print(
                                                'mediatype ${widget.mediaType}');
                                            var value =
                                                widget.mediaType == 'movie'
                                                    ? similarMovies[i]
                                                    : similarShows[i];
                                            return GestureDetector(
                                              onTap: () {
                                                print(value.mediaType);
                                                Navigator.of(context).push(
                                                    CustomPageRoute(
                                                        direction:
                                                            AxisDirection.up,
                                                        child: DeatailScreen(
                                                          id: value.id,
                                                          backDropPath: value
                                                              .backDropPath,
                                                          lang: value.lang,
                                                          mediaType:
                                                              widget.mediaType ==
                                                                      'movie'
                                                                  ? 'movie'
                                                                  : 'show',
                                                          genreIds:
                                                              value.genreIds,
                                                          title: value.title,
                                                          overview:
                                                              value.overview,
                                                          popularity:
                                                              value.popularity,
                                                          posterPath:
                                                              value.posterPath,
                                                          releaseDate:
                                                              value.releaseDate,
                                                          voteAverage:
                                                              value.voteAverage,
                                                          voteCount:
                                                              value.voteCount,
                                                          object: value,
                                                        )));
                                              },
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          mediaQueryW / 30,
                                                      vertical: 0),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Container(
                                                            width: mediaQueryW /
                                                                2.5,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[900],
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                                                                    fit: BoxFit
                                                                        .fitWidth)),
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: ClipRRect(
                                                              child:
                                                                  BackdropFilter(
                                                                filter: ImageFilter
                                                                    .blur(
                                                                        sigmaX:
                                                                            10.0,
                                                                        sigmaY:
                                                                            10.0),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      mediaQueryH /
                                                                          35,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            mediaQueryW /
                                                                                50),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        widget.releaseDate == null ||
                                                                                value.releaseDate.isEmpty
                                                                            ? SizedBox()
                                                                            : Text(
                                                                                DateFormat('yyyy').format(DateTime.parse(value.releaseDate)),
                                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: mediaQueryH / 65),
                                                                              ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              '${value.voteAverage.toStringAsFixed(1)} ',
                                                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: mediaQueryH / 65),
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
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            mediaQueryH / 50,
                                                      ),
                                                      MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
                                                            .copyWith(
                                                                textScaleFactor:
                                                                    0.9),
                                                        child: Text(
                                                          value.title,
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
            ]))
          ],
        ));
  }
}
