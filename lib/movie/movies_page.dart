import 'package:flutter/material.dart';
import 'package:wfh_companion/movie/data/Movie.dart';
import 'package:wfh_companion/movie/data/MovieFetcher.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {

  static final _movieCount = 8;
  final MovieFetcher _movieFetcher = new MovieFetcher();
  Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = _movieFetcher.getRandomNext(_movieCount);
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: _movieCount,
              itemBuilder: (context, index) => _movieItem(movies[index])
          ),
          onRefresh: _refreshActions,
        )
    );
  }

  Widget _movieItem(Movie movie) {
    return Card(
        child: ListTile(
            title: Text("Movie title: ${movie.title}"),
            trailing: Text("Release date")
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
