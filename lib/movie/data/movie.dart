import 'package:flutter/material.dart';

class Movie {
  final String title;
  final int voteCount;
  final double avgVote;
  final String overview;
  final DateTime releaseDate;
  final String posterPath;
  final double popularity;

  Movie({
    @required this.title,
    @required this.voteCount,
    @required this.avgVote,
    @required this.overview,
    @required this.releaseDate,
    @required this.posterPath,
    @required this.popularity,
  });
}