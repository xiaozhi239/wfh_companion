import 'dart:math';

import 'package:tmdb_api/tmdb_api.dart';
import 'package:wfh_companion/movie/data/api_loader.dart';
import 'package:wfh_companion/movie/data/movie.dart';

class MovieFetcher {

  final MovieDbApiLoader _apiLoader = new MovieDbApiLoader();

  Future<List<Movie>> getRandomNext(int number) async {
    Map response = await _loadMovies();
    List results = response["results"];
    number = min(number, results.length);
    List<Movie> movies = new List();
    for (int i = 0; i < number; i++) {
      Map movie = results[i];
      try {
        movies.add(new Movie(
          title: movie["title"],
          overview: movie["overview"],
          voteCount: movie["vote_count"],
          avgVote: movie["vote_average"] + .0,
          posterPath: movie["poster_path"],
          releaseDate: DateTime.parse(movie["release_date"]),
        ));
      } catch (e) {
        print(e);
      }
    }
    return Future.value(movies);
  }

  Future<Map> _loadMovies() async {
    TMDB tmdb = TMDB(await _apiLoader.getApiKey());
    return await tmdb.v3.discover.getMovies(page: 1, voteCountGreaterThan: 10, voteAverageGreaterThan: 6);
  }
}