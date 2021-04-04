import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('tplus.requester');

class Requester {
  Requester({
    this.url,
    this.client,
    this.userName,
    this.password,
    this.accountNumber,
  });

  final String url;

  final Client client;

  final String userName;

  final String password;

  final String accountNumber;

  String _cookie;

  bool _inited = false;

  String get cookie => _cookie;

  Future<void> _signIn() async {
    final now = DateTime.now();

    final params = {
      'AccountNum': accountNumber,
      'UserName': userName,
      'Password': md5.convert(utf8.encode(password)).toString(),
      'rdpYear': '${now.year}',
      'rdpMonth': '${now.month}',
      'rdpDate': '${now.day}',
      'webServiceProcessID': '',
      'aqdKey': '',
    };

    final response = await client.post(
        Uri.parse('$url/tplus/ajaxpro/Ufida.T.SM.Login.UIP.LoginManager,'
            'Ufida.T.SM.Login.UIP.ashx?method=CheckPassword'),
        body: jsonEncode(params));

    final cookie = response.headers['set-cookie'] ?? '';

    if (cookie.isEmpty) {
      _logger.severe('sign in failure');
      throw Error();
    }

    _cookie = cookie;

    _logger.fine('sign in success');
  }

  ///
  Future<Map> fetch(Uri url, Map params) async {
    if (!_inited) {
      await _signIn();
      _inited = true;
    }

    final body = jsonEncode(params);
    _logger.fine('request $url', body);

    final response =
        await client.post(url, headers: {'cookie': _cookie}, body: body);

    _logger.fine('response', response.body);

    final results = _flattenClass(response.body);

    return jsonDecode(results);
  }

  String _flattenClass(String str) {
    return str.replaceAllMapped(RegExp(r'new Date\(([^\(\)]*)\)'), (Match m) {
      return '[' + m.group(1) + ']';
    }).replaceAllMapped(RegExp(r'new Ajax\.Web\.DataTable\((.*)\)'), (Match m) {
      return '[' + m.group(1) + ']';
    });

    /*
    return str.replaceAllMapped(RegExp(r'new[^\(\)]*\((.*)\),'), (Match m) {
      return '[' + m.group(1) + '],';
    });
    */
  }
}
