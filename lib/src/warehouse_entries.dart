import 'package:logging/logging.dart';
import 'package:decimal/decimal.dart';

import 'requester.dart';
import 'errors.dart';

final _logger = Logger('tplus.warehouseEntries');

class WarehouseEntry {
  WarehouseEntry({
    this.date,
    this.type,
    this.vendorId,
    this.warehouseId,
    this.clerkId,
    this.sourceId,
    this.note,
    this.items,
  });

  final String date;

  final String type;

  final String vendorId;

  final String warehouseId;

  final String clerkId;

  final String sourceId;

  final String note;

  final List<WarehouseEntryItem> items;

  Map toJson() => {
        if (date != null) 'date': date,
        if (type != null) 'type': type,
        if (vendorId != null) 'vendorId': vendorId,
        if (warehouseId != null) 'warehouseId': warehouseId,
        if (clerkId != null) 'clerkId': clerkId,
        if (sourceId != null) 'sourceId': sourceId,
        if (note != null) 'note': note,
        if (items != null) 'items': items.map((e) => e.toJson()).toList(),
      };
}

class WarehouseEntryItem {
  WarehouseEntryItem({
    this.productId,
    this.price,
    this.quantity,
    this.taxRate,
    this.warehouseId,
  });

  final String warehouseId;

  final String productId;

  final double price;

  final int quantity;

  final double taxRate;

  Map toJson() => {
        if (productId != null) 'productId': productId,
        if (warehouseId != null) 'warehouseId': warehouseId,
        if (price != null) 'price': price,
        if (quantity != null) 'quantity': quantity,
        if (taxRate != null) 'taxRate': taxRate,
      };
}

class WarehouseEntries {
  WarehouseEntries({
    this.requester,
    this.auditRequester,
  });

  final Requester requester;

  final Requester auditRequester;

  static String insertUrl =
      '/tplus/ajaxpro/Ufida.T.ST.UIP.NewPurchaseReceiveVoucherEdit'
      ',Ufida.T.ST.UIP.ashx?method=ExecuteAjaxAction&args.action=Save';

  static String auditUrl =
      '/tplus/ajaxpro/Ufida.T.ST.UIP.NewPurchaseReceiveVoucherEdit,'
      'Ufida.T.ST.UIP.ashx?method=ExecuteAjaxAction&args.action=Audit';

  Future<WarehouseEntry> insert(WarehouseEntry entry) async {
    final url = Uri.parse('${requester.url}$insertUrl');

    _logger.fine(entry.toJson());

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
          'ST', // 'SysId',
          // 单据类型
          'ST1001', // 'BizCode',
          '/tplus/BAPView/Voucher.aspx?mId=ST1001&sysId=ST&pId=voucherView&SourceType=FromMenu&taskID=%E9%87%87%E8%B4%AD%E5%85%A5%E5%BA%93%E5%8D%95&TaskSessionID=bfe09b38-c948-ecaa-da77-f5d107978689', // 'RawUrl'
          'voucherView', // 'ViewType',
          'undefined', // 'TView',
          '%E9%87%87%E8%B4%AD%E5%85%A5%E5%BA%93%E5%8D%95', // 'taskID',
          // 单据类型
          'ST1001', // 'mId',
          'ST', // 'sysId',
          'voucherView', // 'pId',
          'FromMenu', // 'SourceType',
          'bfe09b38-c948-ecaa-da77-f5d107978689', // 'TaskSessionID',
          'New', // 'voucherStateControl',
          'False', // 'UpdateWholeTree',
          // 业务类型 01:普通采购 02:采购退货
          '01', // 'MutexState',
          '', // 'DetailNames',
          //
          //
          // 字段说明
          // http://tplusdev.chanjet.com/library/576204e0e881e0ae21844f34
          {
            '__type':
                'Ufida.T.ST.DTO.RDRecordDTO, Ufida.T.ST.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'type':
                'Ufida.T.ST.DTO.RDRecordDTO, Ufida.T.ST.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'data': {
              'Status': 1,
              // 单据状态
              // @TODO: 需要确认正式环境状态
              'IdVoucherState': '181',
              'VoucherState': {'Id': '181', 'Code': '00', 'Name': '未审'},
              // 核算状态
              // @TODO: 需要确认正式环境状态
              'IdAccountState': '338',
              'AccountState': {'Id': '338', 'Code': 'NoAccount', 'Name': '未核算'},
              // 单据日期
              'VoucherDate': entry.date ?? '',
              //
              'Code': '', //'II-2021-03-0002',
              'IdBusiType': 1,
              'IdRdStyle': 2,
              'IdCurrency': 4,
              'ExchangeRate': '1',
              // @TODO: 供应商ID
              'IdPartner': entry.vendorId,
              //'IdDepartment': 1, // 部门
              'IdClerk': entry.clerkId, // 经办人ID

              // @TODO: 仓库ID
              'IdWarehouse': entry.warehouseId,
              //
              'IdCollaborateUpVoucherType': '',
              'IdCollaborateUpVoucher': '',
              'SourceVoucherCode': '',
              'SaleOrderCode': '',
              'SourceVoucherDate': '',
              'IsNoModify': '',
              'BeforeUpgrade': '',
              'priuserdefnvc1': entry.sourceId ?? '',
              'Memo': '${entry.note ?? ''}',
              'Maker': '',
              'Reviser': '',
              'Auditor': '',
              'AuditedDate': '',
              'PrintCount': '0',
              'IdMarketingOrgan': 1,
              'IsAutoGenerate': false,
              'IdVoucherType': 8,
              'RdDirectionFlag': true,
              'IsModifiedCode': false,
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
                  'OrigPrice',
                  'OrigAmount',
                  'ExistingQuantity',
                  'ExistingCompositionQuantity',
                  'CompositionQuantity',
                  'TaxRate',
                  'OrigTaxPrice',
                  'OrigTax',
                  'OrigTaxAmount',
                  'Price',
                  'TaxPrice',
                  'Amount',
                  'Tax',
                  'TaxAmount',
                  'TotalAmount',
                  'AvailableQuantity',
                  'AvailableCompositionQuantity',
                  'TaxFlag',
                  'LastModifiedField'
                ],
                'rows': entry.items.map((item) {
                  final productId = item.productId;
                  final quantity = Decimal.parse(item.quantity.toString());
                  final price = Decimal.parse(item.price.toStringAsFixed(2));
                  final taxRate =
                      Decimal.parse(item.taxRate.toStringAsFixed(2));
                  final one = Decimal.parse('1.0');

                  return [
                    1, // 'Status',
                    '${entry.items.indexOf(item) + 1}', // '0000', // 'Code',
                    item.warehouseId, // 'IdWarehouse',
                    productId, // 'IdInventory',
                    // 单位ID
                    // @TODO: 需要确认正式环境ID
                    1, // 'IdUnit',
                    '$quantity', // 'Quantity',
                    '$price', // 'OrigPrice',
                    '${(quantity * price)}', //'221778.00', // 'OrigAmount',
                    '', // '0', // 'ExistingQuantity',
                    '', // 'ExistingCompositionQuantity',
                    '$quantity个', // 'CompositionQuantity',
                    '$taxRate', // 'TaxRate',
                    '${(price * (one + taxRate))}', //'259.74', // 'OrigTaxPrice',
                    '${(price * taxRate * quantity)}', //'37702.26', // 'OrigTax',
                    '${(price * (one + taxRate) * quantity)}', //'259480.26', // 'OrigTaxAmount',
                    '$price', // 'Price',
                    '${(price * (one + taxRate))}', //'259.74', // 'TaxPrice',
                    '${(quantity * price)}', //'221778.00', // 'Amount',
                    '${(price * taxRate * quantity)}', //'37702.26', // 'Tax',
                    '${(price * (one + taxRate) * quantity)}', // '259480.26', // 'TaxAmount',
                    '${(quantity * price)}', // '221778.00', // 'TotalAmount',
                    '$quantity', // 'AvailableQuantity',
                    '$quantity个', // 'AvailableCompositionQuantity',
                    'false', // 'TaxFlag',
                    '' // 'LastModifiedField'
                  ];
                }).toList(),
              },
              '__type':
                  'Ufida.T.ST.DTO.RDRecordDTO, Ufida.T.ST.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null'
            }
          },
          'New',
          'Add',
          'StockSaveValidateTask,StockControlTask',
          'True',
          'Save',
          'Add'
        ]
      }
    };

    final response = await requester.fetch(url, params);

    _logger.fine(response);

    if (response['value'] == null || response['value']['Data'] == null) {
      throw WarehouseEntryInsertError(message: response.toString());
    }

    final id = response['value']['Data']['ID'].toString();
    final ts = response['value']['Data']['Ts'].toString();

    await _auditWarehouseEntry(id, ts);
  }

  Future<void> _auditWarehouseEntry(String id, String ts) async {
    final url = Uri.parse('${requester.url}$auditUrl');

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
          'ST1001',
          '/tplus/BAPView/Voucher.aspx?mId=ST1001&sysId=ST&pId=voucherView&SourceType=FromMenu&taskID=%E9%87%87%E8%B4%AD%E5%85%A5%E5%BA%93%E5%8D%95&TaskSessionID=5f83c214-1a8a-2b2c-43d1-334ae5e0c4b3',
          'voucherView',
          'undefined',
          '%E9%87%87%E8%B4%AD%E5%85%A5%E5%BA%93%E5%8D%95',
          'ST1001',
          'ST',
          'voucherView',
          'FromMenu',
          '5f83c214-1a8a-2b2c-43d1-334ae5e0c4b3',
          'Edit',
          'False',
          '02',
          '',
          int.parse(id), // ID
          ts, //'00000000009123c5',
          'StockEffectValidateTask,StockControlTask',
          'True',
          'Audit',
          'Edit'
        ]
      }
    };

    final response = await auditRequester.fetch(url, params);

    if (response['value'] == null || response['value']['Data'] == null) {
      throw WarehouseEntryAuditError(message: response.toString());
    }
  }
}
