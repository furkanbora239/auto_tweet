import 'package:auto_tweet/auto_tweet.dart' as auto_tweet;
import 'package:auto_tweet/gdocs.dart';
import "package:auto_tweet/gpt.dart" as gpt;
import 'package:auto_tweet/scraper.dart';

void main(List<String> arguments) async {
  print(await GSheetsApi().init());
}
