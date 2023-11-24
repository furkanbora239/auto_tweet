import 'package:twitter_api_v2/twitter_api_v2.dart' as v2;
import 'package:auto_tweet/secret.dart' as secret; // use yours

class TwitterApi {
  final twitter = v2.TwitterApi(
    //! Authentication with OAuth2.0 is the default.
    //!
    //! Note that to use endpoints that require certain user permissions,
    //! such as Tweets and Likes, you need a token issued by OAuth2.0 PKCE.
    //!
    //! The easiest way to achieve authentication with OAuth 2.0 PKCE is
    //! to use [twitter_oauth2_pkce](https://pub.dev/packages/twitter_oauth2_pkce)!
    bearerToken: secret.twitterApiBearerToken,

    //! Or perhaps you would prefer to use the good old OAuth1.0a method
    //! over the OAuth2.0 PKCE method. Then you can use the following code
    //! to set the OAuth1.0a tokens.
    //!
    //! However, note that some endpoints cannot be used for OAuth 1.0a method
    //! authentication.
    oauthTokens: v2.OAuthTokens(
      consumerKey: secret.twitterApiConsumerKey,
      consumerSecret: secret.twitterApiConsumerSecret,
      accessToken: secret.twitterApiAccessToken,
      accessTokenSecret: secret.twitterApiAccessTokenSecret,
    ),

    //! Automatic retry is available when network error or server error
    //! are happened.
    retryConfig: v2.RetryConfig(
      maxAttempts: 5,
      onExecute: (event) => print(
        'Retry after ${event.intervalInSeconds} seconds... '
        '[${event.retryCount} times]',
      ),
    ),

    //! The default timeout is 10 seconds.
    timeout: Duration(seconds: 20),
  );

  Future<v2.TwitterResponse<v2.UserData, void>> createTweet() async {
    return await twitter.users.lookupMe();
  }
}
