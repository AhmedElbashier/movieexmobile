import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:movieex/models/custom_page_route.dart';
import 'package:movieex/providers/actor._details.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/screens/detail_screen.dart';
import 'package:movieex/screens/movies_screen.dart';
import 'package:provider/provider.dart';

class ActorScreen extends StatefulWidget {
  int id;

  ActorScreen({this.id});

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ActorDetails>(context)
          .getActorDetails(widget.id)
          .then((value) {
        Provider.of<Movies>(context, listen: false)
            .getActorMovies(widget.id)
            .then((value) {
          Provider.of<Shows>(context, listen: false)
              .getActorShows(widget.id)
              .then((value) {
            actor =
                Provider.of<ActorDetails>(context, listen: false).actorDetails;
            actorMovies =
                Provider.of<Movies>(context, listen: false).actorMovies;
            actorShows = Provider.of<Shows>(context, listen: false).actorShows;
            if (actor.birthday != null) getAge(actor);
            if (this.mounted)
              setState(() {
                _isLoading = false;
              });
          });
        });
      });
    }
    _isInit = false;
  }

  int age;
  var actor;
  var actorMovies;
  var actorShows;

  void getAge(actor) {
    var datetimeNow = DateFormat('yyyy').format(DateTime.now());
    var actorBirth = DateFormat('yyyy').format(DateTime.parse(actor.birthday));
    age = int.parse(datetimeNow) - int.parse(actorBirth);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.black,
        body: _isLoading
            ? SpinKitDoubleBounce(
                color: Colors.red[700],
                size: 40,
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.black,
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
                              color: Colors.white,
                            )),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                        background: actor.profilePath == null
                            ? Container(
                                color: Colors.grey[900],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500${actor.profilePath}'),
                                        fit: BoxFit.fitWidth)),
                              )),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaQueryW / 30,
                          vertical: mediaQueryH / 50),
                      child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaleFactor: 1.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 1.5),
                              child: Text(
                                actor.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: mediaQueryH / 50,
                            ),
                            MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 0.9),
                              child: actor.gender == null
                                  ? SizedBox()
                                  : Text(
                                      actor.gender == 1 ? 'Female' : 'Male',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                            ),
                            MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 0.9),
                              child: actor.placeOfBirth == null ||
                                      actor.birthday == null
                                  ? SizedBox()
                                  : Text(
                                      'Born in ${DateFormat('yyyy').format(DateTime.parse(actor.birthday))} (age $age years), ${actor.placeOfBirth}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                            ),
                            MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(textScaleFactor: 0.9),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: mediaQueryH / 40.0),
                                child: SizedBox(
                                  child: actor.biography == null
                                      ? SizedBox()
                                      : Text(
                                          actor.biography,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                ),
                              ),
                            ),
                            actorMovies.isEmpty
                                ? SizedBox()
                                : ListTile(
                                    leading: MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(textScaleFactor: 1.45),
                                      child: Text(
                                        'Movies',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(CustomPageRoute(
                                                direction: AxisDirection.left,
                                                child: MoviesScreen(
                                                  type: 'movie',
                                                  list: actorMovies,
                                                )));
                                      },
                                      child: MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1.0),
                                        child: Text(
                                          'See all ',
                                          style:
                                              TextStyle(color: Colors.red[700]),
                                        ),
                                      ),
                                    ),
                                  ),
                            actorMovies.isEmpty
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQueryH / 50),
                                    child: SizedBox(
                                      height: mediaQueryH / 3,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: actorMovies.length < 5
                                              ? actorMovies.length
                                              : 5,
                                          itemBuilder: (ctx, i) {
                                            var value = actorMovies[i];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    CustomPageRoute(
                                                        direction:
                                                            AxisDirection.up,
                                                        child: DeatailScreen(
                                                          id: value.id,
                                                          backDropPath: value
                                                              .backDropPath,
                                                          lang: value.lang,
                                                          mediaType: 'movie',
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
                                                          child:
                                                              value.posterPath ==
                                                                      null
                                                                  ? Container(
                                                                      color: Colors
                                                                              .grey[
                                                                          900],
                                                                      width:
                                                                          mediaQueryW /
                                                                              2.2,
                                                                    )
                                                                  : Container(
                                                                      width:
                                                                          mediaQueryW /
                                                                              2.2,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.grey[
                                                                              900],
                                                                          image: DecorationImage(
                                                                              image: NetworkImage(value.posterPath == null ? '' : 'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                                                                              fit: BoxFit.fitWidth)),
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomCenter,
                                                                      child:
                                                                          ClipRRect(
                                                                        child:
                                                                            BackdropFilter(
                                                                          filter: ImageFilter.blur(
                                                                              sigmaX: 10.0,
                                                                              sigmaY: 10.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                mediaQueryH / 35,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: mediaQueryW / 50),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  value.releaseDate == null || value.releaseDate.isEmpty
                                                                                      ? SizedBox()
                                                                                      : Text(
                                                                                          DateFormat('yyyy').format(DateTime.parse(value.releaseDate)),
                                                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: mediaQueryH / 65),
                                                                                        ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        value.voteAverage.toStringAsFixed(1),
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            );
                                          }),
                                    ),
                                  ),
                            actorShows.isEmpty
                                ? SizedBox()
                                : ListTile(
                                    leading: MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(textScaleFactor: 1.45),
                                      child: Text(
                                        'Shows',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(CustomPageRoute(
                                                direction: AxisDirection.left,
                                                child: MoviesScreen(
                                                  type: 'show',
                                                  list: actorShows,
                                                )));
                                      },
                                      child: MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 1.0),
                                        child: Text(
                                          'See all ',
                                          style:
                                              TextStyle(color: Colors.red[700]),
                                        ),
                                      ),
                                    ),
                                  ),
                            actorShows.isEmpty
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        bottom: mediaQueryH / 50),
                                    child: SizedBox(
                                      height: mediaQueryH / 3,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: actorShows.length < 5
                                              ? actorShows.length
                                              : 5,
                                          itemBuilder: (ctx, i) {
                                            var value = actorShows[i];

                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    CustomPageRoute(
                                                        direction:
                                                            AxisDirection.up,
                                                        child: DeatailScreen(
                                                          id: value.id,
                                                          backDropPath: value
                                                              .backDropPath,
                                                          lang: value.lang,
                                                          mediaType: 'show',
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
                                                                2.2,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[900],
                                                                image: DecorationImage(
                                                                    image: NetworkImage(value.posterPath ==
                                                                            null
                                                                        ? ''
                                                                        : 'https://image.tmdb.org/t/p/w500${value.posterPath}'),
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
                                                                        Text(
                                                                          DateFormat('yyyy')
                                                                              .format(DateTime.parse(value.releaseDate)),
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: mediaQueryH / 65),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              value.voteAverage.toStringAsFixed(1),
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
                                                          value.title
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
