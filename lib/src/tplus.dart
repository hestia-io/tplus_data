import 'package:http/http.dart';

import 'tplus_helper.dart';
import 'tplus_products.dart';
import 'tplus_warehouses.dart';
import 'tplus_vendors.dart';

class TPlus {
  TPlus({
    String url,
    String userName,
    String password,
    String accountNumber,
  }) {
    _client = Client();

    final helper = TPlusHelper(
      url: url,
      userName: userName,
      password: password,
      accountNumber: accountNumber,
      client: _client,
    );

    _products = TPlusProducts(helper: helper);
    _warehouses = TPlusWarehouses(helper: helper);
    _vendors = TPlusVendors(helper: helper);
  }

  Client _client;

  TPlusProducts _products;

  TPlusProducts get products => _products;

  TPlusWarehouses _warehouses;

  TPlusWarehouses get warehouses => _warehouses;

  TPlusVendors _vendors;

  TPlusVendors get vendors => _vendors;

  Future<void> dispose() async {
    _client.close();
  }
}
