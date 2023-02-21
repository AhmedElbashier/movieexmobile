import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/screens/detail_screen.dart';
import 'package:movieex/screens/movies_shows_screen.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  var id;
  List list;
  var type;
  var k;
  MoviesScreen({this.id, this.list, this.type, this.k});
  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
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

  Future<void> listM() async {
    for (int i = 1; i <= 10; i++) {
      await Provider.of<Movies>(context, listen: false).trendingMovies(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryH = MediaQuery.of(context).size.height;
    var mediaQueryW = MediaQuery.of(context).size.width;
    var trending = Provider.of<Movies>(context).trendList;
    var popular = Provider.of<Movies>(context).popList;
    var topRated = Provider.of<Movies>(context).topRatedList;
    mView(trending, topRated, popular);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.grey),
          centerTitle: true,
          title: Text(widget.type != 'movie' && widget.type != 'show'
              ? widget.type
              : '${widget.type}s')),
      body: Padding(
        padding: EdgeInsets.only(
          left: mediaQueryW / 30.0,
          right: mediaQueryW / 30.0,
          top: mediaQueryH / 40,
        ),
        child: widget.list.isEmpty
            ? Center(
                child: Text(
                  'Nothing yet!',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.5,
                  crossAxisSpacing: mediaQueryH / 100,
                  mainAxisSpacing: mediaQueryH / 100,
                ),
                itemCount: widget.type != 'movie' && widget.type != 'show'
                    ? widget.list.length
                    : widget.list.length,
                itemBuilder: (ctx, i) {
                  var value = widget.type != 'movie' && widget.type != 'show'
                      ? widget.list[i]
                      : widget.list[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return DeatailScreen(
                          id: value.id,
                          backDropPath: value.backDropPath,
                          lang: value.lang,
                          mediaType: widget.k == 'movie' ? 'movie' : 'show',
                          genreIds: value.genreIds,
                          title: value.title,
                          overview: value.overview,
                          popularity: value.popularity,
                          posterPath: value.posterPath,
                          releaseDate: value.releaseDate,
                          voteAverage: value.voteAverage,
                          voteCount: value.voteCount,
                          object: value,
                        );
                      }));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(value.posterPath == null
                                    ? ''
                                    : 'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                                fit: BoxFit.fitHeight)),
                        alignment: Alignment.bottomCenter,
                        child: MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 0.8),
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
                                                      value.releaseDate.isEmpty
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
    );
  }
}
