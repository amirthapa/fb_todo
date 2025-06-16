import 'package:flutter_test/flutter_test.dart';
import 'package:todo/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DatabasenoteServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
