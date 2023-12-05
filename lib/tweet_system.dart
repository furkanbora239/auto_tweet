class TweetSystem {
  int minSecont = 915;

  List<List>? flitterNews({required List<List<dynamic>>? news}) {
    news?.removeWhere((element) =>
        element.contains('gereksiz') ||
        element.contains('magazin') ||
        element.contains('sanat'));
    return news;
  }
}
