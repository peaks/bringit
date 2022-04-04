import 'package:git_ihm/data/path_manager.dart';
import 'package:test/test.dart';

import '../mock/shared_preferences.dart';

void main() {
  late PathManager pm;

  setUp(() {
    pm = SpPathManager(MockedSharedPreferences());
  });

  test('returns empty string if not initialized', () {
    expect(pm.path, equals(''));
  });

  test('keeps the provided path', () async {
    pm.path = 'foo/bar';

    expect(pm.path, equals('foo/bar'));
  });
}
