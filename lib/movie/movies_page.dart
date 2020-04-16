import 'package:flutter/material.dart';
import 'package:wfh_companion/movie/data/movie.dart';
import 'package:wfh_companion/movie/data/movie_fetcher.dart';

import 'package:wfh_companion/movie/widgets/movie_card.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  static final _movieCount = 10;
  final MovieFetcher _movieFetcher = new MovieFetcher();
  Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = _movieFetcher.getRandomNext(_movieCount);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add TMDB logo
    return Scaffold(
      appBar: AppBar(
        title: Text("Random movies"),
      ),
      body: FutureBuilder(
        future: _moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError || !snapshot.hasData) {
              // TODO: return something went wrong
            }
            return _movieListView(snapshot.data);
          } else {
            return Center(
                child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }

  Widget _movieListView(List<Movie> movies) {
    return Center(
        child: new RefreshIndicator(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: movies.length,
              itemBuilder: (context, index) =>
              new MovieCard(movie: movies[index])
          ),
          onRefresh: _refreshActions,
        )
    );
  }

  Future<void> _refreshActions() {
    setState(() {
      _moviesFuture = _movieFetcher.getRandomNext(_movieCount);
    });
    return Future.value(null);
  }
}
