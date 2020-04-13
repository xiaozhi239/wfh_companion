import 'package:wfh_companion/movie/data/Movie.dart';

class MovieFetcher {

  Future<List<Movie>> getRandomNext(int number) async {
    List<Movie> movies = new List(number);
    for (int i = 0; i < number; i++) {
      movies[i] = new Movie(title: DateTime.now().toIso8601String());
    }
    return Future.delayed(Duration(seconds: 2), () => movies);
  }
}