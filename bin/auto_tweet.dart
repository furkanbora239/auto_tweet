import 'package:auto_tweet/components/get_and_save_t24_news_detail.dart';
import 'package:auto_tweet/components/save_new_news.dart';
import 'package:auto_tweet/gdocs.dart';
import "package:auto_tweet/gpt.dart" as gpt;
import 'package:auto_tweet/scraper.dart';
import 'package:auto_tweet/tweet_system.dart';

void main(List<String> arguments) async {
  print(await GSheetsApi().init());
  saveNewNewsDetails();
}

/* void saveNewNews() async {
  var sonDakika = await T24().sonDakika();
  var lastTenNews = await GSheetsApi().getLestTenNewsT24();
  comparison:
  for (int i = 0; i < lastTenNews.length; i++) {
    for (int s = 0; s < sonDakika.length; s++) {
      print(
          'başlık taranıyor ${lastTenNews[i][2]} == ${sonDakika[s]['title']}');
      if (lastTenNews[i][2] == sonDakika[s]['title']) {
        sonDakika.removeRange(s, sonDakika.length);
        print('benzer başlık bulundu');
        break comparison;
      }
    }
  }
  List<List<dynamic>> saveSonDakika = [];
  if (sonDakika.isNotEmpty) {
    for (var element in sonDakika) {
      print('yeni başlıklar listeye çevriliyor $element');
      saveSonDakika.add([
        '',
        element["time"].toString(),
        element["title"].toString(),
        element["link"].toString()
      ]);
      saveSonDakika.last.insertAll(saveSonDakika.last.length,
          await gpt.tagger(title: element['title'].toString()));
    }
  }
  if (saveSonDakika.isNotEmpty) {
    saveSonDakika.first.first = DateTime.now().toIso8601String();
    GSheetsApi().write(
        worksheet: GSheetsApi.t24SonDakikaWorkSheet,
        data: saveSonDakika.reversed.toList());
    print('yeni başlıklar docs a kaydedildi');
  }
}
 */
void saveNewNewsDetails() async {
  var newNews = await saveNewNews();
  print('saving new news');
  var flitteredNews = TweetSystem().flitterNews(news: newNews);
  print('flittering news');
  if (flitteredNews != null && flitteredNews.isNotEmpty) {
    for (var element in flitteredNews) {
      getAndSaveT24NewsDetail(row: element);
      print('saving news detail: title: ${element.first}');
    }
  }
}
