class TPlusError extends Error {
  TPlusError({this.name, this.message});

  final String name;

  final String message;

  @override
  String toString() {
    return '$name $message';
  }
}

class OrderInsertError extends TPlusError {
  OrderInsertError({String message})
      : super(name: 'OrderInsertError', message: message);
}

class OrderAuditError extends TPlusError {
  OrderAuditError({String message})
      : super(name: 'OrderAuditError', message: message);
}

class CustomerInsertError extends TPlusError {
  CustomerInsertError({String message})
      : super(name: 'CustomerInsertError', message: message);
}

class ProductInsertError extends TPlusError {
  ProductInsertError({String message})
      : super(name: 'ProductInsertError', message: message);
}

class WarehouseEntryInsertError extends TPlusError {
  WarehouseEntryInsertError({String message})
      : super(name: 'WarehouseEntryInsertError', message: message);
}

class WarehouseEntryAuditError extends TPlusError {
  WarehouseEntryAuditError({String message})
      : super(name: 'WarehouseEntryAuditError', message: message);
}
