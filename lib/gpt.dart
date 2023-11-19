import 'package:http/http.dart' as http;

void post({required String send}) {
  http.post(Uri.parse('uri'), headers: <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'Bearer turkcekaraktersevilmiyor'
  }, body: {
    "model": "gpt-3.5-turbo",
    "messages": [
      {"role": "system", "content": send},
      {"role": "user", "content": send}
    ],
    "temperature": 0.5
  });
}
