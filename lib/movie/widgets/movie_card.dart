import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wfh_companion/movie/data/movie.dart';

class MovieCard extends StatelessWidget {
  static const Color _MAIN_COLOR = const Color(0xff3C3261);
  static const _IMAGE_URL_BASE = 'https://image.tmdb.org/t/p/w500/';

  final Movie movie;
  MovieCard({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.all(16.0),
                    child: new Container(
                      width: 70.0,
                      height: 70.0,
                    ),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      color: Colors.grey,
                      image: new DecorationImage(
                          image: new NetworkImage(_IMAGE_URL_BASE + movie.posterPath),
                          fit: BoxFit.cover),
                      boxShadow: [
                        new BoxShadow(
                            color: _MAIN_COLOR,
                            blurRadius: 5.0,
                            offset: new Offset(2.0, 5.0))
                      ],
                    ),
                  ),
                  new Text(
                    "Vote: ${movie.avgVote}",
                    style: new TextStyle(
                        color: const Color(0xff8785A4),
                        fontFamily: 'Arvo'
                    )
                  )
                ],
              ),
            ),
            new Expanded(
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: new Column(children: [
                    new Text(
                      movie.title,
                      style: new TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Arvo',
                          fontWeight: FontWeight.bold,
                          color: _MAIN_COLOR),
                    ),
                    new Padding(padding: const EdgeInsets.all(2.0)),
                    new Text(
                      movie.overview,
                      maxLines: 3,
                      style: new TextStyle(
                          color: const Color(0xff8785A4),
                          fontFamily: 'Arvo'
                      ),)
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,),
                )
            ),
          ],
        ),
        new Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}
