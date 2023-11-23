import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart';

class T24 {
  Future<List<Map<String, Object>>> sonDakika() async {
    List<Map<String, Object>> breakingNews = [];
    final http.Response response =
        await http.get(Uri.parse('https://t24.com.tr/son-dakika'));
    final Document html = Document.html(utf8.decode(response.bodyBytes));
    final List<Element> haberData =
        html.querySelectorAll('div._1N_iq > div > div._1qLBI').toList();
    for (var element in haberData) {
      final String time = element.querySelector(' a > p.jo5wf')!.text;
      final String title = element.querySelector("a > h3.u2F6W")!.text;
      final Uri link = Uri.parse(
          "https://t24.com.tr${element.querySelector('a')!.attributes['href']}");
      breakingNews.add({"time": time, "title": title, "link": link});
    }
    return breakingNews;
  }

  Future<Map<String, Object?>> haberDetay({required Uri link}) async {
    late String date;
    late String title;
    String? subtitle;
    final http.Response response = await http.get(link);
    final Document html = Document.html(utf8.decode(response.bodyBytes));
    final String croppedLink =
        link.toString().replaceFirst('https://t24.com.tr/', '');
    String content = '';
    List mediaLinks = [];
    if (croppedLink.startsWith('video')) {
      date = html
          .querySelector(
              "div._3mmXU > div._1XNyq > div._2l0_f > div > div._392lz > p")!
          .text;
      title =
          html.querySelector("div.col-md-8.col-xs-12 > div._3mmXU > h1")!.text;
      mediaLinks.add(
          link); // twitter automatically finds the video. so it is enough to use the link to the web page
      final contentData =
          html.querySelectorAll('div._3mmXU > div._1NMxy > div > p').toList();
      for (var element in contentData) {
        content += element.text;
      }
    } else if (croppedLink.startsWith('haber')) {
      date = html
          .querySelector(
              "div._1d1Rj > div > div._2l0_f > div > div._392lz > p")!
          .text;
      title = html
          .querySelector("div.col-md-8.col-xs-12 > div > div.d0FP9 > h1")!
          .text;
      subtitle = html
          .querySelector("div.col-md-8.col-xs-12 > div > div.d0FP9 > h2")!
          .text;
      final contentData =
          html.querySelectorAll('div._3QVZl > div:not(script)').toList();
      for (var element in contentData) {
        content += element.text;
        content += '\n';
      }
      final media = html.querySelectorAll('div._2hwRY > img._3xXvK');
      for (var element in media) {
        mediaLinks.add(element.attributes['src']);
      }
      print(media);
    } else if (croppedLink.startsWith('foto-haber')) {
    } else if (croppedLink.startsWith('yazarlar')) {}
    return {
      'date': date,
      'title': title,
      'subtitle': subtitle,
      'content': content.trim(),
      'mediaLinks': mediaLinks
    };
  }
}
