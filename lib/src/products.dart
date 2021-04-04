import 'package:logging/logging.dart';
import 'package:uniform_data/page_token.dart';
import 'package:uniform_data/uniform_data.dart';

import 'requester.dart';

class Products {
  Products({this.helper});

  final Requester helper;

  final Logger _logger = Logger('TPlusProducts');

  static String insertUrl =
      '/tplus/ajaxpro/Ufida.T.AA.UIP.InventoryEdit,Ufida.T.AA.UIP.ashx?method=ExecuteAjaxAction&args.action=Save';

  ///
  Future<ProductListResponse> list(
    String part, {
    String pageToken,
    int maxResults = 30,
  }) async {
    final pageIndex = IndexPageToken.decode(pageToken, 0);
    final pageSize = maxResults ?? 30;

    final url = Uri.parse(
        '${helper.url}/tplus/ajaxpro/Ufida.T.AA.UIP.BaseInfo.InventoryList,'
        'Ufida.T.AA.UIP.ashx?method=ExecuteAjaxAction&args.action=__tree_click__');

    final params = {
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
          pageIndex,
          pageSize
        ]
      }
    };

    final results = await helper.fetch(url, params);

    final data = results['value']['Data'];

    final table = data['DataTable'];
    final fields = table[0].map((e) => e.first).toList();
    final idIndex = fields.indexOf('ID');
    final nameIndex = fields.indexOf('Name');

    final products = table[1].map<Product>((item) {
      final product = Product()
        ..kind = 'tplus#product'
        ..id = item[idIndex].toString();

      if (part.contains('snippet')) {
        product.snippet =
            (ProductSnippet()..title = item[nameIndex].toString());

        final costIndex = fields.indexOf('LatestCost');
        if (costIndex > -1) {
          final costValue = item[costIndex];
          if (costValue is int || costValue is double) {
            product.snippet.costOfGoodsSold = (Price()
              ..currency = 'RMB'
              ..value = costValue.toString());
          }
        }
      }

      if (part.contains('contentDetails')) {
        product.contentDetails = ProductContentDetails();

        final taxIndex = fields.indexOf('TaxRate_Name');
        if (taxIndex > -1) {
          var rate = item[taxIndex] ?? '0';
          if (rate.isEmpty) rate = '0';
          product.contentDetails.taxes.add(ProductTax()
            ..rate = double.parse(rate)
            ..country = 'CN');
        }

        ['priuserdefnvc', 'priuserdefdecm', 'pubuserdefnvc', 'pubuserdefdecm']
            .forEach((name) {
          List.generate(6, (e) => e).forEach((e) {
            final key = '$name${e + 1}';
            final index = fields.indexOf(key);
            final customAttribute = CustomAttribute()
              ..name = key
              ..value = index < 0 ? '' : (item[index] ?? '').toString();
            product.contentDetails.customAttributes.add(customAttribute);
          });
        });
      }

      return product;
    }).toList();

    final page = data['PagePara'];

    final response = ProductListResponse()
      ..kind = 'tplus#productListResponse'
      ..pageInfo = (PageInfo()
        ..totalResults = page['TotalCount']
        ..resultsPerPage = maxResults)
      ..items.addAll(products);

    final currentPage = page['CurrentPageNum'];
    final totalPage = page['TotalPageNum'];

    if (currentPage > 0) {
      response.prevPageToken = IndexPageToken.encode(pageIndex - 1);
    }

    if (currentPage < totalPage - 1) {
      response.nextPageToken = IndexPageToken.encode(pageIndex + 1);
    }

    return response;
  }

  /// Add product
  Future<Product> insert(Product product) async {
    final code = product.snippet.code;
    final name = product.snippet.title;
    final shortName = '';
    final categoryId =
        product.snippet.categoryId; // product.snippet.categoryId;
    //final taxRate = 13; // product.contentDetails.taxes.first.rate;
    final model = product.contentDetails.customAttributes
        .firstWhere((e) => e.name == 'model')
        .value;
    final priuserdefnvc1 = product.contentDetails.customAttributes
            .firstWhere((e) => e.name == 'priuserdefnvc1', orElse: () => null)
            ?.value ??
        '';
    final priuserdefnvc2 = product.contentDetails.customAttributes
            .firstWhere((e) => e.name == 'priuserdefnvc2', orElse: () => null)
            ?.value ??
        '';

    final url = Uri.parse('${helper.url}$insertUrl');

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
              'Code': code,
              'Name': name,
              'Shorthand': shortName,
              'Specification': model,
              'IdValueType': '199',
              'ValueType': {'Id': '199', 'Code': '01', 'Name': '移动平均'},
              'IdInventoryClass': categoryId,
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
              'priuserdefnvc1': priuserdefnvc1,
              'priuserdefnvc2': priuserdefnvc2,
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

    final results = await helper.fetch(url, params);

    try {
      final data = results['value']['Data'];
      final id = data['ID'].toString();
      return product..id = id;
    } catch (e) {
      throw Error();
    }
  }
}
