import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:uniform_data/uniform_data.dart';
import 'package:decimal/decimal.dart';

import 'package:tplus_data/src/orders.dart';
import 'package:tplus_data/src/requester.dart';

class MockRequester extends Mock implements Requester {}

void main() {
  var orders;
  var requester;
  var auditRequester;

  setUp(() {
    requester = MockRequester();
    auditRequester = MockRequester();
    orders = Orders(helper: requester, auditRequester: auditRequester);
  });

  test('update()', () async {
    final testCustomerId = '100';
    final testWarehouseId = '200';
    final testNote = 'testNote';

    final lineItems = <OrderLineItem>[
      OrderLineItem()
        ..product = (OrderLineItemProduct()
          ..id = '110'
          ..price = (Price()
            ..currency = 'RMB'
            ..value = '124')
          ..costOfGoodsSold = (Price()
            ..currency = 'RMB'
            ..value = '120')
          ..taxRate = 13)
        ..quantityShipped = 123
        ..shippingDetails =
            (OrderLineItemShippingDetails()..warehouseId = testWarehouseId)
    ];

    final order = Order()
      ..snippet = (OrderSnippet()
        ..customerId = testCustomerId
        ..lineItems.addAll(lineItems))
      ..contentDetails = (OrderContentDetails()
        ..customAttributes.add(CustomAttribute()
          ..name = 'outboundDeliveryNote'
          ..value = testNote))
      ..status = (OrderStatus()..orderStatus = OrderOrderStatus.shipped);

    final url = Uri.parse('${requester.url}${Orders.updateUrl}');

    when(requester.fetch(url, any)).thenAnswer((_) async => {
          'value': {
            'Data': {'ID': '100', 'Ts': '2111111'}
          }
        });

    final auditUrl = Uri.parse('${auditRequester.url}${Orders.auditUrl}');

    when(auditRequester.fetch(auditUrl, any)).thenAnswer((_) async => {
          'value': {'Data': {}}
        });

    await orders.update('', order);

    final params = {
      'action': 'Save',
      'data': {
        '__type': '',
        'keys': [
          'SysId',
          'BizCode',
          'RawUrl',
          'ViewType',
          'TView',
          'taskID',
          'mId',
          'sysId',
          'pId',
          'SourceType',
          'TaskSessionID',
          'voucherStateControl',
          'UpdateWholeTree',
          'MutexState',
          'DetailNames',
          'dto',
          'VoucherState',
          'PostSaveAction',
          'TaskManager',
          'isAuditProcess',
          'operation',
          'editState'
        ],
        'values': [
          'ST',
          'ST1021',
          '/tplus/BAPView/Voucher.aspx?mId=ST1021&sysId=ST&pId=voucherView&SourceType=FromMenu&taskID=%E9%94%80%E5%94%AE%E5%87%BA%E5%BA%93%E5%8D%95&TaskSessionID=961e7bd1-25eb-33cc-b584-3b2b2adf71ac',
          'voucherView',
          'undefined',
          '%E9%94%80%E5%94%AE%E5%87%BA%E5%BA%93%E5%8D%95',
          'ST1021',
          'ST',
          'voucherView',
          'FromMenu',
          '961e7bd1-25eb-33cc-b584-3b2b2adf71ac',
          'New',
          'False',
          '01',
          '',
          {
            '__type':
                'Ufida.T.ST.DTO.RDRecordDTO, Ufida.T.ST.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'type':
                'Ufida.T.ST.DTO.RDRecordDTO, Ufida.T.ST.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'data': {
              'Status': 1,
              'IdVoucherState': '181',
              'VoucherState': {'Id': '181', 'Code': '00', 'Name': '未审'},
              'IdDeliveryState': '302',
              'DeliveryState': {'Id': '302', 'Code': '00', 'Name': '未销货'},
              'VoucherDate':
                  DateTime.now().toString().split(' ').first, // '2021-03-29',
              'Code': '', // 'IO-2021-03-0001',
              'IdBusiType': 65,
              'IdRdStyle': 17,
              'IdPartner': testCustomerId,
              'IdSettleCustomer': testCustomerId,
              'Mobilephone': '',
              'Address': '',
              'IdWarehouse': testWarehouseId, // '3',
              'IdCurrency': 4,
              'ExchangeRate': '1',
              'IdCollaborateUpVoucherType': '',
              'IdCollaborateUpVoucher': '',
              'DispatchAddress': '',
              'Contact': '',
              'ContactPhone': '',
              'IdDataSource': '1531',
              'DataSource': {'Id': '1531', 'Code': '02', 'Name': '线下业务'},
              'ExternalCode': '',
              'SourceVoucherCode': '',
              'SaleOrderCode': '',
              'IsNoModify': '',
              'IsModifiedCode': false,
              'IdVoucherType': 19,
              'RdDirectionFlag': false,
              'IsAutoGenerate': false,
              'BeforeUpgrade': '',
              'Memo': testNote,
              'Maker': '',
              'Reviser': '',
              'Auditor': '',
              'AuditedDate': '',
              'PrintCount': '0',
              'IdMarketingOrgan': 1,
              'ID': null,
              'Ts': null,
              'RDRecordDetails': {
                '__type': 'AjaxPro.DTOCollectionConverter,AjaxPro.2',
                'type': 'undefined',
                'cols': [
                  'Status',
                  'Code',
                  'IdWarehouse',
                  'IdInventory',
                  'IdUnit',
                  'Quantity',
                  'Price',
                  'Amount',
                  'TaxRate',
                  'CompositionQuantity',
                  'DiscountRate',
                  'AvailableQuantity',
                  'AvailableCompositionQuantity',
                  'ExistingQuantity',
                  'ExistingCompositionQuantity',
                  'PriceStrategyTypeName',
                  'PriceStrategySchemeNames',
                  'IsModifiedPrice',
                  'PromotionVoucherCodes',
                  'IsPromotionPresent',
                  'ModifyFieldsForPromotion',
                  'TaxFlag',
                  'PromotionSingleVoucherTs',
                  'PromotionSingleVoucherCode',
                  'PriceStrategySchemeIds',
                  'PromotionVoucherIds',
                  'LastModifiedField'
                ],
                'rows':
                    lineItems.where((e) => e.quantityShipped > 0).map((item) {
                  final cost =
                      Decimal.parse(item.product.costOfGoodsSold.value);
                  final quantity =
                      Decimal.parse(item.quantityShipped.toString());

                  return [
                    1, // Status
                    '${order.snippet.lineItems.indexOf(item) + 1}', // Code
                    int.parse(item.shippingDetails.warehouseId ??
                        '0'), // 3, // IdWarehouse
                    int.parse(item.product.id), // 10, // IdInventory
                    1, // IdUnit
                    '${item.quantityShipped}', // '33.00', // Quantity
                    item.product.costOfGoodsSold.value ?? '', // '656', // Price
                    '${quantity * cost}', // '21648.00', // Amount
                    '${item.product.taxRate / 100.0}', // '0.17', // TaxRate
                    '${item.quantityShipped}个', // CompositionQuantity
                    '1', // DiscountRate
                    '', // AvailableQuantity
                    '', // AvailableCompositionQuantity
                    '', // ExistingQuantity
                    '', // ExistingCompositionQuantity
                    '', // PriceStrategyTypeName
                    '', // PriceStrategySchemeNames
                    'false', // IsModifiedPrice
                    '', // PromotionVoucherCodes
                    'false', // IsPromotionPresent
                    'PromotionPresentVoucherID', // ModifyFieldsForPromotion
                    'true', // TaxFlag
                    '', // PromotionSingleVoucherTs
                    '', // PromotionSingleVoucherCode
                    '', // PriceStrategySchemeIds
                    '', // PromotionVoucherIds
                    '' // LastModifiedField
                  ];
                }).toList(),
              },
              '__type':
                  'Ufida.T.ST.DTO.RDRecordDTO, Ufida.T.ST.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null'
            }
          },
          'New',
          'Add',
          'StockSaveValidateTask,StockControlTask,CustomerCreditControlTask,SalesmanCreditControlTask,ConfirmPromotionPriceTask,ConfirmPromotionPresentTask',
          'True',
          'Save',
          'Add'
        ]
      }
    };

    verify(requester.fetch(url, params)).called(1);

    final auditParams = {
      'action': 'Audit',
      'data': {
        '__type': '',
        'keys': [
          'SysId',
          'BizCode',
          'RawUrl',
          'ViewType',
          'TView',
          'taskID',
          'mId',
          'sysId',
          'pId',
          'SourceType',
          'TaskSessionID',
          'voucherStateControl',
          'UpdateWholeTree',
          'MutexState',
          'DetailNames',
          'ID',
          'Ts',
          'TaskManager',
          'isAuditProcess',
          'operation',
          'editState'
        ],
        'values': [
          'ST',
          'ST1021',
          '/tplus/BAPView/Voucher.aspx?mId=ST1021&sysId=ST&pId=voucherView&SourceType=FromMenu&taskID=%E9%94%80%E5%94%AE%E5%87%BA%E5%BA%93%E5%8D%95&TaskSessionID=23d6f687-eeb1-a7bc-50b1-61d6abff37ed',
          'voucherView',
          'undefined',
          '%E9%94%80%E5%94%AE%E5%87%BA%E5%BA%93%E5%8D%95',
          'ST1021',
          'ST',
          'voucherView',
          'FromMenu',
          '23d6f687-eeb1-a7bc-50b1-61d6abff37ed',
          'Edit',
          'False',
          '02',
          '',
          100,
          '2111111',
          'StockEffectValidateTask,StockControlTask',
          'True',
          'Audit',
          'Edit'
        ]
      }
    };

    verify(auditRequester.fetch(auditUrl, auditParams)).called(1);

    when(requester.fetch(any, any)).thenAnswer((_) async => {});

    expect(() async => await orders.update('', order), throwsA(isA<Error>()));
  });
}
