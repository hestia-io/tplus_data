import 'package:test/test.dart';
import 'package:tplus_data/tplus_data.dart';

void main() {
  test('constructor()', () {
    final testUrl = 'testUrl';
    final testUserName = 'testUserName';
    final testPassword = 'testPassword';
    final testAccount = 'testAccount';

    final tplus = TPlus(
      url: testUrl,
      userName: testUserName,
      password: testPassword,
      accountNumber: testAccount,
    );

    expect(tplus.warehouses, isNotNull);
    expect(tplus.products, isNotNull);
    expect(tplus.vendors, isNotNull);
    expect(tplus.customers, isNotNull);
    expect(tplus.orders, isNotNull);
    expect(tplus.warehouseEntries, isNotNull);

    expect(tplus.orders.helper, tplus.orders.auditRequester);
    expect(tplus.warehouseEntries.requester,
        tplus.warehouseEntries.auditRequester);

    final testAuditUserName = 'testAuditUserName';
    final testAuditPassword = 'testAuditPassword';

    final tplus2 = TPlus(
      url: testUrl,
      userName: testUserName,
      password: testPassword,
      accountNumber: testAccount,
      auditUserName: testAuditUserName,
      auditPassword: testAuditPassword,
    );

    [
      [tplus2.orders.helper, tplus2.orders.auditRequester],
      [
        tplus2.warehouseEntries.requester,
        tplus2.warehouseEntries.auditRequester
      ],
    ].forEach((e) {
      expect(e.first.userName, testUserName);
      expect(e.first.password, testPassword);
      expect(e.first.accountNumber, testAccount);

      expect(e.last.userName, testAuditUserName);
      expect(e.last.password, testAuditPassword);
      expect(e.last.accountNumber, testAccount);
    });
  });
}
