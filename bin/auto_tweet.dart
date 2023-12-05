import 'package:auto_tweet/gdocs.dart';
import "package:auto_tweet/gpt.dart" as gpt;
import 'package:auto_tweet/scraper.dart';

void main(List<String> arguments) async {
  print(await GSheetsApi().init());
  /* var sonDakika = await T24().sonDakika();
  var lastTenNews = await GSheetsApi().getLestTenNews();
  for (int i = 0; i < lastTenNews.length; i++) {
    for (int s = 0; s < sonDakika.length; s++) {
      if (lastTenNews[i][2] == sonDakika[s]['title']) {
        sonDakika.removeRange(s, sonDakika.length);
        print('sonDakika haber eşleşmesi');
        break;
      }
    }
  }
  List<List<dynamic>> saveSonDakika = [];
  for (var element in sonDakika) {
    saveSonDakika.add([
      '',
      element["time"].toString(),
      element["title"].toString(),
      element["link"].toString()
    ]);
  }
  if (saveSonDakika.isNotEmpty) {
    saveSonDakika.first.first = DateTime.now().toIso8601String();
    GSheetsApi().write(
        worksheet: GSheetsApi.t24SonDakikaWorkSheet,
        data: saveSonDakika.reversed.toList());
  } */
  saveNewNews();
  /* print(await T24().haberDetay(
      link: Uri.parse(
          'https://t24.com.tr/haber/antalya-ucusunda-yanindaki-yolcuya-zorla-oral-seks-yapan-kadin-gozaltina-alindi,1140960'))); */
}

void saveNewNews() async {
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
