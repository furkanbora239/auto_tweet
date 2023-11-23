import 'package:auto_tweet/auto_tweet.dart' as auto_tweet;
import "package:auto_tweet/gpt.dart" as gpt;
import 'package:auto_tweet/scraper.dart';

void main(List<String> arguments) async {
  print(await T24().haberDetay(
      link: Uri.parse(
          'https://t24.com.tr/haber/avrupa-da-elektrikliler-haric-kamyon-ve-otobusler-yasaklaniyor,1139930')));
}
