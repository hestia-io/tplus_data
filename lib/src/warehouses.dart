import 'package:logging/logging.dart';
import 'package:uniform_data/uniform_data.dart';

import 'requester.dart';
import 'utils.dart';

class Warehouses {
  Warehouses({this.helper});

  final Requester helper;

  final Logger _logger = Logger('TPlusProducts');

  Future<WarehouseListResponse> list(
    String part, {
    String pageToken,
    int maxResults = 30,
  }) async {
    final pageIndex = decodePageToken(pageToken, 0);
    final pageSize = maxResults ?? 30;

    final url = Uri.parse(
        '${helper.url}/tplus/ajaxpro/Ufida.T.AA.UIP.WarehouseList,'
        'Ufida.T.AA.UIP.ashx?method=ExecuteAjaxAction&args.action=PageIndex');

    final params = {
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
          pageIndex,
          pageSize,
          'WarehouseDTO',
          '',
          ''
        ]
      }
    };

    final results = await helper.fetch(url, params);

    final data = results['value']['Data'];

    final table = data['DataTable'];
    final fields = table[0].map((e) => e.first).toList();
    final idIndex = fields.indexOf('ID');
    final nameIndex = fields.indexOf('Name');

    final warehouses = table[1].map<Warehouse>((item) {
      final warehouse = Warehouse()
        ..kind = 'tplus#warehouse'
        ..id = item[idIndex].toString();

      if (part.contains('snippet')) {
        warehouse.snippet =
            (WarehouseSnippet()..title = item[nameIndex].toString());
      }

      if (part.contains('contentDetails')) {
        warehouse.contentDetails = WarehouseContentDetails();
        ['priuserdefnvc', 'priuserdefdecm', 'pubuserdefnvc', 'pubuserdefdecm']
            .forEach((name) {
          List.generate(6, (e) => e).forEach((e) {
            final key = '$name${e + 1}';
            final index = fields.indexOf(key);
            final customAttribute = CustomAttribute()
              ..name = key
              ..value = index < 0 ? '' : (item[index] ?? '').toString();
            warehouse.contentDetails.customAttributes.add(customAttribute);
          });
        });
      }

      return warehouse;
    }).toList();

    final page = data['PagePara'];

    final response = WarehouseListResponse()
      ..kind = 'tplus#warehouseListResponse'
      ..pageInfo = (PageInfo()
        ..totalResults = page['TotalCount']
        ..resultsPerPage = maxResults)
      ..items.addAll(warehouses);

    final currentPage = page['CurrentPageNum'];
    final totalPage = page['TotalPageNum'];

    if (currentPage > 0) {
      response.prevPageToken = encodePageToken(pageIndex - 1);
    }

    if (currentPage < totalPage - 1) {
      response.nextPageToken = encodePageToken(pageIndex + 1);
    }

    return response;
  }
}
