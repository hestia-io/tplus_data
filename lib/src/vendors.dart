import 'package:logging/logging.dart';
import 'package:uniform_data/uniform_data.dart';

import 'requester.dart';
import 'utils.dart';

class Vendors {
  Vendors({this.helper});

  final Requester helper;

  final Logger _logger = Logger('TPlusVendors');

  Future<VendorListResponse> list(
    String part, {
    String pageToken,
    int maxResults = 30,
  }) async {
    final pageIndex = decodePageToken(pageToken, 0);
    final pageSize = maxResults ?? 30;

    final url = Uri.parse(
        '${helper.url}/tplus/ajaxpro/Ufida.T.AA.UIP.PartnerList,'
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
          pageIndex,
          pageSize,
          'PartnerDTO',
          'Advanced',
          'PartnerList'
        ]
      }
    };

    final results = await helper.fetch(url, params);

    final data = results['value']['Data'];

    final table = data['DataTable'];
    final fields = table[0].map((e) => e.first).toList();
    final idIndex = fields.indexOf('ID');
    final nameIndex = fields.indexOf('Name');

    final vendors = table[1].map<Vendor>((item) {
      final vendor = Vendor()
        ..kind = 'tplus#vendor'
        ..id = item[idIndex].toString();

      if (part.contains('snippet')) {
        vendor.snippet = (VendorSnippet()..title = item[nameIndex].toString());
      }

      if (part.contains('contentDetails')) {
        vendor.contentDetails = VendorContentDetails();
        ['priuserdefnvc', 'priuserdefdecm', 'pubuserdefnvc', 'pubuserdefdecm']
            .forEach((name) {
          List.generate(6, (e) => e).forEach((e) {
            final key = '$name${e + 1}';
            final index = fields.indexOf('PartnerDTO_$key');
            final customAttribute = CustomAttribute()
              ..name = key
              ..value = index < 0 ? '' : (item[index] ?? '').toString();
            vendor.contentDetails.customAttributes.add(customAttribute);
          });
        });
      }

      return vendor;
    }).toList();

    final page = data['PagePara'];

    final response = VendorListResponse()
      ..kind = 'tplus#vendorListResponse'
      ..pageInfo = (PageInfo()
        ..totalResults = page['TotalCount']
        ..resultsPerPage = maxResults)
      ..items.addAll(vendors);

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
