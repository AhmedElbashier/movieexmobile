import 'package:flutter/material.dart';
import 'package:movieex/screens/detail_screen.dart';

class MBottomSheet {
  Future<dynamic> bottomSheet(
      BuildContext context,
      mQueryH,
      mQueryW,
      list,
      id,
      backDropPath,
      lang,
      mediaType,
      genreIds,
      title,
      overview,
      popularity,
      posterPath,
      releaseDate,
      voteAverage,
      voteCount,
      value) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        builder: (ctx) {
          return Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mQueryH / 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: mQueryH / 80),
                    child: SizedBox(
                      height: mQueryH / 5.5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return DeatailScreen(
                              id: id,
                              backDropPath: backDropPath,
                              lang: lang,
                              mediaType: mediaType,
                              genreIds: genreIds,
                              title: title,
                              overview: overview,
                              popularity: popularity,
                              posterPath: posterPath,
                              releaseDate: releaseDate,
                              voteAverage: voteAverage,
                              voteCount: voteCount,
                              object: value,
                            );
                          }));
                        },
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: mQueryW / 4,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500$posterPath'),
                                          fit: BoxFit.fitHeight)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: mQueryW / 50, top: mQueryH / 70),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: mQueryW / 1.6,
                                      child: MediaQuery(
                                        data: MediaQuery.of(context)
                                            .copyWith(textScaleFactor: 0.9),
                                        child: Text(
                                          title,
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mQueryH / 100,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow[700],
                                          size: mQueryH / 40,
                                        ),
                                        MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(textScaleFactor: 0.8),
                                            child: Text(
                                              ' ${voteAverage.toStringAsFixed(1)}',
                                              style: TextStyle(
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mQueryH / 100,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: mQueryW / 100),
                                      child: SizedBox(
                                        width: mQueryW / 1.7,
                                        child: MediaQuery(
                                          data: MediaQuery.of(context)
                                              .copyWith(textScaleFactor: 0.8),
                                          child: Text(
                                            overview,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
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
                  ),
                  MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.5),
                      child: Text(
                        'Trending',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      )),
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, i) {
                            var value = list[i];
                            if (id == value.id) {
                              return SizedBox();
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return DeatailScreen(
                                    id: value.id,
                                    backDropPath: value.backDropPath,
                                    lang: value.lang,
                                    mediaType: mediaType,
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
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mQueryW / 50,
                                    vertical: mQueryH / 80),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: mQueryW / 2.2,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${value.posterPath}'),
                                            fit: BoxFit.fitWidth)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: mQueryH / 70,
                                              left: mQueryW / 30),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.9),
                                              height: mQueryH / 30,
                                              width: mQueryW / 7,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow[700],
                                                    size: mQueryH / 45,
                                                  ),
                                                  Text(
                                                    ' ${value.voteAverage.toStringAsFixed(1)}',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.black.withOpacity(0.8),
                                          height: mQueryH / 21,
                                          width: double.infinity,
                                          child: Center(
                                              child: Text(
                                            value.title,
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
