import 'package:test/test.dart';

import 'package:tplus_data/src/utils.dart';

void main() {
  test('encodeDecodePageToken()', () {
    [0, 10, 100].forEach((index) {
      expect(decodePageToken(encodePageToken(index)), index);
    });

    expect(decodePageToken(null), 0);
    expect(decodePageToken(null, 30), 30);
  });
}
