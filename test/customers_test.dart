import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tplus_data/src/customers.dart';
import 'package:tplus_data/src/requester.dart';
import 'package:uniform_data/uniform_data.dart';

class MockHelper extends Mock implements Requester {}

void main() {
  var helper;
  var customers;

  setUp(() {
    helper = MockHelper();
    customers = Customers(helper: helper);
  });

  test('insert()', () async {
    when(helper.fetch(any, any)).thenAnswer((_) async => {
          'value': {
            'Data': {'ID': 'testId'}
          }
        });

    final order = await customers.insert(
        '',
        Customer()
          ..snippet = (CustomerSnippet()..title = 'testTitle')
          ..contentDetails = (CustomerContentDetails()
            ..customAttributes.add(CustomAttribute()
              ..name = 'priuserdefnvc1'
              ..value = 'testValue')));

    expect(order.id, 'testId');

    final url = Uri.parse('${helper.url}${Customers.insertUrl}');

    verify(helper.fetch(url, {
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
              'Name': 'testTitle',
              'PartnerAbbName': 'testTitle',
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
              'priuserdefnvc1': 'testValue',
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
    })).called(1);
  });
}
