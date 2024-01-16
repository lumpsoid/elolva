import 'dart:convert';

import 'package:http/http.dart' as http;

/// Exception thrown when locationSearch fails.
class TranslationRequestFailure implements Exception {}

class MozhiApiClient {
  MozhiApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  // translate.projectsegfau.lt/api/translate?engine=google&from=sr&to=ru&text=bokal
  static const _baseUrlMozhi = 'translate.projectsegfau.lt';

  final http.Client _httpClient;

  Future<String> getTranslation(
      String text, String engine, String from, String to) async {
    final translationRequest = Uri.https(
      _baseUrlMozhi,
      '/api/translate',
      {'engine': engine, 'from': from, 'to': to, 'text': text},
    );

    final translationResponse = await _httpClient.get(translationRequest);

    if (translationResponse.statusCode != 200) {
      throw TranslationRequestFailure();
    }

    final locationJson = jsonDecode(translationResponse.body) as Map;

    final textTranslated = locationJson["translated-text"];

    return textTranslated;
  }
}
