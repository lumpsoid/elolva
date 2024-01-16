import 'package:mozhi_api/mozhi_api.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    MozhiApiClient apiClient = MozhiApiClient();
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      String translation =
          await apiClient.getTranslation('bokal', 'google', 'sr', 'ru');
      expect(translation, "кувшин");
    });
  });
}
