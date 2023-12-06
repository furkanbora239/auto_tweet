import 'package:auto_tweet/gdocs.dart';
import 'package:auto_tweet/gpt.dart' as gpt;
import 'package:auto_tweet/scraper.dart';

Future<List<List>?> saveNewNews() async {
  print('save new news is start');
  var sonDakika = await T24().sonDakika();
  print('fach last minut news');
  var lastTenNews = await GSheetsApi().getLestTenNewsT24();
  comparison:
  for (int i = 0; i < lastTenNews.length; i++) {
    for (int s = 0; s < sonDakika.length; s++) {
      if (lastTenNews[i][2] == sonDakika[s]['title']) {
        sonDakika.removeRange(s, sonDakika.length);
        break comparison;
      }
    }
  }
  print('news comperison is done');
  List<List<String>> saveSonDakika = [];
  if (sonDakika.isNotEmpty) {
    print('${sonDakika.length} new news');
    //convert map to list
    print('tagging is start');
    for (var element in sonDakika) {
      saveSonDakika.add([
        '',
        element["time"].toString(),
        element["title"].toString(),
        element["link"].toString()
      ]);
      //add tags to list
      saveSonDakika.last.insertAll(saveSonDakika.last.length,
          await gpt.tagger(title: element['title'].toString()));
      print('tag added');
    }
    print('tagging is done');
  }
  if (saveSonDakika.isNotEmpty) {
    print('google sheets saving is start');
    saveSonDakika.first.first = DateTime.now().toIso8601String();
    GSheetsApi().write(
        worksheet: GSheetsApi.t24SonDakikaWorkSheet,
        data: saveSonDakika.reversed.toList());
    print('google sheet save is done');
    return saveSonDakika.reversed.toList();
  }
  return null;
}
