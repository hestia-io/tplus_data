import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tplus_data/src/requester.dart';
import 'package:tplus_data/src/warehouses.dart';

class MockTPlusHelper extends Mock implements Requester {}

void main() {
  var warehouses;

  setUp(() {
    warehouses = Warehouses(helper: MockTPlusHelper());
  });

  test('list()', () async {
    when(warehouses.helper.fetch(any, any)).thenAnswer((_) async => {
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
                    '0001',
                    'testTitle0',
                    '',
                    null,
                    1,
                    '',
                    0,
                    1,
                    null,
                    2,
                    null,
                    '00000000009127b1'
                  ],
                  [
                    '0002',
                    'testTitle1',
                    '',
                    null,
                    1,
                    '',
                    0,
                    1,
                    '10810769',
                    3,
                    null,
                    '00000000009129a2'
                  ],
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

    final response = await warehouses.list('snippet,contentDetails');

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

    expect(response.items[2].id, '1');
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

    when(warehouses.helper.fetch(any, any)).thenAnswer((_) async => {
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

    final response2 = await warehouses.list('', maxResults: 10);

    expect(response2.hasNextPageToken(), true);
    expect(response2.hasPrevPageToken(), true);
    expect(response2.items.first.hasSnippet(), false);
    expect(response2.items.first.hasContentDetails(), false);

    final response3 = await warehouses.list('snippet',
        pageToken: response2.nextPageToken, maxResults: 10);
    expect(response3.items.first.hasSnippet(), true);
    expect(response3.items.first.hasContentDetails(), false);

    verify(warehouses.helper.fetch(any, {
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
          'aa1023',
          '/tplus/BAPView/BaseInfoList.aspx?sysId=aa&mId=aa1023&pId=baseInfoList&SourceType=FromMenu&taskID=%E4%BB%93%E5%BA%93&TaskSessionID=4740a530-e508-b0d3-8196-bdae9f0bd5bf',
          'baseInfoListView',
          'undefined',
          '%E4%BB%93%E5%BA%93',
          'aa',
          'aa1023',
          'baseInfoList',
          'FromMenu',
          '4740a530-e508-b0d3-8196-bdae9f0bd5bf',
          '',
          '',
          1,
          10,
          'WarehouseDTO',
          '',
          ''
        ]
      }
    })).called(1);
  });
}
