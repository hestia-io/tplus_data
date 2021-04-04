import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:uniform_data/uniform_data.dart';
import 'package:tplus_data/src/products.dart';
import 'package:tplus_data/src/requester.dart';

class MockTPlusHelper extends Mock implements Requester {}

void main() {
  var products;

  setUp(() {
    products = Products(helper: MockTPlusHelper());
  });

  test('list()', () async {
    when(products.helper.fetch(any, any)).thenAnswer((_) async => {
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
                  ['Specification', 'System.String'],
                  ['TaxRate_Name', 'System.String'],
                  ['ValueType_Name', 'System.String'],
                  ['InventoryClass_Name', 'System.String'],
                  ['ProductInfo_Name', 'System.String'],
                  ['ID', 'System.Int32'],
                  ['Unit_Name', 'System.String'],
                  ['IsLaborCost', 'System.Byte'],
                  ['priuserdefnvc1', 'System.String'],
                  ['InvSCost', 'System.Decimal'],
                  ['LatestCost', 'System.Decimal'],
                  ['MadeRecordDate', 'System.DateTime'],
                  ['InventoryPriceDTOs_LatestPPrice', 'System.Decimal'],
                  ['InventoryPriceDTOs_LatestSalePrice', 'System.Decimal'],
                  ['Madedate', 'System.DateTime'],
                  ['isSingleUnit', 'System.Byte'],
                  ['UnitGroup_Name', 'System.String'],
                  ['UnitID', 'System.Int32'],
                  ['Unit_id', 'System.Int32'],
                  ['UnitGroup_id', 'System.Int32'],
                  ['InventoryClass_id', 'System.Int32'],
                  ['Ts', 'System.String']
                ],
                [
                  [
                    '0002',
                    'testTitle0',
                    '',
                    '13.6',
                    '全月平均',
                    '',
                    null,
                    2,
                    '个',
                    0,
                    '6971821090164',
                    null,
                    656,
                    [2021, 2, 27, 0, 0, 0, 0],
                    null,
                    null,
                    [2021, 2, 27, 1, 28, 28, 157],
                    1,
                    null,
                    1,
                    1,
                    null,
                    1,
                    '0000000000913d20'
                  ],
                  [
                    '001',
                    'testTitle1',
                    '',
                    '17',
                    '全月平均',
                    '',
                    null,
                    3,
                    '个',
                    0,
                    null,
                    null,
                    '',
                    [2021, 2, 26, 0, 0, 0, 0],
                    null,
                    null,
                    [2021, 2, 26, 0, 57, 42, 693],
                    1,
                    null,
                    1,
                    1,
                    null,
                    1,
                    '000000000091205b'
                  ],
                  [
                    '1',
                    'testTitle2',
                    '',
                    '',
                    '全月平均',
                    '',
                    null,
                    4,
                    '个',
                    0,
                    null,
                    null,
                    null,
                    [2021, 2, 26, 0, 0, 0, 0],
                    null,
                    null,
                    [2021, 2, 26, 2, 12, 43, 933],
                    1,
                    null,
                    1,
                    1,
                    null,
                    1,
                    '0000000000912069'
                  ],
                ],
              ],
              'Count': 3,
              'IsSynchronized': false,
              'SyncRoot': {}
            },
            'Infomation': {}
          }
        });

    final response = await products.list('snippet,contentDetails');

    expect(response.items[0].id, '2');
    expect(response.items[0].snippet.title, 'testTitle0');
    expect(response.items[0].contentDetails.taxes.first.rate, 13.6);
    expect(response.items[0].contentDetails.taxes.first.country, 'CN');
    expect(response.items[0].contentDetails.customAttributes[0].name,
        'priuserdefnvc1');
    expect(response.items[0].contentDetails.customAttributes[0].value,
        '6971821090164');
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
    expect(response.items[0].snippet.costOfGoodsSold.value, '656');
    expect(response.items[0].snippet.costOfGoodsSold.currency, 'RMB');

    expect(response.items[1].id, '3');
    expect(response.items[1].snippet.title, 'testTitle1');
    expect(response.items[1].contentDetails.taxes.first.rate, 17.0);
    expect(response.items[1].contentDetails.taxes.first.country, 'CN');
    expect(response.items[1].contentDetails.customAttributes[0].name,
        'priuserdefnvc1');
    expect(response.items[1].contentDetails.customAttributes[0].value, '');
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
    expect(response.items[1].snippet.hasCostOfGoodsSold(), false);

    expect(response.items[2].id, '4');
    expect(response.items[2].snippet.title, 'testTitle2');
    expect(response.items[2].contentDetails.taxes.first.rate, 0.0);
    expect(response.items[2].contentDetails.taxes.first.country, 'CN');
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
    expect(response.items[2].snippet.hasCostOfGoodsSold(), false);

    expect(response.pageInfo.totalResults, 3);
    expect(response.pageInfo.resultsPerPage, 30);

    expect(response.hasPrevPageToken(), false);
    expect(response.hasNextPageToken(), false);

    when(products.helper.fetch(any, any)).thenAnswer((_) async => {
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
                  ['Specification', 'System.String'],
                  ['ValueType_Name', 'System.String'],
                  ['InventoryClass_Name', 'System.String'],
                  ['ProductInfo_Name', 'System.String'],
                  ['ID', 'System.Int32'],
                  ['Unit_Name', 'System.String'],
                  ['IsLaborCost', 'System.Byte'],
                  ['priuserdefnvc1', 'System.String'],
                  ['InvSCost', 'System.Decimal'],
                  ['LatestCost', 'System.Decimal'],
                  ['MadeRecordDate', 'System.DateTime'],
                  ['InventoryPriceDTOs_LatestPPrice', 'System.Decimal'],
                  ['InventoryPriceDTOs_LatestSalePrice', 'System.Decimal'],
                  ['Madedate', 'System.DateTime'],
                  ['isSingleUnit', 'System.Byte'],
                  ['UnitGroup_Name', 'System.String'],
                  ['UnitID', 'System.Int32'],
                  ['Unit_id', 'System.Int32'],
                  ['UnitGroup_id', 'System.Int32'],
                  ['InventoryClass_id', 'System.Int32'],
                  ['Ts', 'System.String']
                ],
                [
                  [
                    '1',
                    'testTitle2',
                    '',
                    '全月平均',
                    '',
                    null,
                    4,
                    '个',
                    0,
                    null,
                    null,
                    null,
                    [2021, 2, 26, 0, 0, 0, 0],
                    null,
                    null,
                    [2021, 2, 26, 2, 12, 43, 933],
                    1,
                    null,
                    1,
                    1,
                    null,
                    1,
                    '0000000000912069'
                  ],
                ]
              ],
              'Count': 3,
              'IsSynchronized': false,
              'SyncRoot': {}
            },
            'Infomation': {}
          }
        });

    final response2 = await products.list('', maxResults: 10);

    expect(response2.hasNextPageToken(), true);
    expect(response2.hasPrevPageToken(), true);
    expect(response2.items.first.hasSnippet(), false);
    expect(response2.items.first.hasContentDetails(), false);

    final response3 = await products.list('snippet',
        pageToken: response2.nextPageToken, maxResults: 10);
    expect(response3.items.first.hasSnippet(), true);
    expect(response3.items.first.hasContentDetails(), false);

    verify(products.helper.fetch(any, {
      'action': '__tree_click__',
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
          'HideMasker',
          'searchStyle',
          'MutexState',
          'InventoryClassId',
          'PageIndex',
          'PageSize'
        ],
        'values': [
          'aa',
          'aa1022',
          '/tplus/BAPView/BaseInfoList.aspx?sysId=aa&mId=aa1022&pId=baseInfoList&SourceType=FromMenu&taskID=%E5%AD%98%E8%B4%A7&TaskSessionID=13de7a1b-699f-a0b5-96ba-8753faacfade&HideMasker=true',
          'baseInfoListView',
          'undefined',
          '%E5%AD%98%E8%B4%A7',
          'aa',
          'aa1022',
          'baseInfoList',
          'FromMenu',
          '13de7a1b-699f-a0b5-96ba-8753faacfade',
          'true',
          '',
          '',
          'root',
          1,
          10
        ]
      }
    })).called(1);
  });

  test('insert()', () async {
    final testCode = 'testCode';
    final testTitle = 'testTitle';
    final testModel = 'testModel';
    final testPriuserdefnvc1 = 'testPriuserdefnvc1';
    final testPriuserdefnvc2 = '';
    final testProductId = 'testProductId';
    final testCategoryId = '1';

    final product = Product()
      ..snippet = (ProductSnippet()
        ..code = testCode
        ..title = testTitle
        ..categoryId = testCategoryId)
      ..contentDetails = (ProductContentDetails()
        ..customAttributes.addAll([
          CustomAttribute()
            ..name = 'model'
            ..value = testModel,
          CustomAttribute()
            ..name = 'priuserdefnvc1'
            ..value = testPriuserdefnvc1,
        ]));

    ;
    final url = Uri.parse('${products.helper.url}${Products.insertUrl}');

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
          'barCodePrintIndex',
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
          'aa1022',
          '/tplus/BAPView/BaseInfoCard.aspx?pId=baseInfoCardView&sysId=aa&mId=aa1022&NodeValue=root&NodeLevel=0',
          'baseInfoCardView',
          'undefined',
          '20b142b4-e70c-40db-a319-a3e3623cd885',
          'baseInfoCardView',
          'aa',
          'aa1022',
          'root',
          '0',
          '1',
          '',
          '',
          'False',
          '',
          '',
          {
            '__type':
                'Ufida.T.AA.DTO.InventoryDTO, Ufida.T.AA.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'type':
                'Ufida.T.AA.DTO.InventoryDTO, Ufida.T.AA.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null',
            'data': {
              'Status': 1,
              'Code': testCode,
              'Name': testTitle,
              'Shorthand': '',
              'Specification': testModel,
              'IdValueType': '199',
              'ValueType': {'Id': '199', 'Code': '01', 'Name': '移动平均'},
              'IdInventoryClass': testCategoryId,
              'IsModifiedCode': true,
              'IdTaxRate': '351',
              'TaxRate': {'Id': '351', 'Code': '02', 'Name': '13'},
              'IsNew': true,
              'Disabled': false,
              'Creater': '',
              'MadeRecordDate': '', //'2021-04-04',
              'Changer': '',
              'Changedate': '',
              'IdMarketingOrgan': 1,
              'JinShuiCode': '',
              'WithOutBargain': false,
              'IsSingleUnit': true,
              'IdUnitType': '595',
              'UnitType': {'Id': '595', 'Code': '00', 'Name': '单计量'},
              'IdUnit': 1,
              'IdUnitByStock': 1,
              'IdUnitByPurchase': 1,
              'IdUnitBySale': 1,
              'IdUnitByRetail': 1,
              'IdUnitByManufacture': 1,
              'IsPurchase': true,
              'IsSale': true,
              'IsMadeSelf': true,
              'IsMaterial': false,
              'IsLaborCost': false,
              'IsSuite': false,
              'IsMadeRequest': false,
              'IsLimitedWithdraw': false,
              'InventoryDescript': '',
              'IsQualityCheck': false,
              'priuserdefnvc1': testPriuserdefnvc1,
              'priuserdefnvc2': testPriuserdefnvc2,
              'DefaultBarCode': '',
              'IsWeigh': false,
              'IsBatch': false,
              'IsQualityPeriod': false,
              'Userfreeitem0': false,
              'MustInputFreeitem0': false,
              'ControlRangeFreeitem0': false,
              'Userfreeitem1': false,
              'MustInputFreeitem1': false,
              'ControlRangeFreeitem1': false,
              'Userfreeitem2': false,
              'MustInputFreeitem2': false,
              'ControlRangeFreeitem2': false,
              'Userfreeitem3': false,
              'MustInputFreeitem3': false,
              'ControlRangeFreeitem3': false,
              'Userfreeitem4': false,
              'MustInputFreeitem4': false,
              'ControlRangeFreeitem4': false,
              'Userfreeitem5': false,
              'MustInputFreeitem5': false,
              'ControlRangeFreeitem5': false,
              'Userfreeitem6': false,
              'MustInputFreeitem6': false,
              'ControlRangeFreeitem6': false,
              'Userfreeitem7': false,
              'MustInputFreeitem7': false,
              'ControlRangeFreeitem7': false,
              'Userfreeitem8': false,
              'MustInputFreeitem8': false,
              'ControlRangeFreeitem8': false,
              'Userfreeitem9': false,
              'MustInputFreeitem9': false,
              'ControlRangeFreeitem9': false,
              'ID': null,
              'Ts': null,
              'InvUnitPriceDTOs': {
                '__type': 'AjaxPro.DTOCollectionConverter,AjaxPro.2',
                'type': 'undefined',
                'cols': ['Status', 'Code', 'IdUnit', 'IsGroup'],
                'rows': [
                  [1, '0000', '1', 'false']
                ]
              },
              'InventoryPriceDTOs': {
                '__type': 'AjaxPro.DTOCollectionConverter,AjaxPro.2',
                'type': 'undefined',
                'cols': ['Status', 'Code', 'IdUnit'],
                'rows': [
                  [1, '0000', '1']
                ]
              },
              'ImageFile': null,
              '__type':
                  'Ufida.T.AA.DTO.InventoryDTO, Ufida.T.AA.DTO, Version=12.2.0.0, Culture=neutral, PublicKeyToken=null'
            }
          },
          'New',
          ''
        ]
      }
    };

    when(products.helper.fetch(any, any)).thenAnswer((_) async => {
          'value': {
            'Data': {'ID': testProductId}
          }
        });

    final newProduct = await products.insert(product);

    verify(products.helper.fetch(url, params)).called(1);

    expect(newProduct.id, testProductId);
  });
}
