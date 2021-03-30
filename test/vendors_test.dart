import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tplus_data/src/requester.dart';
import 'package:tplus_data/src/vendors.dart';

class MockTPlusHelper extends Mock implements Requester {}

void main() {
  var vendors;

  setUp(() {
    vendors = Vendors(helper: MockTPlusHelper());
  });

  test('list()', () async {
    when(vendors.helper.fetch(any, any)).thenAnswer((_) async => {
          'value': {
            'Script': [],
            'Data': {
              'PagePara': {
                'TotalCount': 3,
                'PerPageSize': 3,
                'TotalPageNum': 1,
                'CurrentPageNum': 0
              },
              'DataTable': [
                [
                  ['Code', 'System.String'],
                  ['Name', 'System.String'],
                  ['PartnerType_Name', 'System.String'],
                  ['SettlementPartner_Name', 'System.String'],
                  ['PriceGrade_Name', 'System.String'],
                  ['Saledepartment_Name', 'System.String'],
                  ['ID', 'System.Int32'],
                  ['Saleman_Name', 'System.String'],
                  ['PartnerDTO_ARBalance', 'System.Decimal'],
                  ['PartnerDTO_APBalance', 'System.Decimal'],
                  ['PartnerDTO_AdvRBalance', 'System.Decimal'],
                  ['PartnerDTO_AdvPBalance', 'System.Decimal'],
                  ['PartnerDTO_Disabled', 'System.Byte'],
                  ['PartnerDTO_priuserdefnvc1', 'System.String'],
                  ['PartnerAddresDTOs_Position', 'System.String'],
                  ['SellCustomer', 'System.Byte'],
                  ['MadeRecordDate', 'System.DateTime'],
                  ['SaleDepartment_id', 'System.Int32'],
                  ['SaleMan_id', 'System.Int32'],
                  ['SettlementPartner_id', 'System.Int32'],
                  ['Ts', 'System.String']
                ],
                [
                  [
                    '0LS0001',
                    'testTitle0',
                    '供应商',
                    null,
                    null,
                    null,
                    2,
                    null,
                    0,
                    0,
                    0,
                    0,
                    0,
                    null,
                    null,
                    0,
                    [2021, 2, 26, 5, 25, 44, 940],
                    null,
                    null,
                    null,
                    '0000000000912143'
                  ],
                  [
                    '0LS0002',
                    'testTitle1',
                    '供应商',
                    null,
                    null,
                    null,
                    3,
                    null,
                    0,
                    0,
                    0,
                    0,
                    0,
                    '10810769',
                    null,
                    0,
                    [2021, 2, 26, 22, 27, 51, 817],
                    null,
                    null,
                    null,
                    '0000000000913694'
                  ],
                  [
                    '0LS0003',
                    'testTitle2',
                    '供应商',
                    null,
                    null,
                    null,
                    4,
                    null,
                    0,
                    0,
                    0,
                    0,
                    0,
                    null,
                    null,
                    0,
                    [2021, 2, 27, 19, 27, 45, 490],
                    null,
                    null,
                    null,
                    '0000000000913697'
                  ]
                ],
              ],
              'Count': 3,
              'IsSynchronized': false,
              'SyncRoot': {}
            },
            'Infomation': {}
          }
        });

    final response = await vendors.list('snippet,contentDetails');

    expect(response.items[0].id, '2');
    expect(response.items[0].snippet.title, 'testTitle0');
    expect(response.items[0].contentDetails.customAttributes[0].name,
        'priuserdefnvc1');
    expect(response.items[0].contentDetails.customAttributes[0].value, '');
    expect(response.items[0].contentDetails.customAttributes[1].name,
        'priuserdefnvc2');
    expect(response.items[0].contentDetails.customAttributes[1].value, '');
    expect(response.items[0].contentDetails.customAttributes[2].name,
        'priuserdefnvc3');
    expect(response.items[0].contentDetails.customAttributes[2].value, '');
    expect(response.items[0].contentDetails.customAttributes[3].name,
        'priuserdefnvc4');
    expect(response.items[0].contentDetails.customAttributes[3].value, '');
    expect(response.items[0].contentDetails.customAttributes[4].name,
        'priuserdefnvc5');
    expect(response.items[0].contentDetails.customAttributes[4].value, '');

    expect(response.items[1].id, '3');
    expect(response.items[1].snippet.title, 'testTitle1');
    expect(response.items[1].contentDetails.customAttributes[0].name,
        'priuserdefnvc1');
    expect(
        response.items[1].contentDetails.customAttributes[0].value, '10810769');
    expect(response.items[1].contentDetails.customAttributes[1].name,
        'priuserdefnvc2');
    expect(response.items[1].contentDetails.customAttributes[1].value, '');
    expect(response.items[1].contentDetails.customAttributes[2].name,
        'priuserdefnvc3');
    expect(response.items[1].contentDetails.customAttributes[2].value, '');
    expect(response.items[1].contentDetails.customAttributes[3].name,
        'priuserdefnvc4');
    expect(response.items[1].contentDetails.customAttributes[3].value, '');
    expect(response.items[1].contentDetails.customAttributes[4].name,
        'priuserdefnvc5');
    expect(response.items[1].contentDetails.customAttributes[4].value, '');

    expect(response.items[2].id, '4');
    expect(response.items[2].snippet.title, 'testTitle2');
    expect(response.items[2].contentDetails.customAttributes[0].name,
        'priuserdefnvc1');
    expect(response.items[2].contentDetails.customAttributes[0].value, '');
    expect(response.items[2].contentDetails.customAttributes[1].name,
        'priuserdefnvc2');
    expect(response.items[2].contentDetails.customAttributes[1].value, '');
    expect(response.items[2].contentDetails.customAttributes[2].name,
        'priuserdefnvc3');
    expect(response.items[2].contentDetails.customAttributes[2].value, '');
    expect(response.items[2].contentDetails.customAttributes[3].name,
        'priuserdefnvc4');
    expect(response.items[2].contentDetails.customAttributes[3].value, '');
    expect(response.items[2].contentDetails.customAttributes[4].name,
        'priuserdefnvc5');
    expect(response.items[2].contentDetails.customAttributes[4].value, '');

    expect(response.pageInfo.totalResults, 3);
    expect(response.pageInfo.resultsPerPage, 30);

    expect(response.hasPrevPageToken(), false);
    expect(response.hasNextPageToken(), false);

    when(vendors.helper.fetch(any, any)).thenAnswer((_) async => {
          'value': {
            'Script': [],
            'Data': {
              'PagePara': {
                'TotalCount': 28,
                'PerPageSize': 10,
                'TotalPageNum': 3,
                'CurrentPageNum': 1
              },
              'DataTable': [
                [
                  ['Code', 'System.String'],
                  ['Name', 'System.String'],
                  ['Address', 'System.String'],
                  ['Admin_name', 'System.String'],
                  ['InvolveATP', 'System.Byte'],
                  ['Memo', 'System.String'],
                  ['Disabled', 'System.Byte'],
                  ['AllowZeroStockOut', 'System.Byte'],
                  ['priuserdefnvc1', 'System.String'],
                  ['ID', 'System.Int32'],
                  ['Admin_id', 'System.Int32'],
                  ['Ts', 'System.String']
                ],
                [
                  [
                    '001',
                    'testTitle2',
                    '',
                    null,
                    1,
                    '',
                    0,
                    1,
                    null,
                    1,
                    null,
                    '0000000000912053'
                  ]
                ]
              ],
              'Count': 3,
              'IsSynchronized': false,
              'SyncRoot': {}
            },
            'Infomation': {}
          }
        });

    final response2 = await vendors.list('', maxResults: 10);

    expect(response2.hasNextPageToken(), true);
    expect(response2.hasPrevPageToken(), true);
    expect(response2.items.first.hasSnippet(), false);
    expect(response2.items.first.hasContentDetails(), false);

    final response3 = await vendors.list('snippet',
        pageToken: response2.nextPageToken, maxResults: 10);
    expect(response3.items.first.hasSnippet(), true);
    expect(response3.items.first.hasContentDetails(), false);

    verify(vendors.helper.fetch(any, {
      'action': 'PageIndex',
      'data': {
        '__type': '',
        'keys': [
          'SysId',
          'BizCode',
          'RawUrl',
          'ViewType',
          'TView',
          'taskID',
          'sysId',
          'mId',
          'pId',
          'SourceType',
          'TaskSessionID',
          'Action',
          'HideMasker',
          'searchStyle',
          'MutexState',
          'PageIndex',
          'PageSize',
          'ColumnSetName',
          'SearchStyle',
          'SearchName'
        ],
        'values': [
          'aa',
          'aa1003',
          '/tplus/BAPView/BaseInfoList.aspx?sysId=aa&mId=aa1003&pId=baseInfoList&SourceType=FromMenu&taskID=%E5%BE%80%E6%9D%A5%E5%8D%95%E4%BD%8D&TaskSessionID=fdbdfecf-5502-802a-f8ef-3b37b955e464&Action=Search&HideMasker=true',
          'baseInfoListView',
          'undefined',
          '%E5%BE%80%E6%9D%A5%E5%8D%95%E4%BD%8D',
          'aa',
          'aa1003',
          'baseInfoList',
          'FromMenu',
          'fdbdfecf-5502-802a-f8ef-3b37b955e464',
          'Search',
          'true',
          'Advanced',
          '',
          1,
          10,
          'PartnerDTO',
          'Advanced',
          'PartnerList'
        ]
      }
    })).called(1);
  });
}
