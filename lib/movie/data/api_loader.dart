import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieDbApiLoader {
  static final String configPath = "assets/configs/secrets.json";
  static final String apiJsonKey = "TMDB_API_KEY";
  static final String apiReadAccessToken = "TMDB_READ_ACCESS_TOKEN";
  ApiKeys _apiKey;

  Future<ApiKeys> getApiKey() async {
    if (_apiKey == null) {
      _apiKey = await _loadApiKey();
    }
    return _apiKey;
  }

  Future<ApiKeys> _loadApiKey() async {
    return rootBundle.loadStructuredData<ApiKeys>(configPath, (jsonStr) async {
      final jsonMap = json.decode(jsonStr);
      return ApiKeys(jsonMap[apiJsonKey], jsonMap[apiReadAccessToken]);
    });
  }
}