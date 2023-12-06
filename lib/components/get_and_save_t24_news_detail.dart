import 'package:auto_tweet/gdocs.dart';
import 'package:auto_tweet/scraper.dart';

Future<Map<String, Object?>> getAndSaveT24NewsDetail(
    {required List<dynamic> row}) async {
  print('get end save news details is start');
  print('screp element is $row');
  Uri url = Uri.parse(row[3]);
  print('new link : $url');
  Map<String, Object?> newsDetail = await T24().haberDetay(link: url);
  print('screped data: $newsDetail');
  List<String> newsDetailList = [
    newsDetail['title'].toString(),
    newsDetail['subtitle'].toString(),
    newsDetail['date'].toString(),
    newsDetail['content'].toString(),
    newsDetail['media links'].toString(),
    newsDetail['t24 category'].toString(),
    (row.getRange(4, row.length - 1).join(" ")),
    'şimdilik boş'
  ];
  print('saving data to google sheet');
  GSheetsApi().write(
      worksheet: GSheetsApi.t24NewsDetailWorkSheet, data: [newsDetailList]);
  print('get and save news dateils is done');
  return newsDetail;
}
