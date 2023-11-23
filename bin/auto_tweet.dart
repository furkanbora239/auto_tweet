import 'package:auto_tweet/auto_tweet.dart' as auto_tweet;
import "package:auto_tweet/gpt.dart" as gpt;
import 'package:auto_tweet/scraper.dart';

void main(List<String> arguments) async {
  print(await T24().haberDetay(
      link: Uri.parse(
          'https://t24.com.tr/yazarlar/bulent-yuceturk/anayasa-mahkemesi-bahane-50-1-i-kaldirmak-sahane,42368')));
}
