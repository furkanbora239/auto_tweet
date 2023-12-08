import 'package:auto_tweet/components/save_new_news.dart';
import 'package:auto_tweet/gdocs.dart';
import 'package:auto_tweet/scraper.dart';
import 'package:auto_tweet/tweet_system.dart';

void main(List<String> arguments) async {
  print(await GSheetsApi().init());
  getNewNewsAndSaveDetails();
  /* print(await T24().haberDetay(
      link: Uri.parse(
          'https://t24.com.tr/video/turkiye-ve-dunya-gundeminde-neler-oldu-iste-bir-bakista-bugun,58286'))); */
}

/* void saveNewNewsDetails() async {
  print('save new news details is start');
  var newNews = await saveNewNews();
  if (newNews != null && newNews.isNotEmpty) {
    var flitteredNews = TweetSystem().flitterNews(news: newNews);
    print('flittering news');
    if (flitteredNews != null && flitteredNews.isNotEmpty) {
      print('flittered news : $flitteredNews');
      for (var element in flitteredNews) {
        print(element);
        getAndSaveT24NewsDetail(row: element);
        print('saving news detail: title: ${element[3]}');
      }
      print('saving news dateil is done');
    }
  }
} */

void getNewNewsAndSaveDetails() async {
  final List<List<dynamic>>? lastSavedNews = await saveNewNews();
  print(lastSavedNews?.length);
  final List<List<dynamic>>? flitteredNews =
      TweetSystem().flitterNews(news: lastSavedNews);
  print(flitteredNews?.length);
  print(flitteredNews);
  List<List<String>> saveNewsDetail = [];
  if (flitteredNews != null && flitteredNews.isNotEmpty) {
    for (var element in flitteredNews) {
      final Map<String, Object?> newDetails =
          await T24().haberDetay(link: Uri.parse(element[3]));
      print(newDetails);
      saveNewsDetail.add([
        element[3].toString(),
        newDetails['title'].toString(),
        newDetails['subtitle'].toString(),
        newDetails['date'].toString(),
        newDetails['content'].toString(),
        newDetails['media links'].toString(),
        newDetails['T24Category'].toString(),
        (element.getRange(4, element.length).join(" ")),
        'şimdilik boş'
      ]);
    }
    GSheetsApi().write(
        worksheet: GSheetsApi.t24NewsDetailWorkSheet, data: saveNewsDetail);
  }
}
