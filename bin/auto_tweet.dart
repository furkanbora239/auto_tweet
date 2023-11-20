import 'package:auto_tweet/auto_tweet.dart' as auto_tweet;
import "package:auto_tweet/gpt.dart" as gpt;

void main(List<String> arguments) async {
  print('Hello world: ${auto_tweet.calculate()}!');
  print(await gpt.makeTweet(send: "test"));
}
