import 'package:logging/logging.dart';
import 'package:uniform_data/uniform_data.dart';

import 'requester.dart';
import 'errors.dart';

class Customers {
  Customers({this.helper});

  final Requester helper;

  final Logger _logger = Logger('tplus.customers');

  static String insertUrl = '/tplus/ajaxpro/Ufida.T.AA.UIP.PartnerEdit,'
      'Ufida.T.AA.UIP.ashx?method=ExecuteAjaxAction&args.action=Save';

  Future<Customer> insert(String part, Customer customer) async {
    final url = Uri.parse('${helper.url}$insertUrl');

    var priuserdefnvc1 = '';

    customer.contentDetails.customAttributes.forEach((e) {
      if (e.name == 'priuserdefnvc1') {
        priuserdefnvc1 = e.value;
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
          'pId',
          'sysId',
          'mId',
          'NodeValue',
          'NodeLevel',
          'HasEverChanged',
          'listNeedRefresh',
          'UpdateWholeTree',
          'MutexState',
          'DetailNames',
          'dto',
          'VoucherState',
          'PostSaveAction'
        ],
        'values': [
          'aa',
          'aa1003',
          '/tplus/BAPView/BaseInfoCard.aspx?pId=baseInfoCardView&sysId=aa&mId=aa1003&NodeValue=root&NodeLevel=0',
          'baseInfoCardView',
          'undefined',
          '819cf857-6912-42db-84ac-7ea56980557a',
          'baseInfoCardView',
          'aa',
          'aa1003',
          'root',
          '0',
          '0',
          '',
          'False',
          '',
          '',
          {
            '__type':
                'Ufida.T.AA.DTO.PartnerDTO, Ufida.T.AA.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'type':
                'Ufida.T.AA.DTO.PartnerDTO, Ufida.T.AA.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'data': {
              'Status': 1,
              'Code': '0LS0004',
              'Name': customer.snippet.title ?? '',
              'PartnerAbbName': customer.snippet.title ?? '',
              'IdPartnerType': '211',
              'PartnerType': {'Id': '211', 'Code': '01', 'Name': '客户'},
              'IdPartnerClass': 1,
              'IdSettlementPartner': 1,
              'IsModifiedCode': false,
              'ShortHand': '',
              'MadeRecordDate': '',
              'ElectronicInvoiceReceiveEMail': '',
              'ElectronicInvoiceReceiveMobilePhone': '',
              'Disabled': false,
              'Representative': '',
              'BankAccount': '',
              'TaxRegcode': '',
              'CustomerAddressPhone': '',
              'eAccount': '',
              'IdTaxRate': '179',
              'TaxRate': '', // {'Id': '179', 'Code': '03', 'Name': '17'},
              'IdPriceGrade': '', // '442',
              'PriceGrade': '', // {'Id': '442', 'Code': '05', 'Name': '普通客户价'},
              'ARBalance': '0',
              'AdvRBalance': '0',
              'APBalance': '0',
              'AdvPBalance': '0',
              'SellCustomer': false,
              'AutoCreateMember': false,
              'addressJC': '',
              'RunShop': false,
              'CheckAddress': '',
              'CustomerAddress': '',
              'IdMarketingOrgan': 1,
              'priuserdefnvc1': priuserdefnvc1,
              'IdSaleSettleStyle': '7',
              'SaleSettleStyle': {'Id': '7', 'Code': '05', 'Name': '其它'},
              'SaleStartDate': '',
              'ID': null,
              'Ts': null,
              '__type':
                  'Ufida.T.AA.DTO.PartnerDTO, Ufida.T.AA.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null'
            }
          },
          'New',
          ''
        ]
      }
    };

    final results = await helper.fetch(url, params);

    if (results['value'] == null || results['value']['Data'] == null) {
      throw CustomerInsertError(message: results.toString());
    }

    customer.id = results['value']['Data']['ID'].toString();

    _logger.finest(results);

    return customer;
  }
}
