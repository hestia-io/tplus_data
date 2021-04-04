import 'package:http/http.dart';

import 'customers.dart';
import 'orders.dart';
import 'products.dart';
import 'requester.dart';
import 'vendors.dart';
import 'warehouses.dart';
import 'warehouse_entries.dart';

export 'warehouse_entries.dart';

class TPlus {
  TPlus({
    String url,
    String userName,
    String password,
    String accountNumber,
  }) {
    _client = Client();

    final helper = Requester(
      url: url,
      userName: userName,
      password: password,
      accountNumber: accountNumber,
      client: _client,
    );

    _products = Products(helper: helper);
    _warehouses = Warehouses(helper: helper);
    _vendors = Vendors(helper: helper);
    _orders = Orders(helper: helper);
    _customers = Customers(helper: helper);
    _warehouseEntries = WarehouseEntries(requester: helper);
  }

  Client _client;

  Products _products;

  Products get products => _products;

  Warehouses _warehouses;

  Warehouses get warehouses => _warehouses;

  Vendors _vendors;

  Vendors get vendors => _vendors;

  Orders _orders;

  Orders get orders => _orders;

  Customers _customers;

  Customers get customers => _customers;

  WarehouseEntries _warehouseEntries;

  WarehouseEntries get warehouseEntries => _warehouseEntries;

  Future<void> dispose() async {
    _client.close();
  }
}
