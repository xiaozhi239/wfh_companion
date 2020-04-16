import 'dart:math';

import 'package:tmdb_api/tmdb_api.dart';
import 'package:wfh_companion/movie/data/api_loader.dart';
import 'package:wfh_companion/movie/data/movie.dart';

class MovieFetcher {

  final MovieDbApiLoader _apiLoader = new MovieDbApiLoader();
  final Random _random = new Random(DateTime.now().millisecondsSinceEpoch);

  Future<List<Movie>> getRandomNext(int number) async {
    Map response = await _loadMovies(number);
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
          popularity: movie["popularity"],
        ));
      } catch (e) {
        print(e);
      }
    }
    return Future.value(movies);
  }

  Future<Map> _loadMovies(int number) async {
    TMDB movieService = TMDB(await _apiLoader.getApiKey());

    // Get some "randomness"
    int voteGtn = 5 + _random.nextInt(3);
    int voteCountGtn = 10 + _random.nextInt(1000);
    int page = 1 + _random.nextInt(100);

    Map response = await movieService.v3.discover.getMovies(
        page: page,
        voteCountGreaterThan: voteCountGtn,
        voteAverageGreaterThan: voteGtn);

    // Retry if the result items are empty, normally due to page out of range.
    List results = response["results"];
    if (results.length == 0) {
      page = 1 + _random.nextInt(response["total_pages"] - 1);
    }
    response = await movieService.v3.discover.getMovies(
        page: page,
        voteCountGreaterThan: voteCountGtn,
        voteAverageGreaterThan: voteGtn);
    return Future.value(response);
  }
}