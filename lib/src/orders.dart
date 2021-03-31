import 'package:logging/logging.dart';
import 'package:uniform_data/uniform_data.dart';

import 'requester.dart';

class Orders {
  Orders({this.helper});

  final Requester helper;

  final Logger _logger = Logger('TPlusOrders');

  static String updateUrl =
      '/tplus/ajaxpro/Ufida.T.ST.UIP.NewSaleDispatchVoucherEdit,'
      'Ufida.T.ST.UIP.ashx?method=ExecuteAjaxAction&args.action=Save';

  ///
  Future<Order> update(String part, Order order) async {
    if (order.status.orderStatus == OrderOrderStatus.canceled ||
        order.status.orderStatus == OrderOrderStatus.inProgress ||
        order.status.orderStatus == OrderOrderStatus.pendingShipment) {
      return order;
    }

    final url = Uri.parse('${helper.url}$updateUrl');

    var note = '';
    order.contentDetails.customAttributes.forEach((e) {
      if (e.name == 'outboundDeliveryNote') {
        note = e.value;
      }
    });

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
              'IdPartner': order.snippet.customerId ?? '',
              'IdSettleCustomer': order.snippet.customerId ?? '',
              'Mobilephone': '',
              'Address': '',
              'IdWarehouse':
                  order.snippet.lineItems.first.shippingDetails.warehouseId ??
                      '', // '3',
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
              'Memo': note,
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
                'rows': order.snippet.lineItems
                    .where((e) => e.quantityShipped > 0)
                    .map((item) {
                  return [
                    1, // Status
                    '${order.snippet.lineItems.indexOf(item) + 1}', // Code
                    int.parse(item.shippingDetails.warehouseId ??
                        '0'), // 3, // IdWarehouse
                    int.parse(item.product.id), // 10, // IdInventory
                    1, // IdUnit
                    '${item.quantityShipped}', // '33.00', // Quantity
                    item.product.costOfGoodsSold.value ?? '', // '656', // Price
                    (item.quantityShipped *
                            double.parse(item.product.costOfGoodsSold.value))
                        .toString(), // '21648.00', // Amount
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

    final results = await helper.fetch(url, params);

    if (results['value'] == null || results['value']['Data'] == null) {
      throw Error();
    }

    final id = results['value']['Data']['ID'].toString();
    final ts = results['value']['Data']['Ts'].toString();

    await _auditOrder(id, ts);

    return order;
  }

  Future<void> _auditOrder(String id, String ts) async {
    final url = Uri.parse(
        '${helper.url}/tplus/ajaxpro/Ufida.T.ST.UIP.NewSaleDispatchVoucherEdit,'
        'Ufida.T.ST.UIP.ashx?method=ExecuteAjaxAction&args.action=Audit');

    final params = {
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
          int.parse(id),
          ts,
          'StockEffectValidateTask,StockControlTask',
          'True',
          'Audit',
          'Edit'
        ]
      }
    };

    final results = await helper.fetch(url, params);

    if (results['value'] == null || results['value']['Data'] == null) {
      throw Error();
    }
  }
}
