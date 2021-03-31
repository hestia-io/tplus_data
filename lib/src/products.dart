import 'package:logging/logging.dart';
import 'package:uniform_data/page_token.dart';
import 'package:uniform_data/uniform_data.dart';

import 'requester.dart';

class Products {
  Products({this.helper});

  final Requester helper;

  final Logger _logger = Logger('TPlusProducts');

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
}
