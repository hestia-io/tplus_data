import 'dart:convert';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart';

import 'package:tplus_data/tplus_data.dart';

class MockClient extends Mock implements Client {}

void main() {
  TPlusHelper helper;

  setUp(() {
    helper = TPlusHelper(
      url: 'testUrl',
      client: MockClient(),
      userName: 'testUserName',
      password: 'testPassword',
      accountNumber: 'testAccountNumber',
    );
  });

  test('fetch()', () async {
    final testUrl = Uri();
    final testParams = {'a': 10, 'b': 'c'};
    final testCookie = 'testCookie';

    final signInUrl = Uri.parse(
        '${helper.url}/tplus/ajaxpro/Ufida.T.SM.Login.UIP.LoginManager,'
        'Ufida.T.SM.Login.UIP.ashx?method=CheckPassword');

    when(helper.client.post(signInUrl, body: anyNamed('body'))).thenAnswer(
        (_) async => Response('', 200, headers: {'set-cookie': testCookie}));

    when(helper.client.post(testUrl,
            headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => Response(
            '{"result":"ok","Data": '
            'new Ajax.Web.DataTable("key", 100, new Date(2012, "22"),'
            'new Date("22", "10")),"count":10}',
            200));

    final results = await helper.fetch(testUrl, testParams);

    expect(helper.cookie, testCookie);

    final now = DateTime.now();

    verify(helper.client.post(signInUrl,
        body: jsonEncode({
          'AccountNum': helper.accountNumber,
          'UserName': helper.userName,
          'Password': md5.convert(utf8.encode(helper.password)).toString(),
          'rdpYear': '${now.year}',
          'rdpMonth': '${now.month}',
          'rdpDate': '${now.day}',
          'webServiceProcessID': '',
          'aqdKey': '',
        }))).called(1);

    expect(results['result'], 'ok');
    expect(results['Data'][0], 'key');
    expect(results['Data'][3][0], '22');

    verify(helper.client.post(testUrl,
            headers: {'cookie': testCookie}, body: jsonEncode(testParams)))
        .called(1);
  });
}
