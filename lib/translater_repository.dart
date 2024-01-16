import 'package:mozhi_api/mozhi_api.dart';

class TranslateRepository {
  TranslateRepository({MozhiApiClient? mozhiApiClient})
      : _mozhiApiClient = mozhiApiClient ?? MozhiApiClient();

  final MozhiApiClient _mozhiApiClient;

  Future<String> getTranslation(String text) async {
    String translation =
        await _mozhiApiClient.getTranslation(text, 'google', 'sr', 'ru');

    return translation;
  }
}
