import 'package:flutter/material.dart';
import 'package:movieex/models/custom_page_route.dart';
import 'package:movieex/providers/movies.dart';
import 'package:movieex/providers/shows.dart';
import 'package:movieex/widgets/trailer.dart';
import 'package:provider/provider.dart';

class TrailerScreen extends StatefulWidget {
  var type;
  TrailerScreen(this.type);
  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.type);
    var trailer = widget.type == 'movie'
        ? Provider.of<Movies>(context).trailers
        : Provider.of<Shows>(context).trailers;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            title: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
                child: Text('Trailers')),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: trailer.isEmpty
                ? Center(
                    child: Text(
                      'No trailers',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: trailer.length,
                    itemBuilder: (ctx, i) {
                      var value = trailer[i];
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: Trailer(
                                    vKey: value.key,
                                  )));
                            },
                            leading: Text(
                              '${i + 1}',
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(
                              value.name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    }),
          )),
    );
  }
}
