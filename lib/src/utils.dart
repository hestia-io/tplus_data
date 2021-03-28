import 'dart:convert';

import 'package:logging/logging.dart';

final _logger = Logger('tplusUtils');

int decodePageToken(String pageToken, [int defaultValue = 0]) {
  var value = defaultValue;
  if (!(pageToken == null || pageToken.trim().isEmpty)) {
    try {
      value = int.parse(utf8.decode(base64Decode(pageToken)).split(':').last);
    } catch (e, stacks) {
      _logger.severe(e, stacks);
    }
  }
  return value;
}

String encodePageToken(int index) {
  return base64Encode(utf8.encode('pageIndex:$index'));
}
