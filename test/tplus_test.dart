import 'package:test/test.dart';
import 'package:tplus_data/tplus_data.dart';

void main() {
  test('constructor()', () {
    final tplus = TPlus();

    expect(tplus.warehouses, isNotNull);
    expect(tplus.products, isNotNull);
    expect(tplus.vendors, isNotNull);
    expect(tplus.customers, isNotNull);
    expect(tplus.orders, isNotNull);
  });
}
